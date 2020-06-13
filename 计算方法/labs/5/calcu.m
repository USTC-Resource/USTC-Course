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