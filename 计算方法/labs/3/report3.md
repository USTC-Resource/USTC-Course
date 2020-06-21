# Lab03 复化数值积分

**古宜民 PB17000002**

**2019.3.29**

### 1. 计算结果

$\int_1^6sin(x)dx$的准确计算结果为-0.419867980782， 使用不同节点数以及不同积分计算公式计算得到的结果误差以及误差阶如下：

```
Trapezoidal:
k = 0 , e0 = 1.825006697305e+00 
k = 1 , e1 = 2.454792698194e-01 d1 = 2.894229
k = 2 , e2 = 5.614913519149e-02 d2 = 2.128265
k = 3 , e3 = 1.375739486821e-02 d3 = 2.029056
k = 4 , e4 = 3.422468688995e-03 d4 = 2.007098
k = 5 , e5 = 8.545713803537e-04 d5 = 2.001764
k = 6 , e6 = 2.135776256161e-04 d6 = 2.000440
k = 7 , e7 = 5.339033240897e-05 d7 = 2.000110
k = 8 , e8 = 1.334732851237e-05 d8 = 2.000028
k = 9 , e9 = 3.336816218437e-06 d9 = 2.000007
k = 10 , e10 = 8.342030578988e-07 d10 = 2.000002
k = 11 , e11 = 2.085507060833e-07 d11 = 2.000000
k = 12 , e12 = 5.213767289113e-08 d12 = 2.000000
Simpson:
k = 0 , e0 = 1.356627125131e+00 
k = 1 , e1 = -2.810298726757e-01 d1 = 2.271229
k = 2 , e2 = -6.960909684480e-03 d2 = 5.335304
k = 3 , e3 = -3.731852395461e-04 d3 = 4.221312
k = 4 , e4 = -2.250670407778e-05 d4 = 4.051465
k = 5 , e5 = -1.394389193287e-06 d5 = 4.012650
k = 6 , e6 = -8.695929749514e-08 d6 = 4.003149
k = 7 , e7 = -5.431993476250e-09 d7 = 4.000787
k = 8 , e8 = -3.394531423773e-10 d8 = 4.000197
k = 9 , e9 = -2.121498432927e-11 d9 = 4.000057
k = 10 , e10 = -1.324950265053e-12 d10 = 4.001074
k = 11 , e11 = -8.244416704390e-14 d11 = 4.006377
k = 12 , e12 = -4.450999563981e-15 d12 = 4.211216
```

### 2. 结果分析

从计算结果可见，在节点数相同的条件下，Simpson积分的误差明显小于梯形积分，并且误差随节点数增加而迅速增加。Simpson积分的误差阶高于梯形积分，说明了其误差减小更快，好于梯形积分。

作图查看积分函数和拟合函数的值的偏差：

折线段为梯形积分，抛物线段为Simpson积分。

$y=sin(x)$

![visualizesin](.\visualizesin.png)

![visualizesinlong](.\visualizesinlong.png)

$y=e^x$

![visualizeexp](.\visualizeexp.png)

从图中可见，由于梯形积分是用直线段拟合被积函数，而Simpson积分是用抛物线段拟合函数，Simpson积分的拟合能够更加”贴合“函数的曲线，从而由更好的精度。当函数是凸或凹函数时，梯形积分会有系统性积分值偏大或小，导致误差很大。当然，如果函数的波动过大或增长远快于$x^2$量级（比如$e^x$），那么两种积分方式都会由较大误差。

在计算时间上，Simpson积分做了更多操作，或许相对较慢一些，但两者的时间效率在同一个数量级上，没有巨大差异。若该积分使用10000000个积分节点，则二者在笔记本电脑的MATLAB中的运行时间均为0.63s左右，没有观察到差别。

使用$x^n$带入积分公式计算积分，可验证梯形积分有一阶代数精度，Simpson积分有三阶代数精度。

### 3. 程序算法

使用MATLAB编程计算，为了保证通用性，将复化梯形积分和复化Simpson积分放在单独的文件里作为函数，可供任意程序调用，只要提供了被积函数、积分上下限和节点数N，就可以计算积分。

函数代码：

复化梯形积分

```matlab
function [result] = trapezoidal(f, a, b, N)
%TRAPEZOIDAL : Doing Trapezoidal numerical calculus
%   f: the function to integral
%   a, b: the intetral interval
%   N: points number
h = (b - a) / N;
result = 1/2 * (f(a) + f(b));
for i = 1:(N-1)
    result = result + f(a + h * i);
end
result = result * h;
end
```

复化Simpson积分

```matlab
function [result] = Simpson(f, a, b, N)
%SIMPSON : Doing Simpson numerical calculus
%   f: the function to integral
%   a, b: the intetral interval
%   N: points number
h = (b - a) / N;
result = f(a) + f(b);
m = N / 2;
pt1 = 0;
for i = 0:m-1
    pt1 = pt1 + f(a + (2 * i + 1) * h);
end
result = result + 4 * pt1;
pt2 = 0;
for i = 1:m-1
    pt2 = pt2 + f(a + (2 * i) * h);
end
result = result + 2 * pt2;
result = result * h / 3;
end
```
