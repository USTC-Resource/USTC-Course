function [ clustering ] = modularity( A, k )
%modularity Modularity maximization
%
    d = ( sum( A ) )';
    % sum of all.
    m = sum( d );
    B = A - d * d' / m;
    % 最大的前k个特征向量.
    [ V, ~ ] = eigs( B, k );
    % kmeans
    clustering = kmeans( V, k );
end