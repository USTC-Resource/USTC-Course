/* main.cpp for Elevator Simulation Program */
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <cstdlib>
#include <unistd.h>
#include "../Lib/queue.hpp"
#include "../SimpleDraw/SimpleDraw.hpp"
#include "event.hpp"
#include "elevator.hpp"
#include "person.hpp"
using namespace std;

//void test_queue()
//{
	//Queue<int> q;
	//int d;
	//q.Enqueue(1);
	//q.Enqueue(-3);
	//q.Enqueue(5);
	//q.Enqueue(4);
	//q.Enqueue(4);
	//q.Enqueue(3);
	//q.Enqueue(-1);
	//Node<int>* p;
	//p = q.head;
	//while((p = p->next))
		//cout << p->data << endl;
	//q.Dequeue(d);
	//cout << "---" << endl;
	//cout << d << endl;
	//q.Dequeue(d);
	//cout << d << endl;
	//q.Dequeue(d);
	//cout << d << endl;
	//cout << "---" << endl;
	//p = q.head;
	//while((p = p->next))
		//cout << p->data << endl;
	//cout << "---" << endl;
	//q.Enqueue(-5);
	//q.Enqueue(15);
	//cout << "---" << endl;
	//p = q.head;
	//while((p = p->next))
		//cout << p->data << endl;
	//cout << "---" << endl;
	//q.Dequeue(d);
	//cout << d << endl;
	//q.Dequeue(d);
	//cout << d << endl;
	//cout << "---" << endl;

//}
/*
graphics!
n floors, m elevs
1      +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+
2      |Time: 000.0s                                  |
3      |==============================================|
-1+5*1/| 5                 +-----+                    |
5    / |                   |DOWN |                    |
6    | |          UP       |1    |                    |
7    \ |->        DOWN     |@    |                  ->|
8     \|===================+-----+=-------=-------====|
-1+5*2 | 4                                            |
       |                                              |
       |          UP                                  |
       |-> @@@@@@<DOWN>                             ->|
       |===================-------=-------=-------====|
       | 3                                            |
       |                                              |
       |          UP                                  |
       |->        DOWN                              ->|
       |===================-------=-------=-------====|
       | 2                         +-----+            |
       |                           |UP   |            |
       |         <UP>               9                 |
       |->      @ DOWN              @@@@@           ->|
       |===================-------=+-----+=-------====|
-1+5*n | 1                                 +-----+    |       
       |                                   |IDLE |    |       
       |          UP                       |0    |    |       
       |->        DOWN                     |     |  ->|       
       |===================-------=-------=+-----+====|
4+5*n  +==============================================+
rows = 4+5*n

one floor, row start from -1+5*n
| 5                 +-----+                    |
|                   |DOWN |                    |
|         <UP>      |11   |                    |
|->@@@@@@@<DOWN>    |@@@@@|                  ->|
+===================+-----+=-------=-------====+
123456789012345678901234567890123456789012345678
 23       1234567   1234567 9012345 7890123     
col: 
1 Wall
2,3 ->
4-10 @
11-16 <UP><DOWN>

row -1+5*n to -1+5*n+4
col 21 to 27 elev_1
col 21-8+8*m to 27-8+8*m

21+8*m + 3, 21+8*m + 4 ->
21+8*m + 5 Wall
 */
