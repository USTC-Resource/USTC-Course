/* elevator.hpp */
#ifndef ELEVATOR_HPP
#define ELEVATOR_HPP
#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdarg>
#include <cstdio>
#include "../Lib/linklist.hpp"
#include "../Lib/queue.hpp"
#include "event.hpp"
#include "person.hpp"
using namespace std;
const int ElevatorNumber = 3;
const int FloorNumber = 7;
//const int MaxPersonNumber = 1000;
void Panic(const char*, ...);
class Building{
	public:
		Building(){
			for(int i = 1; i < FloorNumber; i++)
				persons[i] = Linklist<Person*>();
		}
		Linklist<Person*>* GetPersons(int floor){
			if(floor < 1 || floor > FloorNumber)
				Panic("No such floor");
			return persons + floor;
		}
		Linklist<Person*> persons[FloorNumber + 1];
};
class Button{
	public:
		Button(){
			BtnUp = false;
			BtnDown = false;
		}
		bool Get(Direction d) const{
			if(d == UP)
				return BtnUp;
			else if(d == DOWN)
				return BtnDown;
			else{
				Panic("No such direction");
				return false;
			}
		}
		void Press(Direction d){
			if(d == UP)
				BtnUp = true;
			else if(d == DOWN)
				BtnDown = true;
			else
				Panic("No such direction");
		}
		void Clear(Direction d){
			if(d == UP)
				BtnUp = false;
			if(d == DOWN)
				BtnDown = false;
		}
	private:
		bool BtnUp;
		bool BtnDown;
};
class FloorButton{
	public:
		FloorButton(){
			for(int i = 1; i <= FloorNumber; i++)
				btns[i] = false;
		}
		void Press(int floor){
			if(floor < 1 || floor > FloorNumber)
				Panic("No such button, fatal error");
			else
				btns[floor] = true;
		}
		void Clear(int floor){
			if(floor < 1 || floor > FloorNumber)
				Panic("No such button, fatal error");
			else
				btns[floor] = false;
		}
		bool isPressed(int floor) const{
			return btns[floor];
		}
	private:
		bool btns[FloorNumber + 1];
};
const Time ElevatorGotoNextFloorTime = 50 * BaseTime;
const Time ElevatorDoorKeepOpenTime = 40 * BaseTime;
const Time ElevatorDoorOpenTime = 20 * BaseTime;
const Time ElevatorDoorCloseTime = 20 * BaseTime;
const int ElevatorMaxPerson = 3;
const int ElevatorHomeFloor = 1;
class Elevator;
class ElevatorSystem;
class Elevator{
	public:
		Elevator();
		Elevator(int idx, ElevatorSystem* father);
		void PressFloorButton(int floor);
		//collect people, press button, then send event to close door
		void DoorOpened();
		//Door closed means totally closed and don't open for lated persons. Decide to sleep or continue to go
		void DoorClosed();
		//Dynamically decide to go to next floor
		void ArrivedNextFloor();
		//ElevSys call this function, Activate means to make this Elev to have a check, means to call ArrivedNextFloor if someone is waiting
		void Activate();
		//When elev arrived at a floor, it will judge whether to go on or stop and be idle. this func do this.
		//bool TryDeactivate();
		Time EvaluateTimeToFloor(int floor, Direction d) const;
		//No Deactivate because don't enqueue new "NextFloor" event means the elev is already not active.
		bool isFull() const;

		int index;
		ElevatorSystem* father;
		bool isactive;
		bool isdooropened;
		//the variables personnum and maxperson below SHOULD BE CHANGED TO WEIGHT,
		//an elev never how many people on it, but a weight sensor do get 
		//the total weight. let's assume one person weight one unit, and
		//i'm lazy to change all those variables
		int personnum;
		int atfloor;
		Direction dir;
		Linklist<Person*> personsonboard;
		FloorButton floorbutton;
	private:
		int maxperson;
		Time timeDoorOpen;
		Time timeDoorKeepOpen;
		Time timeDoorClose;
		Time timeGotoNextFloor;
		int homefloor;

};
class ElevatorSystem{
	public:
		ElevatorSystem();
		ElevatorSystem(Building*, EventList*);
		void PressButton(int floor, Direction d);
		int AssignElevator(int floor, Direction d);

		EventList* eventlist;
		Building* building;
		Elevator elevators[ElevatorNumber];
		//All arrays with length FloorNumber+1 don't use the first element
		Button buttons[FloorNumber + 1];
		int upassigns[FloorNumber + 1];
		int downassigns[FloorNumber + 1];
};
#endif
