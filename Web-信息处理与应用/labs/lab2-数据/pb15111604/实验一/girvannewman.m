function [ clustering ] = girvannewman( A, k )
% Divisive hierarchical clustering ¡ª Girvan-Newman
%
    A1 = sparse(A);
    % [ci sizes] = components(A) returns the component index vector (ci) and
    % the size of each of the connected components (sizes)
    count = max(components(A1));
    while count ~= k
        [~,E] = betweenness_centrality(A1);
        [C,I] = max(E);
        [~,I1] = max(C);
        A1(I(I1),I1) = 0;
        A1(I1,I(I1)) = 0;
        count = max(components(A1));
    end
    [clustering,~] = components(A1);
end