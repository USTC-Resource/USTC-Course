function [ clustering ] = rcut( A, k )
%rcut Spectral clustering: ratio cut
%
    % D
    D = diag(sum(A));
    % 拉普拉斯,W = A
    L = D - A;
    % 返回前k个最小的特征向量。
    [V,~]= eigs(L, k, 'sm');
    % kmeans
    clustering = kmeans(V, k);
end