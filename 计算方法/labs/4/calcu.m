ftest = @(x) 2*x^4+24*x^3+61*x^2-16*x+1;
% first have a plot
fig = fplot(ftest, [-10., 1.]);
saveas(fig, 'f.png');
% enable debug in NewtonRoot and StringCutRoot
global debugflg
debugflg = 2;
eps = 1e-10;
% Newton
disp('Newton');
x0 = 0;
maxiter = 10000;
NewtonRoot(ftest, x0, eps, maxiter);
disp(' ')
x0 = 1;
NewtonRoot(ftest, x0, eps, maxiter);
x0 =-10;
NewtonRoot(ftest, x0, eps, maxiter);

% String Cut
disp('String Cut');
x0 = 0;
x1 = .1;
StringCutRoot(ftest, x0, x1, eps, maxiter);
disp(' ')
x0 = .5;
x1 = 1.;
StringCutRoot(ftest, x0, x1, eps, maxiter);
