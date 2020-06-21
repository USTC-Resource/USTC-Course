function [roots] = SolveLinearEqn(A, b, x0, eps, itermax, mode)
%SOLVELINEAREQN Solving linear equations using Jacobi or Gauss-Seidel
% iteration methods 
%   Get numerical solution of equation Ax=b, initial iteration value is x0, 
%   stop iteration when err<eps or iteration times exceeded itertimes. 
%   Mode is 'Jacobi' or 'Gauss-Seidel'.
global debugflg
if debugflg == 2
    fprintf('Debug enabled.\n');
end
[row, col] = size(A);
if row ~= col
    disp('A is not square matrix!');
    roots = NaN;
    return 
end
len = row;
if len ~= size(b)
    disp('A and b should have the same dimension!');
    roots = NaN;
    return
end
for i = 1:len
    if A(i, i) == 0
        disp('Diagonal values of A should not be zero!');
        roots = NaN([1 len]);
        return
    end
end
% if debugflg == 2
%     disp('A:');
%     disp(A);
%     disp('b:');
%     disp(b);
%     fprintf('Matrix check OK(len %d), start calc.\n', len);
% end
itertimes = 0;
x1 = x0;
% Use Infinity Norm here. 
while max(abs(A*x1' - b')) > eps && itertimes < itermax
%     if debugflg == 2
%         fprintf('Start Iter: %d\n', itertimes);
%         fprintf('Eps:  %.6e\n', max(abs(x1 - b)));
%     end
    if strcmp(mode, 'Jacobi')
        T = A * x0';
        for i = 1:len
            x1(i) = -1 / A(i,i) * (T(i) - A(i,i) * x0(i) - b(i));
        end
    elseif strcmp(mode, 'Gauss-Seidel')
        for i = 1:len
            T = 0;
            for j = 1:len
                T = T + A(i,j) * x1(j);
            end
            x1(i) = -1 / A(i,i) * (T - A(i,i) * x1(i) - b(i));
        end
    else
        fprintf('No such mode: %s\n', mode);
        % Let stop
        itertimes = itermax;
    end
    x0 = x1;
    itertimes = itertimes + 1;
%     if debugflg == 2
%         fprintf('After Iter: %d\n', itertimes);
%         disp('T');
%         disp(T);
%         disp('x0, x1');
%         disp(x0);
%         disp(x1);
%     end
end
if debugflg == 2
    fprintf('End iter. ');
    fprintf('Iter times: %d\n', itertimes);
    fprintf('Eps:        %.6e\n', max(abs(A*x1' - b')));
%     fprintf('Ans found: ');
%     disp(x1);
end
if itertimes < itermax
    roots = x1;
else
    roots = NaN([1 len]);
end
end