function [ clustering ] = ncut( A, k )
%ncut Spectral clustering: normalized cut
%
    % D
    D = full(diag(sum(A)));
    % 拉普拉斯,W = A
    L = D - A;
    % 对应ncut.
    L = D^(-1/2) * L * D^(-1/2);
    % 返回前k个最小的特征向量。
    [V,~]= eigs(L, k, 'sm');
    % kmeans
    clustering = kmeans(V, k);
end