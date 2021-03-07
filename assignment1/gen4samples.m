function [X,Y] = gen4samples(sampleA, sampleB, sampleC, sampleD, A, B, C, D, samplesize)
%load('mnist_all.mat') then use this function on two digits
alldata = double([sampleA;sampleB;sampleC;sampleD]);
alllabels = [A * ones(size(sampleA,1),1);
             B * ones(size(sampleB,1),1);
             C * ones(size(sampleC,1),1);
             D * ones(size(sampleD,1),1)];
[m,d] = size(alldata);
perm = randperm(m);
trainind = perm(1:samplesize);
X = alldata(trainind,:);
Y = alllabels(trainind);

endfunction
