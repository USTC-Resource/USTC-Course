/* event.hpp */
#ifndef EVENT_HPP
#define EVENT_HPP
#include <iostream>
#include <string>
#include "../Lib/queue.hpp"
using namespace std;
typedef double Time;
const Time BaseTime = .1;
class EventCase{
	public:
		EventCase(){
			delaytime = -1;
			occurtime = -1;
			obj = "";
			cmd = "";
			ptr = NULL;
		}
		//Event will happen after delaytime, occurtime and endtime will be handled by EventList
		EventCase(Time t, string o, string c, void* p){
			delaytime = t;
			occurtime = -1;
			obj = o;
			cmd = c;
			ptr = p;
		}
		Time delaytime;
		Time occurtime;
		string obj;
		string cmd;
		void* ptr;
};
inline bool operator<(const EventCase& e1, const EventCase& e2){
	return e1.occurtime < e2.occurtime ? true : false;
}
class EventList: public Queue<EventCase> {
	public:
		EventList(){
			curtime = 0;
		}
		EventList(Time t_init){
			curtime = t_init;
		}
		Status EnqEvent(EventCase& e){
			e.occurtime = curtime + e.delaytime;
			return this->Enqueue(e);
		}
		Status DeqEvent(EventCase& e){
			if(ListEmpty())
				return ERROR;
			this->Dequeue(e);
			return OK;
		}
		Status ListEmpty(){
			return this->QueueEmpty();
		}
		void FastForward(Time t)
		{
			this->curtime = t;
		}
		Time GetTime()
		{
			return this->curtime;
		}
	private:
		Time curtime;
};
#endif
