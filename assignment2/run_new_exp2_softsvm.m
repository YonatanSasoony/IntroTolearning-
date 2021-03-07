function [X,Y_axe_test,Y_axe_train] = run_new_exp2_softsvm(Xtrain,Ytrain,Xtest,Ytest)

  X = arrayfun(@(x) log(10 ^ (x*5)),[1:3]);
  Y_axe_test = zeros(3,1);
  Y_axe_train = zeros(3,1);
  
  for n = 1:3
    lambda = 10^(n*5)
    [Xsample,Ysample] = gen_train_sample(Xtrain,Ytrain,1000);

    w = softsvm(lambda,Xsample,Ysample);
    
    error_test = calc_err_softsvm(w,Xtest,Ytest);
    error_train = calc_err_softsvm(w,Xtrain,Ytrain);

    Y_axe_train(n) = error_train;
    Y_axe_test(n) = error_test;
  end

end
