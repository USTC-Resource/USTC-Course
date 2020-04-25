/* code optim test 1 */
void xx(void) {
	int x;
	x = 1;
	return;
}
int main(void) {
	int a;
	int b;
	int c;
	int d;
	b = 2;
	b = 1;
	a = b + 1;
	c = b + 3;
	a = c + b;
	if(a) {
		return a;
	}
	else {
		return b;
	}
	return 0;
	return 1;
	return 0;
}
