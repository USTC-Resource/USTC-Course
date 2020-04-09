/* elevator.cpp */
#include <iostream>
#include <string>
#include <cmath>
#include <cstdlib>
#include <cstdarg>
#include <cstdio>
#include "elevator.hpp"
#include "person.hpp"
using namespace std;
void Panic(const char* s, ...)
{
	char sfinal[100];
	va_list ap;
	va_start(ap, s);
	vsnprintf(sfinal, 100, s, ap);
	cout << "FATAL Error: " << sfinal << "!" << endl;
	exit(-2);
}
void notify(const char* s, ...)
{
#ifdef DEBUG
	char sfinal[100];
	va_list ap;
	va_start(ap, s);
	vsnprintf(sfinal, 100, s, ap);
	string c1 = "zenity --info --text=\"";
	string c2 = "\"";
	system((c1 + sfinal + c2).c_str());
#endif
}
ElevatorSystem::ElevatorSystem()
{
	cout << "Default constructor will never work, please give parameters" << endl;
}
ElevatorSystem::ElevatorSystem(Building* building, EventList* elist)
{
	this->eventlist = elist;
	this->building = building;
	for(int i = 0; i < ElevatorNumber; i++)
		elevators[i] = Elevator(i, this);
	for(int i = 1; i <= FloorNumber; i++){
		upassigns[i] = -1;
		downassigns[i] = -1;
		buttons[i] = Button();
	}
}
void ElevatorSystem::PressButton(int floor, Direction d)
{
	if(this->buttons[floor].Get(d))
		//Already pressed, do nothing
		return;
	//Assign this press to the nearest elevator and activate it
	this->buttons[floor].Press(d);
	int elevindex = this->AssignElevator(floor, d);
	//cout << "E:" << elevindex << endl;
	//cin.get();
	if(d == UP)
		upassigns[floor] = elevindex;
	else if(d == DOWN)
		downassigns[floor] = elevindex;
	else
		Panic("Pressed and idle button");
	//Another bug corpse here. If activate several times, a disaster will happen
	if(!elevators[elevindex].isactive){
		//cout << "elev " << elevindex << " now begin working by elevsys" << endl;
		//cin.get();
		elevators[elevindex].Activate();
	}
}
int ElevatorSystem::AssignElevator(int floor, Direction d)
{
	//TODO: actually, if several elevator take (evaluated) same time to the given position, then a random index between them should be given to balance wear off in Physical World. 
	//In this program just pick the first one. (change < to <= to choose the last one)
	int minelevidx = -1;
	Time mintimeused = Inf;
	Time timeused;
	for(int i = 0; i < ElevatorNumber; i++){
		timeused = elevators[i].EvaluateTimeToFloor(floor, d);
		if(timeused < mintimeused){
			minelevidx = i;
			mintimeused = timeused;
		}
	}
	notify("AssignElevator %d.", minelevidx);
	return minelevidx;
}

