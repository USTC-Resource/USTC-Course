function seeds = degree_centrality(G, k)
%DEGREE_CENTRALITY Degree Centrality
%   
    degreeVec = sum(G');
    [~,inds] =  sort(degreeVec,'descend');
    seeds = inds(1:k);
end

