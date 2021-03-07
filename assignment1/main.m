function [X,Y,MIN_ERRS,MAX_ERRS] = main(trainA,trainB,trainC,trainD,testA,testB,testC,testD)
  %load('mnist_all.mat') 
  [Xtest,Ytest] =  gen4samples(testA,testB,testC,testD,1,3,4,6,size(testA) + size(testB) + size(testC) + size(testD));
  [X,Y,MIN_ERRS,MAX_ERRS] = get_graph(trainA,trainB,trainC,trainD,Xtest,Ytest);  
endfunction

function  [X,Y,MIN_ERRS,MAX_ERRS] = get_graph(trainA,trainB,trainC,trainD,Xtest,Ytest)
  X = zeros(10,1);
  Y = zeros(10,1);
  MIN_ERRS = zeros(10,1);
  MAX_ERRS = zeros(10,1);
  for (i = 1 : 10)
    sample_size = i * 10;
    X(i) = sample_size;
    errors = zeros(10,1);
    for (j = 1: 10)
      errors(j) = calculate_error(sample_size,trainA,trainB,trainC,trainD,Xtest,Ytest);
    endfor
    Y(i) = sum(errors) / 10;
    MIN_ERRS(i) = min(errors);
    MAX_ERRS(i) = max(errors);
  endfor
endfunction

function  err = calculate_error(sample_size,trainA,trainB,trainC,trainD,Xtest,Ytest)
  [Xtrain, Ytrain] = gen4samples(trainA,trainB,trainC,trainD,1,3,4,6,sample_size);
  trained_classifier = learnknn(1,Xtrain,Ytrain);
  Ytest_predictor = predictknn(trained_classifier,Xtest);
  
  err = mean(Ytest ~= Ytest_predictor);
endfunction
