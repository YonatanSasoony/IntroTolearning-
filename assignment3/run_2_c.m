function void = run_2_c(train0, train1,heatmap_kind)
    sample_size = 10000;
    [Xtrain01,Ytrain01]  = gensmallm_bin(train0, train1, 0, 1, sample_size);
    [~,ppos,pneg] = bayeslearn(Xtrain01, Ytrain01);
    
    [~,d] = size(Xtrain01);
    d_sqrt = sqrt(d);
    
    mat_pos = zeros(d_sqrt,d_sqrt);
    mat_neg = zeros(d_sqrt,d_sqrt);
    
    for i = 1:d_sqrt
      for j = 1:d_sqrt
        index = ((i-1) * d_sqrt) + j;
        mat_pos(i,j) = ppos(index);
        mat_neg(i,j) = pneg(index);
      end
    end
    
    if heatmap_kind == 1
      h = heatmap(mat_pos);
    else
      h = heatmap(mat_neg);
    end
end