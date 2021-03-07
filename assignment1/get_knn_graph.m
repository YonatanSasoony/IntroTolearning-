function [X,Y] = get_knn_graph(trainA,trainB,trainC,trainD,testA,testB,testC,testD)
  [Xtrain, Ytrain] = gen4samples(trainA,trainB,trainC,trainD,1,3,4,6,100);
  [Xtest,Ytest] =  gen4samples(testA,testB,testC,testD,1,3,4,6,size(testA) + size(testB) + size(testC) + size(testD));

  X = zeros(11,1);
  Y = zeros(11,1);
  for (k = 1:11)
    X(k) = k;
    errors = zeros(10,1);
    for (i=1:10)
      errors(i) = calc_err(k,Xtrain,Ytrain,Xtest,Ytest);
    endfor
      Y(k) = sum(errors) / 10;
  endfor
endfunction

function err = calc_err(k,Xtrain,Ytrain,Xtest,Ytest)
  trained_classifier = learnknn(k,Xtrain,Ytrain);
  Ytest_predictor = predictknn(trained_classifier,Xtest);
  err = mean(Ytest ~= Ytest_predictor);
endfunction
