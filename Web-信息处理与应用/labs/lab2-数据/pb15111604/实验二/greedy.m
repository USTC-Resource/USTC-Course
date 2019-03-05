function seeds = greedy(G, k)
%DEGREE_CENTRALITY Greedy
%   
    nodes = [];
    for i = 1:k
        influences = zeros(length(G),1);
        for j = 1:length(G)
            if ismember(j,nodes)==0
                % 独立级联模拟传播
                [influenced,~] = influenceICM(G,[nodes,j],5);
                influences(j) = sum(influenced(5,:));
            else
                influences(j) = 0;
            end
        end
        [~,maxInd] = max(influences);
        nodes = [nodes,maxInd];
    end
    seeds = nodes;
end

