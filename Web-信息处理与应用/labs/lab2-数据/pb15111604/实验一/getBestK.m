function kList = getBestK()
%getBestK 求解Egnoet的最佳K值
%   此处显示详细说明
    load('Egonet.mat');
    n = max(size(x));
    maxK = 0;
    d = sum(x);
    m = sum(d);
    B = x - d' * d / m;
    for k = 2 : 30
        clustering = ncut(x, k);
        Y = zeros(n, n);
        for i = 1 : n
            for j = 1 : n
                Y(i, j) = (clustering(i) == clustering(j));
            end
        end
        Q = sum(sum(B .* Y));
        kList(k) = Q;
        if maxK == 0
            maxK = Q;
            kList = (k);
            continue;
        end
        if Q > maxK
            maxK = Q;
            kList = [k, kList];
        end
    end
end
