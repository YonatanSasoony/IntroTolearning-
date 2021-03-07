function [X,Y] = gensmallm(labelAsample, labelBsample, A, B, samplesize)
  %load('mnist_all.mat') then use this function on two digits
  alldata = double([labelAsample;labelBsample]);
  alllabels = [A* ones(size(labelAsample,1),1);B* ones(size(labelBsample,1),1)];
  [m,~] = size(alldata);
  perm = randperm(m);
  trainind = perm(1:samplesize);
  X = alldata(trainind,:);
  Y = alllabels(trainind);
end