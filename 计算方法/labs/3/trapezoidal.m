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