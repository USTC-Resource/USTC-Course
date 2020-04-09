# 多项式计算器

使用示例：

```
❯ make
g++    -c -o poly.o poly.cpp
g++    -c -o main.o main.cpp
#clang++ poly.o main.o -o main.out
clang++  poly.o main.o -o main.out
❯ ./main.out
q to quit, new to create new poly, print to print polys stored, delete to delete a poly, add sub mul eval to do operations
poly> new
New poly: (enter 1 2 3 0 for +1x^(2)+3x^(0))
1 2 3 0
Your poly: +1x^2+3x^0
poly> n
New poly: (enter 1 2 3 0 for +1x^(2)+3x^(0))
2 2 1 1
Your poly: +2x^2+1x^1
poly> mul
Enter two indexes: 1
2
Multiplication is: +2x^4+1x^3+6x^2+3x^1
Result saved
poly> poly> print
Total 3 Polys: 
#1: +1x^2+3x^0
#2: +2x^2+1x^1
#3: +2x^4+1x^3+6x^2+3x^1
poly> eval
Enter a index: 3
Enter an x value: 99
The value of poly +2x^4+1x^3+6x^2+3x^1 when x is 99 is: 1.93149e+08
poly> poly> q
```

