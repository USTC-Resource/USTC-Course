format longE
syms x
f = @(x) 1 / (4+x+x.^2);
N = [4, 8, 16, 128];
y = (0:500) / 50 - 5;
polyadd = @(p1, p2) [zeros(1, size(p1,2)-size(p2,2)) p2] + ...
[zeros(1, size(p2,2)-size(p1,2)) p1];

warning('off', 'all')
for k = 1:3
    for kk = 1:2
        disp(['N = ' num2str(N(k)) ' type' num2str(kk)]);
        if kk == 1
            xi = -5 + 10/N(k) * (0:N(k));
        else
            xi = -5 * cos((2 * (0:N(k)) + 1)*pi / (2 * N(k) + 2));
        end
        p = 0;
        for i = 0:N(k)
            l = 1;
            for j = 0:i-1
                l = conv(l, [1, -xi(j+1)] / (xi(i+1) - xi(j+1)));
            end
            for j = (i+1):N(k)
                l = conv(l, [1, -xi(j+1)] / (xi(i+1) - xi(j+1)));
            end
            p = polyadd(p, f(xi(i+1)) * l);
        end
        % p is the result Lagrange polynomial
        % calculate the max err
        err = max(abs(arrayfun(f, y) - polyval(p, y)));
        fprintf("Err = %.12e\n", err);
        fig = fplot(f, [-5 5]);
        hold on
        pval = polyval(p, y);
        plot(y, pval);
        title(['N=' num2str(N(k)) ' type=' num2str(kk)]);
        hold off
        saveas(fig, ['N' num2str(N(k)) 'type' num2str(kk) '.png']);
        clf();
    end
end
warning('on', 'all')