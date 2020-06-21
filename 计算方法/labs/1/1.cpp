#include <bits/stdc++.h>
using namespace std;
float f(float x)
{
	return sqrt(x * x + 4) - 2;
}
float g(float x)
{
	return x * x / (sqrt(x * x + 4) + 2);
}

int main(){
	// Problem 1
	float x;
	x = 1.;
	for(int i = 0; i < 10; i++) {
		x = x / 8;
		cout << setiosflags(ios::scientific) << setprecision(12) << x << "\t" << f(x) << "\t" << g(x) << endl;
	}
	// Problem 2
	double arr[] = {4040.045551380452, -2759471.276702747, -31.64291531266504,  2755462.874010974,  0.0000557052996742893};
	double res;
	// seq
	res = 0.;
	for(int i = 0; i < 5; i++) {
		res += arr[i];
	}
	cout << setprecision(7) << "Final " << res << endl;
	// rev
	res = 0.;
	for(int i = 4; i >= 0; i--) {
		res += arr[i];
	}
	cout << "Final " << res << endl;
	// posi and nega
	res = 0.;
	res += arr[0];
	res += arr[3];
	res += arr[4];
	res += arr[1];
	res += arr[2];
	cout << "Final " << res << endl;
	// from small to big
	res = 0.;
	res += arr[4];
	res += arr[2];
	res += arr[0];
	res += arr[3];
	res += arr[1];
	cout << "Final " << res << endl;
	// Real result is 0.
	return 0;
}
