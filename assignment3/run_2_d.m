function [switch_to_pos01,switch_to_neg01,switch_to_pos35,switch_to_neg35] = run_2_d(train0, train1, test0, test1,train3, train5, test3, test5)
    
    sample_size = 10000;
    [Xtrain,Ytrain]  = gensmallm_bin(train0, train1, 0, 1, sample_size);
    [allpos,ppos,pneg] = bayeslearn(Xtrain, Ytrain);
    
    [test_size,~] = size([test0;test1]);
    [Xtest,~]  = gensmallm_bin(test0, test1, 0, 1, test_size);

    Ypredict075 = bayespredict(0.75, ppos, pneg, Xtest);
    Ypredict = bayespredict(allpos, ppos, pneg, Xtest);

    [switch_to_pos01,switch_to_neg01] = calc_switches(Ypredict,Ypredict075);
    
  
    [Xtrain,Ytrain]  = gensmallm_bin(train3, train5, 3, 5, sample_size);
    [allpos,ppos,pneg] = bayeslearn(Xtrain, Ytrain);
    
    [test_size,~] = size([test3;test5]);
    [Xtest,~]  = gensmallm_bin(test3, test5, 3, 5, test_size);

    Ypredict075 = bayespredict(0.75, ppos, pneg, Xtest);
    Ypredict = bayespredict(allpos, ppos, pneg, Xtest);
    
    
    [switch_to_pos35,switch_to_neg35] = calc_switches(Ypredict,Ypredict075);  
end

function [switch_to_pos,switch_to_neg] = calc_switches(Ypredict,Ypredict075)
    switch_to_neg = 0;
    switch_to_pos = 0;
    for i = 1:size(Ypredict,1)
      if Ypredict(i) == 1 && Ypredict075(i) == -1
        switch_to_neg = switch_to_neg + 1;
      end
      if Ypredict(i) == -1 && Ypredict075(i) == 1
        switch_to_pos = switch_to_pos + 1;
      end
    end
    switch_to_neg = switch_to_neg / size(Ypredict,1);
    switch_to_pos = switch_to_pos / size(Ypredict,1);
end