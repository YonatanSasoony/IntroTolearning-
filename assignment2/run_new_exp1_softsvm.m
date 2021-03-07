function [X,Y_axe_test,Y_axe_train] = run_new_exp1_softsvm(Xtrain,Ytrain,Xtest,Ytest)
  % Y_axe(i) - triplet of [avg,max,min] 

  X = arrayfun(@(x) log(10 ^ (x)),[5:15]);
  Y_axe_test = [];
  Y_axe_train = [];
  
	for n = 5:15
    lambda = 10^n;
    test_errors = zeros(10,1);
    train_errors = zeros(10,1);

    for i = 1:10
      [Xsample,Ysample] = gen_train_sample(Xtrain,Ytrain,100);
      w = softsvm(lambda,Xsample,Ysample);
      train_errors(i) = calc_err_softsvm(w,Xsample,Ysample);
      test_errors(i) = calc_err_softsvm(w,Xtest,Ytest);
    end
    train_err = [sum(train_errors) / 10.0,max(train_errors),min(train_errors)] ;
    Y_axe_train = [Y_axe_train;train_err];
    
    test_err = [sum(test_errors) / 10.0,max(test_errors),min(test_errors)] ;
    Y_axe_test = [Y_axe_test;test_err];
	end
end