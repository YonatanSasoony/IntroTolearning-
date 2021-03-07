function [guess_mat,h_w] = run_ex4_d_rbf(Xtrain,Ytrain,sigma)
  lambda = 100;
  
  w = softsvmrbf(lambda,sigma,Xtrain,Ytrain);
  h_w = h_w_rbf(Xtrain,w,sigma);
  
  % matrix with values of -9 -> 9 X -9 -> 9 with jumps of 0.1 ->  
  
  axeX = -9:0.1:9;
  
  [X,Y] = meshgrid(axeX);
  [n,~] = size(X);
  
  guess_mat = zeros(n,n);
  
  for i = 1:n 
    for j = 1:n
      guess_mat(i,j) = h_w([X(i,j),Y(i,j)]);
    end
  end  
end

function h_w = h_w_rbf(Xtrain,w,sigma)
[m,~] = size(Xtrain);
h_w = @(x) h_w_helper(w,x,m,sigma,Xtrain);
end

function g = K(x1,x2,sigma)
  g = exp(-1 * ((norm(x1-x2) ^ 2) / (2 * sigma)));
end

function res = h_w_helper(w,x,m,sigma,Xtrain)
  sum = 0;
  for i = 1:m
    sum =sum + ( w(i) * K(Xtrain(i,:),x,sigma) );
  end
  res = sign(sum);
end