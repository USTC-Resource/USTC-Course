format longE
syms x;
f = @(x) sin(x);
a = 1;
b = 6;
I0 = int(sin(x), a, b);
fprintf('%.12f\n', I0);
ek = 0;
fprintf('Trapezoidal:\n');
for k = 0:12
    N = 2^k;
    ekold = ek;
    ek = trapezoidal(f, a, b, N) - I0;
    fprintf('k = %d , e%d = %.12e ', k, k, ek);
    if k > 0
        d = - log(ek / ekold) / log(2);
        fprintf('d%d = %.6f\n', k, d);
    else
        fprintf('\n');
    end
end
fprintf('Simpson:\n');
for k = 0:12
    N = 2^k;
    ekold = ek;
    ek = Simpson(f, a, b, N) - I0;
    fprintf('k = %d , e%d = %.12e ', k, k, ek);
    if k > 0
        d = - log(ek / ekold) / log(2);
        fprintf('d%d = %.6f\n', k, d);
    else
        fprintf('\n');
    end
end
% do some visualization
N=6;
b=6;
a=1;
fig = fplot(sin(x), [a b], 'LineWidth', 2);
hold on
h = (b - a) / N;
% plot trapezodial
for i=0:N-1
    plot([a+i*h a+(i+1)*h], [sin(a+i*h) sin(a+(i+1)*h)], 'LineWidth', 1, 'color', 'red')
end
% plot Simpson
for i=0:2:N-2
    x = [a+i*h a+(i+1)*h a+(i+2)*h];
    y = [sin(a+i*h) sin(a+(i+1)*h) sin(a+(i+2)*h)];
    p = polyfit(x, y, 2);
    t = a+i*h:.05:a+(i+2)*h;
    s = polyval(p, t);
    plot(t, s, 'color', 'green', 'LineWidth', 1);
%     plot(t, s, 'LineWidth', 1);

end
hold off
saveas(fig, 'visualize.png');




