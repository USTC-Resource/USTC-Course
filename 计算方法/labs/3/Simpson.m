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