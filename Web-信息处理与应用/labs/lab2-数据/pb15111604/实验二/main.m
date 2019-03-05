% 从txt得到矩阵.
graph = getMatrix('graph.txt');
% 100轮传播.
itertime = 100;
t = zeros(100);
tRan = t;
tDeg = t;
tClose = t;
tGreedy = t;
% 打开文件
tRanFile = fopen('rtime.txt', 'a');
ranFile = fopen('random.txt', 'a');
tDegFile = fopen('dtime.txt', 'a');
degFile = fopen('degree_centrality.txt', 'a');
tCloFile = fopen('ctime.txt', 'a');
cloFile = fopen('closeness_centrality.txt', 'a');
tGreFile = fopen('gtime.txt', 'a');
greFile = fopen('greedy.txt', 'a');
% k = 1 to 20
for k = 6:15
    disp(k);
    tic;
    seedsRan = random(graph, k);
    if k>1
        for j = 1:k-1
            fprintf(ranFile,'%4d,',seedsRan(j));
        end
    end
    fprintf(ranFile,'%4d;',seedsRan(k));
    [~,tRan(k,:)] = influenceICM(graph,seedsRan(1:k),itertime);
    fprintf(ranFile,'%4d\n',tRan(k,itertime));
    fprintf(tRanFile, '%d : \t%f s\n',k, toc);
    disp('random finished');
    
    tic;
    seedsDeg = degree_centrality(graph, k);
    if k>1
        for j = 1:k-1
            fprintf(degFile,'%4d,',seedsDeg(j));
        end
    end
    fprintf(degFile,'%4d;',seedsDeg(k));
    [~,tDeg(k,:)] = influenceICM(graph,seedsDeg(1:k),itertime);
    fprintf(degFile,'%4d\n',tDeg(k,itertime));
    fprintf(tDegFile, '%d : \t%f s\n',k, toc);
    disp('degree_centrality finished');
    
    tic;
    seedsClose = closeness_centrality(graph, k);
    if k>1
        for j = 1:k-1
            fprintf(cloFile,'%4d,',seedsClose(j));
        end
    end
    fprintf(cloFile,'%4d;',seedsClose(k));
    [~,tClose(k,:)] = influenceICM(graph,seedsClose(1:k),itertime);
    fprintf(cloFile,'%4d\n',tClose(k,itertime));
    fprintf(tCloFile, '%d : \t%f s\n',k, toc);
    disp('closeness_centrality finished');
    
    tic;
    seedsGreedy = greedy(graph,k);
    if k>1
        for j = 1:k-1
            fprintf(greFile,'%4d,',seedsGreedy(j));
        end
    end
    fprintf(greFile,'%4d;',seedsGreedy(k));
    [~,tGreedy(k,:)] = influenceICM(graph,seedsGreedy(1:k),itertime);
    fprintf(greFile,'%4d\n',tGreedy(k,itertime)); 
    fprintf(tGreFile, '%d : \t%f s\n',k, toc);
    disp('greedy finished');
end
fclose(ranFile);
fclose(tRanFile);
fclose(degFile);
fclose(tDegFile);
fclose(cloFile);
fclose(tCloFile);
fclose(greFile);
fclose(tGreFile);