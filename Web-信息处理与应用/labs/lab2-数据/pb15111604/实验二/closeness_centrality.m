function seeds = closeness_centrality(G, k)
%CLOSENESS_CENTRALITY Closeness Centrality
%   
    adj = 1 ./ (G + 0.1 .* ones(size(G)));
    % ×î¶ÌÂ·
    Distances = all_shortest_paths(sparse(1 ./ (adj + 0.1 * ones(size(adj)))));
    centralityVec = sum(Distances');
    [~,inds] =  sort(centralityVec,'descend');
    seeds = inds(1:k);
end

