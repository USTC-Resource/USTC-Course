# Lab05 **迭代法解线性代数方程组**

**古宜民 PB17000002**

**2019.5.2**

求解线性方程组$Ax=b$.

A为矩阵，x，b为列向量。

### 1. 计算结果

使用Jacobi迭代和Gauss-Seidel迭代计算线性方程组的解，并与用MATLAB直接求得的解比较。停止条件取为$\left\|x^{(k+1)}-x^{(k)}\right\|_{\infty}\leq10^{-5}$

Jacobi, time 0.002116,000742 seconds

迭代43次，最后结果的误差9.200308e-06

```
    -2.892338634008514e-01
     3.454358567799977e-01
    -7.128117563931197e-01
    -2.206084538460905e-01
    -4.304004546757331e-01
     1.543089002872824e-01
    -5.782292346918328e-02
     2.010539160680573e-01
     2.902286537336413e-01
```

G-S, time 0.000486,000589 seconds

迭代19次，最后结果的误差7.052744e-06

```
ansGS
    -2.892333530646782e-01
     3.454360754977236e-01
    -7.128115360532529e-01
    -2.206083677319629e-01
    -4.304002884421447e-01
     1.543090020780228e-01
    -5.782268140632481e-02
     2.010539283318932e-01
     2.902287085198662e-01
```

MATLAB A\b, time 0.000172,0.000166 seconds

误差1.998401444325282e-15

```
    -2.892338160157545e-01
     3.454357157791154e-01
    -7.128117310868789e-01
    -2.206085105705285e-01
    -4.304004327040223e-01
     1.543087398383112e-01
    -5.782287328904061e-02
     2.010538948236807e-01
     2.902286618797449e-01
```

时间为连续前后两次各个求根函数运行的时间。

本题中矩阵A为对称正定阵，所以由理论知迭代收敛。

### 2. 结果分析

从结果可见，计算精度和迭代次数上，在指定精度时，Jacobi迭代次数明显多于G-S迭代。其所需的迭代次数约为G-S迭代的2.2倍。精度设为$10^{-10}​$时，二者的迭代次数为78次、36次。可见G-S迭代优于Jacobi迭代。

在计算时间方面，可见MATLAB直接矩阵求逆计算最快，G-S迭代速度快于Jacobi迭代，因为其迭代次数较少。从计算公式可见，Jacobi迭代和G-S迭代每次迭代的时间效率为$O(n^2)​$，$n​$为矩阵大小。实验结果中第一次Jacobi迭代慢很可能时缓存还没有warm up的原因。

### 3. 程序设计

用MATLAB实现通用线性方程组求解程序。程序输入为A,b,迭代初值x0，误差限eps，最大迭代次数itermax，以及模式选择mode（可选Jacobi或Gauss-Seidel）；输出为NaN、NaN数组或求得的解数组。为保证程序健壮性，程序首先对矩阵A和向量b进行判断，检查A是否为方阵；A,b的维数是否相同，A的对角线元素是否不为0.为了方便调试和提供详细输出，使用了一个全局变量debugflg，如果该变量被置为特定值，则输出调试信息（迭代次数等），否则只返回求得的根。如果因任何原因（输入错误，不收敛等）无法求根，将返回NaN（如果维数无法确定，如A不为方阵），或NaN数组（如果维数能够确定）。

在运行中，也偶尔可见S-G迭代计算速度慢于Jacobi迭代的情况，一个可能的原因是在Jacobi迭代中使用了一次MATLAB矩阵与向量乘法，而S-G迭代中没有使用，而是用朴素的循环实现类似功能。MATLAB矩阵乘法等BLAS库十分完善，速度明显快于手写循环，导致了这种现象。这也提示我可以使用更多类似运算代替手写朴素算法提高程序运行效率。

程序代码SolveLinearEqn.m

```matlab
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
```

测试计算的程序calcu.m

```matlab
b = [-15 27 -23 0 -20 12 -7 7 10];
x0 = [0 0 0 0 0 0 0 0 0];
A = [
[31		-13		0		0		0		-10		0		0		0		];
[-13	35		-9		0		-11		0		0		0		0		];
[0		-9		31		-10		0		0		0		0		0		];
[0		0		-10		79		-30		0		0		0		-9		];
[0		0		0		-30		57		-7		0		-5		0		];
[0		0		0		0		-7		47		-30		0		0		];
[0		0		0		0		0		-30		41		0		0		];
[0		0		0		0		-5		0		0		27		-2		];
[0		0		0		-9		0		0		0		-2		29      ]
];
Eps = 1e-10;
Itermax = 100;
b1 = [3 2];
A1 = [[2 0]; [0 1]];
x01 = [0 0];
format longE
tic;
ansJacobi = SolveLinearEqn(A, b, x0, Eps, Itermax, 'Jacobi');
toc;
disp('ansJacobi');
disp(ansJacobi');
tic;
ansGS = SolveLinearEqn(A, b, x0, Eps, Itermax, 'Gauss-Seidel');
toc;
disp('ansGS');
disp(ansGS');
tic;
ansReal = A\b';
toc;
disp('ansReal and err');
disp(ansReal);
disp(max(abs(A*ansReal - b')));
% ans1Jacobi = SolveLinearEqn(A1, b1, x01, Eps, 3, 'Jacobi');
% disp(ans1Jacobi);
```