Elevator::Elevator()
{
	//cout << "an Elevator should belong to an ElevatorSystem and should not be defined explicitly" << endl;
}
Elevator::Elevator(int idx, ElevatorSystem* father)
{
	this->index = idx;
	this->father = father;
	this->isactive = false;
	this->isdooropened = false;
	this->personnum = 0;
	this->atfloor = 1;
	this->dir = NODIRECTION;
	this->personsonboard = Linklist<Person*>();
	this->floorbutton = FloorButton();
	this->maxperson = ElevatorMaxPerson;
	this->homefloor = ElevatorHomeFloor;
	this->timeGotoNextFloor = ElevatorGotoNextFloorTime;
	this->timeDoorOpen = ElevatorDoorOpenTime;
	this->timeDoorClose = ElevatorDoorCloseTime;
	this->timeDoorKeepOpen = ElevatorDoorKeepOpenTime;
}
//This func is NOT GOOD ENOUGH, some small points NOT CONSIDIRED
//but it can work
Time Elevator::EvaluateTimeToFloor(int floor, Direction d) const
{
	if(!this->isactive)
		return this->timeGotoNextFloor * fabs(floor - this->atfloor);
	int maxfloor = this->atfloor;
	int minfloor = this->atfloor;
	int dooropentimes = 0;
	//up to top, then down to bottom, and then (up or down without stop) to fetch new person
	if(this->dir == UP && d == UP && atfloor >= floor){
		for(int i = atfloor; i <= FloorNumber; i++)
			if(father->buttons[i].Get(UP) || this->floorbutton.isPressed(i)){
				maxfloor = i;
				dooropentimes++;
			}
		for(int i = maxfloor; i >= 1; i--)
			//use && to avoid recount dooropentimes
			if(father->buttons[i].Get(DOWN) || (this->floorbutton.isPressed(i) && i < atfloor)){
				minfloor = i;
				dooropentimes++;
			}
		//only one of the two following cases will be executed
		for(int i = minfloor; i < floor; i++)
			if(father->buttons[i].Get(UP))
				dooropentimes++;
		for(int i = minfloor; i > floor; i--)
			if(father->buttons[i].Get(DOWN))
				dooropentimes++;
		return this->timeGotoNextFloor * (maxfloor - this->atfloor + maxfloor - minfloor + fabs(floor - minfloor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}
	//up(or then down after) and fetch person
	if(this->dir == UP && d == UP && this->atfloor < floor){
		for(int i = this->atfloor; i <= floor; i++)
			if(this->father->buttons[i].Get(UP) || this->floorbutton.isPressed(i))
				dooropentimes++;
		return this->timeGotoNextFloor * fabs(floor - this->atfloor) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}
	//up to top and down to fetch person
	if(this->dir == UP && d == DOWN){
		for(int i = this->atfloor; i <= FloorNumber; i++)
			if(this->father->buttons[i].Get(UP) || this->floorbutton.isPressed(i)){
				maxfloor = i;
				dooropentimes++;
			}
		for(int i = maxfloor; i >= floor; i--)
			if(this->father->buttons[i].Get(DOWN) || (this->floorbutton.isPressed(i) && i < atfloor))
				dooropentimes++;
		return this->timeGotoNextFloor * (maxfloor - this->atfloor + fabs(maxfloor - floor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}
	//down cases, the same
	if(this->dir == DOWN && d == DOWN && atfloor <= floor){
		for(int i = atfloor; i >= 1; i--)
			if(father->buttons[i].Get(DOWN) || this->floorbutton.isPressed(i)){
				minfloor = i;
				dooropentimes++;
			}
		for(int i = minfloor; i <= FloorNumber; i++)
			//use && to avoid recount dooropentimes
			if(father->buttons[i].Get(UP) || (this->floorbutton.isPressed(i) && i > atfloor)){
				maxfloor = i;
				dooropentimes++;
			}
		//only one of the two following cases will be executed
		for(int i = maxfloor; i > floor; i--)
			if(father->buttons[i].Get(DOWN))
				dooropentimes++;
		for(int i = maxfloor; i < floor; i++)
			if(father->buttons[i].Get(UP))
				dooropentimes++;
		return this->timeGotoNextFloor * (maxfloor - this->atfloor + maxfloor - minfloor + fabs(floor - minfloor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}
	if(this->dir == DOWN && d == DOWN && this->atfloor > floor){
		for(int i = this->atfloor; i >= floor; i--)
			if(this->father->buttons[i].Get(DOWN) || this->floorbutton.isPressed(i))
				dooropentimes++;
		return this->timeGotoNextFloor * fabs(floor - this->atfloor) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}
	if(this->dir == DOWN && d == UP){
		for(int i = this->atfloor; i >= 1; i--)
			if(this->father->buttons[i].Get(DOWN) || this->floorbutton.isPressed(i)){
				minfloor = i;
				dooropentimes++;
			}
		for(int i = minfloor; i <= floor; i++)
			if(this->father->buttons[i].Get(UP) || (this->floorbutton.isPressed(i) && i > atfloor))
				dooropentimes++;
		return this->timeGotoNextFloor * (maxfloor - this->atfloor + fabs(maxfloor - floor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	}

	////down to btm, up to top, and then (up or down without stop) to fetch person
	//if(this->dir == DOWN && d == DOWN && this->atfloor <= floor){
		//for(int i = this->atfloor; i >= 1; i--)
			//if((this->father->downassigns[i] == this->index && this->father->buttons[i].Get(DOWN)) || this->floorbutton.isPressed(i)){
				//minfloor = i;
				//dooropentimes++;
			//}
		//for(int i = minfloor; i <= FloorNumber; i++)
			//if((this->father->upassigns[i] == this->index && this->father->buttons[i].Get(UP)) || this->floorbutton.isPressed(i)){
				//maxfloor = i;
				//dooropentimes++;
			//}
		//return this->timeGotoNextFloor * (this->atfloor - minfloor + maxfloor - minfloor + fabs(maxfloor - floor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;

	//}
	////down and fetch, or down to bottom and up again without stop to fetch
	//if(this->dir == DOWN && d == DOWN && this->atfloor > floor){
		//for(int i = this->atfloor; i >= floor; i--)
			//if((this->father->downassigns[i] == this->index && this->father->buttons[i].Get(DOWN)) || this->floorbutton.isPressed(i))
				//dooropentimes++;
		//return this->timeGotoNextFloor * (this->atfloor - floor) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	//}
	////down to btm and up(or still down but without stop) to fetch person
	//if(this->dir == DOWN && d == UP){
		//for(int i = this->atfloor; i >= 1; i--)
			//if((this->father->downassigns[i] == this->index && this->father->buttons[i].Get(DOWN)) || this->floorbutton.isPressed(i)){
				//minfloor = i;
				//dooropentimes++;
			//}
		//for(int i = minfloor; i <= floor; i++)
			//if((this->father->upassigns[i] == this->index && this->father->buttons[i].Get(UP)) || this->floorbutton.isPressed(i))
				//dooropentimes++;
		//return this->timeGotoNextFloor * (this->atfloor - minfloor + fabs(floor - minfloor)) + (timeDoorOpen + timeDoorKeepOpen + timeDoorClose) * dooropentimes;
	//}
	//This shouldn't be reached
	Panic("error when evaluating");
	return Inf;
}
void Elevator::PressFloorButton(int floor)
{
	this->floorbutton.Press(floor);
	//this->Activate();
}
//also a func with recursive call, the func means things happened when 
//elev door is opened, person get off and get on ONE BY ONE
//LOW TIME PERFORMANCE WARNING!
void Elevator::DoorOpened()
{
	this->isdooropened = true;
	Person* p;
	EventCase e;
	//dump persons
	//judge first to increase some time performance
	if(this->floorbutton.isPressed(atfloor)){
		int l = personsonboard.GetLength();
		for(int i = 1; i <= l; i++){
			personsonboard.GetElem(i, p);
			if(p->gotofloor == atfloor){
				this->personnum--;
				p->timegetoff = father->eventlist->GetTime();
				e = EventCase(PersonGetOffTime, "Person", "GetOff", p);
				father->eventlist->EnqEvent(e);
				e = EventCase(PersonGetOffTime, "Elevator", "DoorOpened", this);
				father->eventlist->EnqEvent(e);
				//note that the delete caused length to change, but then
				//the func returns, so no bug
				personsonboard.ListDelete(i, p);
				//Handle one by one
				return;
			}
		}
	}
	//clear floor button, this is executed only after all persons got off
	this->floorbutton.Clear(atfloor);
	//collect persons
	//automatic stop collecting and go on when elev is full or all collected
	int l = father->building->persons[atfloor].GetLength();
	//first remove all unpatiently left persons
	for(int i = l; i >= 1; i--){
		father->building->persons[atfloor].GetElem(i, p);
		if(p->istimedout)
			father->building->persons[atfloor].ListDelete(i, p);
	}
	//re-calc length
	l = father->building->persons[atfloor].GetLength();
	for(int i = 1; i <= l && !this->isFull(); i++){
		father->building->persons[atfloor].GetElem(i, p);
		//the person has already left? And only collect people on this dir
		if(p->dir == this->dir){
			//if(!p->istimedout){
			this->personnum++;
			this->personsonboard.Append(p);
			this->PressFloorButton(p->gotofloor);
			p->timegeton = father->eventlist->GetTime();
			e = EventCase(PersonGetOnTime, "Person", "GetOn", p);
			father->eventlist->EnqEvent(e);
			//}
			father->building->persons[atfloor].ListDelete(i, p);
			e = EventCase(PersonGetOnTime, "Elevator", "DoorOpened", this);
			father->eventlist->EnqEvent(e);
			return;
		}
	}
	//Clear buttons, moved to DoorClosed to avoid clear twice
	for(int i = 1; i <= l; i++){
		father->building->persons[atfloor].GetElem(i, p);
		if(!p->istimedout && p->dir == this->dir){
			//father->buttons[atfloor].Press(this->dir);
			father->PressButton(atfloor, this->dir);
			//cout << father->downassigns[atfloor]<< endl;
			//cout << "Re-pressed";cin.get();
			break;
		}
	}
	//If the func goes here without return, 
	//then all persons are satisfied and continue to move on
	//door should now close
	e = EventCase(timeDoorKeepOpen, "Elevator", "DoorClosed", this);
	father->eventlist->EnqEvent(e);
}
//Door closed, continue moving or stay still
void Elevator::DoorClosed()
{
	this->isdooropened = false;
	//seems too simple to be right, but i think it's OK
	//And assigns must be cleared ASAP because many judgements depend on this
	if(this->dir == UP)
		father->upassigns[this->atfloor] = -1;
	if(this->dir == DOWN)
		father->downassigns[this->atfloor] = -1;
	Person* p = NULL;
	int l = father->building->persons[atfloor].GetLength();
	//Clear btn even if some not satisfied, 
	//and then re-press btn if someone left, to let elev sys to reassign a elev. 
	//Because a mere elev don't know whether all persons had got on without overload.
	father->buttons[atfloor].Clear(this->dir);
	for(int i = 1; i <= l; i++){
		father->building->persons[atfloor].GetElem(i, p);
		if(!p->istimedout && p->dir == this->dir){
			father->PressButton(atfloor, this->dir);
			//cout << father->downassigns[atfloor]<< endl;
			//cout << "Re-pressed";cin.get();
			break;
		}
	}
	this->Activate();
}
void Elevator::ArrivedNextFloor()
{
	////if door should open at the floor, then enqueue DoorOpened
	////if continue moving without stop, then activate and decide what to do
	//all action moved into Activate function
	if(this->dir == UP){
		if(atfloor == FloorNumber)
			Panic("the elev is flying up into sky");
		this->atfloor++;
		////Just pass by without stop if full
		//if((father->upassigns[atfloor] == index && !isFull()) || this->floorbutton.isPressed(atfloor)){
			//EventCase e = EventCase(this->timeDoorOpen, "Elevator", "DoorOpened", this);
			//this->father->eventlist->EnqEvent(e);
			//return;
		//}
	}
	if(this->dir == DOWN){
		if(atfloor == 1)
			Panic("the elev is drilling into underground");
		this->atfloor--;
		//if((father->downassigns[atfloor] == index && !isFull()) || this->floorbutton.isPressed(atfloor)){
			//EventCase e = EventCase(this->timeDoorOpen, "Elevator", "DoorOpened", this);
			//this->father->eventlist->EnqEvent(e);
			//return;
		//}

	}
	if(this->dir == NODIRECTION)
		Panic("arrived at new floor when idle? some thing when wrong");
	//cout << "ArrivedNextFloor: " << atfloor << endl;
	this->Activate();
}
//This is a single elev Main Ctrl Function
//Decide what to do next, considering all possible conditions
//Be called frequently
void Elevator::Activate()
{
	//Point: down and up assigns array is at same status with button[].Get, but
	//we assume that an elev should do it's own work without bothering others, but when
	//it comes that it just pass by other floor, it will also open the door if this floor need
	//to be served, even if the floor's job is not assigned to this elev.
	
	notify("Activate elev %d...", this->index);
	//First, have a judge of need to up or need to down
	bool isneedtoup = false;
	bool isneedtodown = false;
	for(int i = atfloor + 1; i <= FloorNumber; i++)
		//even if an upper floor need down, then the elev still need up, *sooner or later*
		if(father->downassigns[i] == index || father->upassigns[i] == index || floorbutton.isPressed(i)){
		//Fatal algorithm bug killed here!! Here is a bug's corpse
		//if((father->buttons[i].Get(UP) && father->upassigns[i] == index) || floorbutton.isPressed(i)){
			isneedtoup = true;
			break;
		}
	for(int i = 1; i <= atfloor - 1; i++)
		if(father->upassigns[i] == index || father->downassigns[i] == index || floorbutton.isPressed(i)){
			isneedtodown = true;
			break;
		}
	//Should stop at this floor.
	//another another bug corpse here. elev may pass a floor even if btn on this floor is pressed
	//At this floor, first judge whether to change direction(important), then open door and start working
	//if((father->upassigns[atfloor] == index && !(this->dir == DOWN && isneedtodown) && !isFull()) || 
			//(father->downassigns[atfloor] == index && !(this->dir == UP && isneedtoup) && !isFull()) || 
	if((father->buttons[atfloor].Get(UP) && !(this->dir == DOWN && isneedtodown) && !isFull()) || \
			(father->buttons[atfloor].Get(DOWN) && !(this->dir == UP && isneedtoup) && !isFull()) || \
			floorbutton.isPressed(atfloor)){
		//It's time to change direction?
		//Change dir: now up, no need to up further, on this floor no UP pressed, 
		//and DOWN MUST BE PRESSED, or means error HAD occured, because the elev SHOULDN'T HAVE GONE to this floor
		//But, but, when executed here, downassigns (or upassigns) HAD BEEN Cleared!!
		//if(this->dir == UP && father->downassigns[atfloor] == index && father->upassigns[atfloor] != index && !isneedtoup){
		//if(this->dir == UP && !(father->upassigns[atfloor] == index) && !isneedtoup){
		if(this->dir == UP && !(father->buttons[atfloor].Get(UP)) && !isneedtoup){
			this->dir = DOWN;
		}
		//if(this->dir == DOWN && father->upassigns[atfloor] == index && father->downassigns[atfloor] != index && !isneedtodown){
		//if(this->dir == DOWN && !(father->downassigns[atfloor] == index) && !isneedtodown){
		if(this->dir == DOWN && !(father->buttons[atfloor].Get(DOWN)) && !isneedtodown){
			this->dir = UP;
		}
		//start working from idle when a person precisely come to the floor the elev resting at
		if(this->dir == NODIRECTION){
			//if(father->upassigns[atfloor] == index)
			if(father->buttons[atfloor].Get(UP))
				this->dir = UP;
			//if(father->downassigns[atfloor] == index)
			if(father->buttons[atfloor].Get(DOWN))
				this->dir = DOWN;
		}
		EventCase e = EventCase(this->timeDoorOpen, "Elevator", "DoorOpened", this);
		this->father->eventlist->EnqEvent(e);
		return;
	}
	//no work, be idle no matter was idle or busy
	//(no need to up, no need to down. executed here means no need to open door)
	if(!isneedtoup && !isneedtodown){
		this->dir = NODIRECTION;
		this->isactive = false;
		//cout << "be idle";
		//for(int i = 1; i <= FloorNumber; i++)
			//cout << father->upassigns[i] << " " << father->downassigns[i] << endl;
		//cin.get();
		return;
	}
	//was moving and continue moving in old direction
	//the most simple case
	if(this->isactive){
		if((this->dir == UP && isneedtoup) || (this->dir == DOWN && isneedtodown)){
			//cout << "continu to next floooooooooooooooooooooooooor" << endl;
			//cin.get();
			EventCase e = EventCase(this->timeGotoNextFloor, "Elevator", "ArrivedNextFloor", this);
			this->father->eventlist->EnqEvent(e);
			return;
		}
	}
	//was idle and should start moving
	else{
		if(isneedtoup){
			//cout << "up to next floooooooooooooooooooooooooor" << endl;
			//cin.get();
			this->dir = UP;
			this->isactive = true;
			EventCase e = EventCase(this->timeGotoNextFloor, "Elevator", "ArrivedNextFloor", this);
			this->father->eventlist->EnqEvent(e);
			return;
		}
		else if(isneedtodown){
			//cout << "down to next floooooooooooooooooooooooooor" << endl;
			//cin.get();
			this->dir = DOWN;
			this->isactive = true;
			EventCase e = EventCase(this->timeGotoNextFloor, "Elevator", "ArrivedNextFloor", this);
			this->father->eventlist->EnqEvent(e);
			return;
		}
		else
			Panic("wrong ctrl flow in Activate");
	}
	Panic("Nothing done in Activate. Another wrong ctrl flow in Activate");
}
bool Elevator::isFull() const
{
	return personnum >= maxperson;
}
