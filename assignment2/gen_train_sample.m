function [X,Y] = gen_train_sample(Xtrain, Ytrain, samplesize)
  [m,~] = size(Xtrain);
  perm = randperm(m);
  trainind = perm(1:samplesize);
  X = Xtrain(trainind,:);
  Y = Ytrain(trainind);
end
