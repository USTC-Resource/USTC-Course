function [root] = StringCutRoot(f, x0, x1, eps, itermax)
%NEWTONROOT Use Newton method to get the root of functions
global debugflg
if debugflg == 2
    fprintf('Init,\tx0 %.12e, x1 %.12e, f(x0) %.12e\n', x0, x1, f(x0));
end
itertimes = 0;
% use matlab diff to get derivative, if fderive is given NaN
% if fderive == NaN
% get the derive of f(x) the function handle, 
% a simple diff is not enough
% end
% fderive = diff(f);
while abs(f(x1)) >= eps && itertimes < itermax
    x0old = x0;
    x1old = x1;
    x1 = x1old - f(x1old) * (x1old - x0old) / (f(x1) - f(x0));
    x0 = x1old;
    itertimes = itertimes + 1;
    if debugflg == 2
        fprintf('Iter %3d,\tx0 %.12e, x1 %.12e, f(x0) %.12e\n', ...
            itertimes, x0, x1, f(x0));
    end
end
if itertimes < itermax
    root = x1;
else
    root = NaN;
end
end

