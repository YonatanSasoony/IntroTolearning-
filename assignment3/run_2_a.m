function void = run_2_a(train0, train1,train3, train5,test0,test1,test3,test5)

  err01 = zeros(10,1);
  err35 = zeros(10,1);
  X = zeros(10,1);
  for i = 1:10
    sample_size = i * 1000;
    X(i) = sample_size;
    [Xtrain01,Ytrain01]  = gensmallm_bin(train0, train1, 0, 1, sample_size);
    [allpos,ppos,pneg] = bayeslearn(Xtrain01, Ytrain01);
    [test01_size,~] = size([test0;test1]);
    [Xtest01,Ytest01]  = gensmallm_bin(test0, test1, 0, 1, test01_size);

    Ypredict = bayespredict(allpos, ppos, pneg, Xtest01);
    err01(i) = calc_err(Ypredict,Ytest01);
    
    
    [Xtrain35,Ytrain35]  = gensmallm_bin(train3, train5, 3, 5, sample_size);
    [allpos,ppos,pneg] = bayeslearn(Xtrain35, Ytrain35);
    [test35_size,~] = size([test3;test5]);
    [Xtest35,Ytest35]  = gensmallm_bin(test3, test5, 3, 5, test35_size);

    Ypredict = bayespredict(allpos, ppos, pneg, Xtest35);
    err35(i) = calc_err(Ypredict,Ytest35);
  end
  
  plot(X,err01,'-ob',X,err35,'-or')
  title("classifications errors as a function of sample size")
  xlabel("sample size")
  ylabel("classifications errors")
  legend("classification errors on 0 and 1","classification errors on 3 and 5")
end

function err = calc_err(Ypredict,Ytest)
  err = 0;
  m = size(Ypredict,1);
  for i = 1:m
    if Ypredict(i) ~= Ytest(i)
      err = err + 1;
    end
  end
  err = err / m;

end