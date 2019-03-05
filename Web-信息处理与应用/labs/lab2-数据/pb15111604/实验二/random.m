function seeds = random(G, k)
%random Random selection
%   
    nodes = zeros(1,k);
    size = length(G);
    for i = 1:k
        node = 1 + floor((size-1)*rand());
        while ismember(node,nodes)==1
            node = 1 + floor((size-1)*rand());
        end
        nodes(i) = node;
    end
    seeds = nodes;
end