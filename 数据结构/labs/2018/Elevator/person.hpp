/* person.hpp */
#ifndef PERSON_HPP
#define PERSON_HPP
#include <iostream>
#include <string>
#include "event.hpp"
using namespace std;
const Time PersonGetOnTime = 25 * BaseTime;
const Time PersonGetOffTime = 25 * BaseTime;
enum Direction{UP=1000, DOWN, NODIRECTION};
class Person{
	public:
		Person(){
			name = "NoName";
			fromfloor = gotofloor = 0;
			maxwaittime = timearrival = timegetoff = timegeton = timeleave = 0;
			issatisfied = istimedout = false;
			dir = NODIRECTION;
		}
		Person(string name, int from, int go, Time arr, Time maxwait){
			this->name = name;
			fromfloor = from;
			gotofloor = go;
			timearrival = arr;
			maxwaittime = maxwait;
			istimedout = false;
			issatisfied = false;
			dir = from > go ? DOWN : UP;
		}
		string name;
		int fromfloor;
		int gotofloor;
		Direction dir;
		bool istimedout;
		bool issatisfied;
		Time timearrival;
		Time timegeton;
		Time timegetoff;
		Time timeleave;
		Time maxwaittime;

};
#endif
