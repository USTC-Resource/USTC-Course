function [iGraph,inum] = influenceICM(G,Initnodes,iterTime)
% %influenceICM influenceICM 独立级联模型
% %   此处显示详细说明
    len = length(G);
    iGraph = zeros(1,len); 
    %iGraph：最后输出的迭代节点图
    leftGraph = zeros(1,len);   
    %leftGraph：左边的图
    tried = zeros(len);
    inum = zeros(1,iterTime);
    
    for i = 1:length(Initnodes)
        leftGraph(Initnodes(i)) = 1;
    end
    
    for t= 1:iterTime
        newnodes = leftGraph;
        for i = 1:length(leftGraph)
            if leftGraph(i) == 1 
                for j = 1:length(leftGraph)
                    if (tried(i,j) == 0 && newnodes(j) == 0)
                        if (G(i,j) > 0 && rand() < G(i,j))
                        % 如果rand(也就是阈值)小于转移概率
                            newnodes(j) = 1;
                        else
                            tried(i,j) = 1;
                        end
                    end
                end
            end
        end
        leftGraph = newnodes;
        inum(t) = sum(leftGraph);
        iGraph(t,:) = leftGraph;
    end
