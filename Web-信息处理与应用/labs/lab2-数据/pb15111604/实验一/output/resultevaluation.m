%polbooks
polbooksNA = zeros(5, 2);
[polbooksNA(1, 1), polbooksNA(1, 2)]= evaluation('polbooks_alinkjaccard.txt', '../polbooks_gd.txt', 3);
[polbooksNA(2, 1), polbooksNA(2, 2)]= evaluation('polbooks_girvannewman.txt', '../polbooks_gd.txt', 3);
[polbooksNA(3, 1), polbooksNA(3, 2)]= evaluation('polbooks_rcut.txt', '../polbooks_gd.txt', 3);
[polbooksNA(4, 1), polbooksNA(4, 2)]= evaluation('polbooks_ncut.txt', '../polbooks_gd.txt', 3);
[polbooksNA(5, 1), polbooksNA(5, 2)]= evaluation('polbooks_modularity.txt', '../polbooks_gd.txt', 3);
%football
footballNA = zeros(5, 2);
[footballNA(1, 1), footballNA(1, 2)]= evaluation('football_alinkjaccard.txt', '../football_gd.txt', 12);
[footballNA(2, 1), footballNA(2, 2)]= evaluation('football_girvannewman.txt', '../football_gd.txt', 12);
[footballNA(3, 1), footballNA(3, 2)]= evaluation('football_rcut.txt', '../football_gd.txt', 12);
[footballNA(4, 1), footballNA(4, 2)]= evaluation('football_ncut.txt', '../football_gd.txt', 12);
[footballNA(5, 1), footballNA(5, 2)]= evaluation('football_modularity.txt', '../football_gd.txt', 12);