void err_notify(const char* s)
{
	cout << "in err main" << endl;
	string c1 = "zenity --info --text=\"Error:";
	string c2 = "\"";
	cout << (c1 + string(s) + c2).c_str() << endl;
	system((c1 + string(s) + c2).c_str());
}
void UpdateScreen(SimpleCanvas& cvs, const Building& building, const ElevatorSystem& es, Time t)
{
	int n = FloorNumber;
	int m = ElevatorNumber;
	int colmax = 21+8*m+5;
	int rowmax = 4+5*n;
	cvs.ClearCanvas();
	cvs.AddRowLine(1, 1, colmax, '~');
	cvs.AddRowLine(3, 1, colmax, '=');
	cvs.AddRowLine(rowmax, 1, colmax, '=');
	cvs.AddColLine(1, 1, rowmax, '|');
	cvs.AddColLine(colmax, 1, rowmax, '|');
	cvs.AddRowLine(4+5*n, 1, colmax, '=');
	cvs.AddChar('+', 1, 1);
	cvs.AddChar('+', 1, colmax);
	cvs.AddChar('+', rowmax, 1);
	cvs.AddChar('+', rowmax, colmax);
	//Draw Time
	cvs.AddString("Time: %.1fs", 2, 2, t);
	for(int i = 1; i <= n; i++){
		int thisfloor = n + 1 - i;
		int row0 = -1+5*i;
		//Draw floor ground
		cvs.AddRowLine(row0+4, 2, colmax - 1, '=');
		//Draw '->' symbol
		cvs.AddString("->", row0+3, 2);
		cvs.AddString("->", row0+3, colmax-2);
		//Draw floor number
		cvs.AddString("%d", row0, 3, thisfloor);
		//Draw persons waiting, red color for left person
		Node<Person*>* p = building.persons[thisfloor].head;
		int j = 0;
		while((p = p->next) && ++j <= 7){
			if(p->data->istimedout)
				cvs.ChangeColor("Red");
			else
				cvs.ChangeColor("Green");
			cvs.AddChar('@', row0 + 3, 11 - j);
			cvs.ChangeColor("No");
		}
		//Draw UP and DOWN btn
		if(es.buttons[thisfloor].Get(UP)){
			cvs.ChangeColor("Yellow");
			cvs.AddString("<UP>", row0+2, 11);
			cvs.ChangeColor("No");
		}
		else{
			cvs.AddString(" UP ", row0+2, 11);
		}
		if(es.buttons[thisfloor].Get(DOWN)){
			cvs.ChangeColor("Yellow");
			cvs.AddString("<DOWN>", row0+3, 11);
			cvs.ChangeColor("No");
		}
		else{
			cvs.AddString(" DOWN ", row0+3, 11);
		}
		//Draw each elev
		for(int j = 0; j < m; j++){
			//Draw elev well
			cvs.AddRowLine(row0+4, 21+8*j, 21+8*j+6, '-');
			if(es.elevators[j].atfloor == thisfloor){
				//Draw elevator
				cvs.ChangeColor("White");
				cvs.AddRectangle(row0, 21+8*j, row0+4, 21+8*j+6, '|', '-', '+');
				cvs.ChangeColor("No");
				//Draw opened door
				if(es.elevators[j].isdooropened){
					cvs.AddColLine(21+8*j, row0+2, row0+3, ' ');
					cvs.AddColLine(21+8*j+6, row0+2, row0+3, ' ');
				}
				//Draw elev people num, red for full
				int personsonboardnum = es.elevators[j].personnum;
				//int personsonboardnum = es.elevators[j].personsonboard.length;
				if(es.elevators[j].isFull())
					cvs.ChangeColor("Red");
				cvs.AddString("%d", row0+2, 21+8*j+1, personsonboardnum);
				cvs.ChangeColor("No");
				//Draw person in eev
				cvs.ChangeColor("Green");
				for(int k = 1; k <= personsonboardnum && k <= 5; k++)
					cvs.AddChar('@', row0+3, 21+8*j+k);
				cvs.ChangeColor("No");
				//Draw elev direction
				if(es.elevators[j].dir == UP)
					cvs.AddString("UP", row0+1, 21+8*j+1);
				else if(es.elevators[j].dir == DOWN)
					cvs.AddString("DOWN", row0+1, 21+8*j+1);
				else
					cvs.AddString("IDLE", row0+1, 21+8*j+1);
			}
		}
	}
	cvs.Show(false);
}
//Use this to refresh at tictime freq when no event is happening
//avoid frozen the TUI
void tictoc(EventList& el, Time tictime)
{
	EventCase e = EventCase(tictime, "System", "Tic", NULL);
	el.EnqEvent(e);
}
const Time TerminateTime = 300;
const Time StartTime = 0;
const Time RefreshTime = .333;
const double PlayRate = 8.0;
const bool isTUI = true;
int main()
{
	//Main facilities
	EventList elist = EventList(StartTime);
	Building building;
	ElevatorSystem es = ElevatorSystem(&building, &elist);
	Linklist<Person> personslist;
	cout << "Facilities ready." << endl;

	//TUI stuffs
	int drawrow = 4 + 5 * FloorNumber;
	int drawcol = 21 + 8 * ElevatorNumber + 5;
	SimpleCanvas cvs = SimpleCanvas(drawrow, drawcol);
	cvs.ChangeColor("No");
	cout << "Simple draw ready." << endl;

	//initialize personslist by reading from file
	Person per;
	int personnum;
	string name;
	int from;
	int go;
	Time arr;
	Time maxwait;
	ifstream input;
	input.open("./persons.txt");
	if(input.fail()){
		cout << "Error opening file!" << endl;
		return -1;
	}
	input >> personnum;
	for(int i = 1; i <= personnum; i++){
		input >> name >> from >> go >> arr >> maxwait;
		if(input.bad()){
			cout << "Error reading file!" << endl;
			return -1;
		}
		cout << "Person " << i << ": " << endl;
		cout << name << endl;
		cout << from << endl;
		cout << go << endl;
		cout << arr << endl;
		cout << maxwait << endl;
		per = Person(name, from, go, arr, maxwait);
		personslist.Append(per);
	}
	input.close();
	cout << "Persons file read successfully." << endl;

	string empty = "";

	Node<Person>* p = personslist.head;
	EventCase e;
	EventCase f;
	//Initialization
	//Enqueue all people get in event
	//Use raw ->next because we need pointers instead of copied objects
	for(int i = 1; i <= personslist.length; i++){
		p = p->next;
		e = EventCase(p->data.timearrival, "Person", "Arrived", &p->data);
		elist.EnqEvent(e);
	}
	//enqueue terminate event
	e = EventCase(TerminateTime, "System", "Terminate", NULL);
	elist.EnqEvent(e);
	Time oldtime = 0;
	Time curtime = 0;
	//Set up periodic refresh
	tictoc(elist, RefreshTime);
	//Start main loop
	cout << "Start simlation. " << endl;
	cout << ElevatorNumber << " elevator(s), " << FloorNumber << " floor(s), " << personslist.GetLength() << " person(s). " << endl;
	cout << "Press to start..."; cin.get();
	usleep(1e6 / PlayRate);
	while(elist.DeqEvent(e) != ERROR){
		oldtime = elist.GetTime();
		elist.FastForward(e.occurtime);
		curtime = elist.GetTime();
		if(isTUI){
			UpdateScreen(cvs, building, es, curtime);
			//Print debug queue info
			//cout << curtime << endl;
			//Node<EventCase>* p = elist.head;
			//while((p = p->next)){
				//cout << p->data.occurtime << "\t" << p->data.obj << "\t" << p->data.cmd << endl;
			//}
			usleep(1e6 * (curtime - oldtime) / PlayRate);
		}
		if(e.obj == "System"){
			if(e.cmd == "Terminate"){
				cout << "Simulation end time arrived. Exit." << endl;
				break;
			}
			else if(e.cmd == "Tic"){
				tictoc(elist, RefreshTime);
			}
			//else if(e.cmd == "Start"){
				//cout << "Start simlation. " << endl;
				//cout << ElevatorNumber << " elevators, " << FloorNumber << " floors. " << endl;
				//sleep(1);
			//}
			else err_notify((empty + "No such event cmd " + e.cmd + " in obj " + e.obj).c_str());
		}
		else if(e.obj == "Elevator"){
			if(e.cmd == "ArrivedNextFloor"){
				static_cast<Elevator*>(e.ptr)->ArrivedNextFloor();
			}
			else if(e.cmd == "DoorOpened"){
				static_cast<Elevator*>(e.ptr)->DoorOpened();
			}
			else if(e.cmd == "DoorClosed"){
				static_cast<Elevator*>(e.ptr)->DoorClosed();
			}
			else err_notify((empty + "No such event cmd " + e.cmd + " in obj " + e.obj).c_str());
		}
		else if(e.obj == "Person"){
			if(e.cmd == "Arrived"){
				Person* p = static_cast<Person*>(e.ptr);
				p->timearrival = elist.GetTime();
				building.persons[p->fromfloor].Append(p);
				es.PressButton(p->fromfloor, p->dir);
				//Enqueue the person leave angrily event, but if person is satisfied, 
				//the event will just be ignored
				f = EventCase(p->maxwaittime, "Person", "Leave", p);
				elist.EnqEvent(f);
			}
			else if(e.cmd == "GetOn"){
				static_cast<Person*>(e.ptr)->timegeton = curtime;
			}
			else if(e.cmd == "GetOff"){
				static_cast<Person*>(e.ptr)->timegetoff = curtime;
				static_cast<Person*>(e.ptr)->timeleave = curtime;
			}
			else if(e.cmd == "Leave"){
				//mark timed out here, but keep person in queue
				//and the person will be ignored when persons entering elev
				static_cast<Person*>(e.ptr)->istimedout = true;
				static_cast<Person*>(e.ptr)->timeleave = curtime;
			}
			else err_notify((empty + "No such event cmd " + e.cmd + " in obj " + e.obj).c_str());
		}
		else{
			err_notify((empty + "No such event object: " + e.obj).c_str());
		}
	}
	cout << "End. " << endl;
	return 0;
}

