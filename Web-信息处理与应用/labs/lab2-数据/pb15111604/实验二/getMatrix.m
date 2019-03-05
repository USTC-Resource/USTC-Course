function graph = getMatrix(s)
%GETMATRIX 从graph.txt得到矩阵.
%   
    % 导入
    r = importdata('graph.txt');
    % 参数
    nodes = r(1);
    % 删去第一行参数部分
    r(1,:)=[];
    % 考虑到txt中节点从0开始,+1
    i = r(:, 1)' + 1;
    j = r(:, 2)' + 1;
    p = r(:, 3)';
    graph = full(sparse(i, j, p));
    graph = [graph; zeros(1, nodes)];
end
