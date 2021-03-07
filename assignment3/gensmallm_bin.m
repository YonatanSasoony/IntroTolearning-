function [X,Y] = gensmallm_bin(labelAsample, labelBsample, A, B, samplesize)
  %load('mnist_all.mat') then use this function on two digits
  alldata = double([labelAsample;labelBsample]);
  alllabels = [A* ones(size(labelAsample,1),1);B* ones(size(labelBsample,1),1)];
  [m,~] = size(alldata);
  perm = randperm(m);
  trainind = perm(1:samplesize);
  X = alldata(trainind,:);
  Y = alllabels(trainind);
  X = mat2bin(X);
  Y = sign(Y - B + 0.5);
end

function bin = mat2bin(mat)
  [m,d] = size(mat);
  bin = zeros(m,d);
  
  for i = 1:m
    for j = 1:d
      if mat(i,j) > 128
        bin(i,j) = 1;
      end
    end
  end
end