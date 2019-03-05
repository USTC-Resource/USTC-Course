% polbooks部分.
load( 'polbooks.mat' );
% 调用alinkjaccard
outcome = alinkjaccard( A, k );
% 将矩阵写入到 ASCII 分隔文件
dlmwrite( 'output/polbooks_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% 调用gn
outcome = girvannewman( A, k );
dlmwrite( 'output/polbooks_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% 调用rcut
outcome = rcut( A, k );
dlmwrite( 'output/polbooks_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% 调用ncut
outcome = ncut( A, k );
dlmwrite( 'output/polbooks_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% 调用modularity
outcome = modularity( A, k );
dlmwrite( 'output/polbooks_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% football部分.
load( 'football.mat' );
outcome = alinkjaccard( A, k );
dlmwrite( 'output/football_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = girvannewman( A, k );
dlmwrite( 'output/football_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( A, k );
dlmwrite( 'output/football_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( A, k );
dlmwrite( 'output/football_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( A, k );
dlmwrite( 'output/football_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% DBLP部分.
load( 'DBLP.mat' );
outcome = alinkjaccard( A, k );
dlmwrite( 'output/DBLP_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( A, k );
dlmwrite( 'output/DBLP_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( A, k );
dlmwrite( 'output/DBLP_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( A, k );
dlmwrite( 'output/DBLP_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% Egonet部分.
load( 'Egonet.mat' );
k = 18;
outcome = alinkjaccard( x, k );
dlmwrite( 'output/Egonet_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( x, k );
dlmwrite( 'output/Egonet_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( x, k );
dlmwrite( 'output/Egonet_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( x, k );
dlmwrite( 'output/Egonet_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% 两个巨头单独处理.
load( 'DBLP.mat' );
outcome = girvannewman( A, k );
dlmwrite( 'output/DBLP_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
load( 'Egonet.mat' );
k = 18;
outcome = girvannewman( x, k );
dlmwrite( 'output/Egonet_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );