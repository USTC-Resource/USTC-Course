#include <iostream>
#include <sstream>
#include <cmath>
#include "poly.hpp"
using namespace std;

Mono::Mono()
{
	expn = 0;
	coef = 0;
}
Mono::Mono(int expn, double coef)
{
	this->expn = expn;
	this->coef = coef;
}
void Mono::printmono()
{
	cout << showpos << coef << noshowpos << "x^" << (expn < 0 ? "(" : "") << expn << (expn < 0 ? ")" : "");
}

Polynomial::Polynomial()
{
	//tail = head = new Node<Mono>;
	//length = 0;
}
Polynomial::Polynomial(string s)
{
	*this = Polynomial();
	if(s == "" || s == "0")
		return;
	stringstream ss;
	ss << s;
	int e;
	double c;
	int elast = Inf;
	while(!ss.eof()){
		try{
			ss >> c;
			if(ss.fail())
				throw "wrong reading coef";
			ss >> e;
			if(ss.fail())
				throw "wrong reading expn";
			if(e >= elast)
				throw "Must input expn in decrease order";
			if(fabs(c) < Eps)
				throw "coef shouldn\'t be zero";
			if(e < 0)
				throw "expn should >= 0";
			elast = e;
			this->Append(Mono(e, c));
		}
		catch(const char* msg){
			cout << "Construction Error: " << msg  << "! You get Zero polynomial"<< endl;
			*this = Polynomial();
			return;
		}
	}
}
void Polynomial::printpoly(ostream& out) const
{
	Node<Mono>* p;
	p = head;
	while((p = p->next))
		p->data.printmono();
	if(length == 0)
		out << "0";
}
ostream& operator<<(ostream& out, const Polynomial& poly)
{
	poly.printpoly(out);
	return out;
}
istream& operator>>(istream& in, Polynomial& poly)
{
	string s;
	getline(in, s);
	poly = Polynomial(s);
	return in;
}
Polynomial Polynomial::opposite() const
{
	Polynomial poly = *this;
	Node<Mono>* p;
	p = poly.head;
	while((p = p->next))
		p->data.coef = -p->data.coef;
	return poly;
}
Polynomial Polynomial::add(const Polynomial& secPoly) const
{
	Polynomial c;
	Node<Mono>* p;
	Node<Mono>* q;
	p = head->next;
	q = secPoly.head->next;
	while(p && q){
		int flg = p->data.expn - q->data.expn;
		if(flg > 0){
			c.Append(p->data);
			p = p->next;
		}
		else if(flg < 0){
			c.Append(q->data);
			q = q->next;
		}
		else{
			double delta = p->data.coef + q->data.coef;
			//Do nothing if the two mono makes zero
			if(fabs(delta) > Eps)
				c.Append(Mono(p->data.expn, delta));
			p = p->next;
			q = q->next;
		}
	}
	while(p){
		c.Append(p->data);
		p = p->next;
	}
	while(q){
		c.Append(q->data);
		q = q->next;
	}
	return c;
}
Polynomial Polynomial::subtract(const Polynomial& secPoly) const
{
	return this->add(secPoly.opposite());
}
Polynomial Polynomial::multiply(const Polynomial& secPoly) const
{
	Polynomial c;
	Polynomial t;
	Node<Mono>* p;
	Node<Mono>* q;
	p = secPoly.head;
	while((p = p->next)){
		t = *this;
		q = t.head;
		while((q = q->next)){
			q->data.coef *= p->data.coef;
			q->data.expn += p->data.expn;
		}
		c = c + t;
	}
	return c;
}
double Polynomial::eval(double x) const
{
	double val = 0;
	Node<Mono>* p;
	p = head;
	while((p = p->next))
		val += p->data.coef * pow(x, p->data.expn);
	return val;
}
Polynomial Polynomial::operator+()
{
	return *this;
}
Polynomial Polynomial::operator-()
{
	return this->opposite();
}
Polynomial Polynomial::operator+(const Polynomial& secPoly)
{
	return this->add(secPoly);
}
Polynomial Polynomial::operator-(const Polynomial& secPoly)
{
	return this->subtract(secPoly);
}
Polynomial Polynomial::operator*(const Polynomial& secPoly)
{
	return this->multiply(secPoly);
}

