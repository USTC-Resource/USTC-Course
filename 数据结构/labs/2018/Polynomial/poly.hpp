#ifndef POLY_H
#define POLY_H
#include <iostream>
#include <sstream>
#include "../Lib/linklist.hpp"
using namespace std;
class Mono{
	public:
		Mono();
		Mono(int, double);
		void printmono();
		int expn;
		double coef;
};
class Polynomial: public Linklist<Mono> {
	public:
		Polynomial();
		Polynomial(string s);
		void printpoly(ostream& out) const;
		friend ostream& operator<<(ostream& out, const Polynomial& poly);
		friend istream& operator>>(istream& in, Polynomial& poly);
		Polynomial opposite() const;
		Polynomial add(const Polynomial& secPoly) const;
		Polynomial subtract(const Polynomial& secpoly) const;
		Polynomial multiply(const Polynomial& secpoly) const;
		double eval(double x) const;
		Polynomial operator+();
		Polynomial operator-();
		Polynomial operator+(const Polynomial& secPoly);
		Polynomial operator-(const Polynomial& secPoly);
		Polynomial operator*(const Polynomial& secPoly);
};
#endif
