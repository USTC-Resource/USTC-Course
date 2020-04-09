#ifndef QUEUE_H
#define QUEUE_H
#include <iostream>
#include <sstream>
#include "linklist.hpp"
using namespace std;

//Prerequsite: type T should defined operator<
template<typename T>
class Queue: public Linklist<T>{
	public:
		//Just a dummy constructor
		Queue(){}
		Status Enqueue(const T& elem){
			Node<T>* p;
			Node<T>* q;
			p = this->head;
			while(p->next && p->next->data < elem){
				p = p->next;
			}
			q = new Node<T>;
			q->data = elem;
			q->next = p->next;
			p->next = q;
			this->length++;
			return OK;
		}
		Status Dequeue(T& elem){
			return this->ListDelete(1, elem);
		}
		Status TopElem(T& elem){
			if(this->QueueEmpty())
				return ERROR;
			elem = this->head->next->data;
			return OK;
		}
		bool QueueEmpty(){
			return this->length == 0 ? true : false;
		}
};
#endif
