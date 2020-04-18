#ifndef LINKLIST_H
#define LINKLIST_H
#include <iostream>
#include <sstream>
using namespace std;
typedef int Status;
#define Inf 2100000000
#define Eps 1e-6
#define ERROR 1
#define OK 0
//OVERFLOW already defined in cmath, avoid it.
//#define OVERFLOW 2

template<typename T>
class Node{
	public:
		Node()
		{
			next = NULL;
		}
		Node(T data)
		{
			this->data = data;
			next = NULL;
		}
		~Node(){
		}
		T data;
		Node<T>* next;
};
template<typename T>
class Linklist{
	public:
		Linklist();
		Linklist(const Linklist&);
		~Linklist();
		const Linklist& operator=(const Linklist& list);
		Status GetElem(int, T&);
		Status ListInsert(int, T);
		Status ListDelete(int, T&);
		Status Clear();
		Status Append_head(T);
		Status Append(T);
		int GetLength();
		Node<T>* head;
		Node<T>* tail;
		int length;
};

template<typename T>
Linklist<T>::Linklist()
{
	tail = head = new Node<T>;
	length = 0;
}
template<typename T>
Linklist<T>::Linklist(const Linklist& list){
	Node<T>* p;
	Node<T>* q;
	Node<T>* r;
	p = list.head;
	q = head = new Node<T>;
	while((p = p->next)){
		r = new Node<T>;
		r->data = p->data;
		q->next = r;
		q = r;
	}
	tail = q;
	length = list.length;
}
template<typename T>
Linklist<T>::~Linklist()
{
	Node<T>* p;
	p = head;
	while(head){
		p = head->next;
		delete head;
		head = p;
	}
}
template<typename T>
const Linklist<T>& Linklist<T>::operator=(const Linklist& list)
{
	if(this != &list){
		this->Clear();
		Node<T>* p;
		Node<T>* q;
		Node<T>* r;
		p = list.head;
		q = head;
		while((p = p->next)){
			r = new Node<T>;
			r->data = p->data;
			q->next = r;
			q = r;
		}
		tail = q;
		length = list.length;
	}
	return *this;
}
template<typename T>
Status Linklist<T>::GetElem(int idx, T& data)
{
	if(idx < 1 || idx > length)
		return ERROR;
	Node<T>* p;
	p = head;
	for(int i = 0; i < idx; i++)
		p = p->next;
	data = p->data;
	return OK;
}
template<typename T>
Status Linklist<T>::ListInsert(int idx, T data)
{
	if(idx < 1 || idx > length + 1)
		return ERROR;
	Node<T>* p;
	Node<T>* q;
	q = new Node<T>;
	q->data = data;
	p = head;
	for(int i = 1; i < idx; i++)
		p = p->next;
	q->next = p->next;
	p->next = q;
	if(tail->next != NULL)
		tail = tail->next;
	length++;
	return OK;
}
template<typename T>
Status Linklist<T>::ListDelete(int idx, T& data)
{
	if(idx < 1 || idx > length)
		return ERROR;
	Node<T>* p;
	Node<T>* q;
	p = head;
	for(int i = 1; i < idx; i++)
		p = p->next;
	if(p->next == tail)
		tail = p;
	data = p->next->data;
	q = p->next;
	p->next = q->next;
	delete q;
	length--;
	return OK;
}
template<typename T>
Status Linklist<T>::Clear()
{
	Node<T>* p;
	Node<T>* q;
	length = 0;
	q = head->next;
	while(q){
		p = q->next;
		delete q;
		q = p;
	}
	tail = head;
	head->next = NULL;
	return OK;
}
template<typename T>
Status Linklist<T>::Append_head(T data)
{
	Node<T>* p;
	p = new Node<T>;
	p->data = data;
	p->next = head->next;
	head->next = p;
	length++;
	return OK;
}
template<typename T>
Status Linklist<T>::Append(T data)
{
	Node<T>* p;
	p = new Node<T>;
	p->data = data;
	tail->next = p;
	tail = p;
	length++;
	return OK;
}
template<typename T>
int Linklist<T>::GetLength()
{
	return length;
}

#endif
