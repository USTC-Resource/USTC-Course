function [NMI,ACC] = evaluation(outputfile,gdfile,k)
    y_list = load(outputfile);
    gd_list = load(gdfile);

    [n,~]=size(y_list);
    %GetModularity
    %clusters = [1:1:n;zeros(1,n);y_list'];
    %MDL = GetModularity(A,clusters);

    %GetPrediction
    y = {};
    gd = {};
    for i=1:1:k
        community = [];
        y{k,1} = community;
        gd{k,1} = community;
    end
    for i=1:1:n
        community = y{y_list(i,1),1};
        l = length(community);
        community(1,l+1)=i;
        y{y_list(i,1),1} = community;
    end
    for i=1:1:n
        community = gd{gd_list(i,1),1};
        l = length(community);
        community(1,l+1)=i;
        gd{gd_list(i,1),1} = community;
    end

    p_y = [];
    p_gd = [];

    %GetOverlapped
    for i=1:1:k
        for j=1:1:k
            temp = intersect(y{i,1},gd{j,1});
            [~,m]=size(temp);
            overlapped(i,j) = m;
        end
        p_y(1,i) = length(y{i,1});
        p_gd(1,i) = length(gd{i,1});
    end

    %calculate NMI
    NMI_overlapped = overlapped./n;
    p_y = p_y./n;
    p_gd = p_gd./n;
    paiewiseMI = NMI_overlapped.*log(NMI_overlapped./((p_y'*ones(1,k)).*(ones(k,1)*p_gd)));
    paiewiseMI(isnan(paiewiseMI)) = 0;
    MI = sum(sum(paiewiseMI));
    paiewise_H_y = p_y.*log(p_y);
    paiewise_H_y(isnan(paiewise_H_y)) = 0;
    H_y = sum(sum(paiewise_H_y));
    paiewise_H_gd = p_gd.*log(p_gd);
    paiewise_H_gd(isnan(paiewise_H_gd)) = 0;
    H_gd = sum(sum(paiewise_H_gd));
    NMI = -2*MI/(H_y+H_gd);



    %calculate ACC
    acc_num = 0;
    for i=1:1:k
        [~,max_row] = max(max(overlapped')');
        [~,max_col] = max(max(overlapped)');
        acc_num = acc_num + overlapped(max_row,max_col);
        overlapped(max_row,:) = [];
        overlapped(:,max_col) = [];   
    end
    ACC = acc_num/n;

end


