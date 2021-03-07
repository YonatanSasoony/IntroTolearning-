function Ytestprediction = predictknn(classifier, Xtest)
  n = size(Xtest,1);
  Ytestprediction = zeros(n,1);
  for (i = 1 : n)
    Ytestprediction(i) = classifier(Xtest(i,:));
  endfor
endfunction

%!test
%!  k1 = 1
%!  Xtrain1 = [1, 2; 3, 4; 5, 6]
%!  Ytrain1 = [1; 0; 1]
%!  classifier1 = learnknn(k1, Xtrain1, Ytrain1)
%!  Xtest1 = [10, 11; 3.1, 4.2; 2.9, 4.2; 5, 6]
%!  assert(predictknn(classifier1, Xtest1), [1; 0; 0; 1])

%!test
%!  k2 = 3
%!  Xtrain2 = [6, 5; 4.5, -3; 4, 5; 4, -2; 7, -4; 3.1, -3.2; 6, 7; 4, 7; 5, 3; 3.4, 3]
%!  Ytrain2 = [2; 0; 4; 1; 1; 1; 3; 2; 2; 4]
%!  classifier2 = learnknn(k2, Xtrain2, Ytrain2)
%!  Xtest2 = [4.5, -3; 5, 6; 5, 4; 3, 4]
%!  assert(predictknn(classifier2, Xtest2), [0; 2; 2; 4])