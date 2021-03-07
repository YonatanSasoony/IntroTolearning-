function alpha = softsvmrbf(lambda, sigma, Xtrain, Ytrain)
  [m,~] = size(Xtrain);
  
  G = gram_matrix(Xtrain,sigma);

  u = [zeros(m,1);
       (1.0/m)*ones(m,1)]; 

  H = [G,        zeros(m);
       zeros(m), zeros(m)] * 2 * lambda;

  A3 = Ytrain .* G;
  
  A = [zeros(m),eye(m);
       A3,      eye(m)];
       
  v = [zeros(m,1);
       ones(m,1)];
  
  z = quadprog(H,u,-A,-v);
  alpha = z(1:m,:);
end

function gram = gram_matrix(Xtrain,sigma)
  [m,~] = size(Xtrain);
  gram = zeros(m);
  for i= 1:m
    for j = 1:m
      gram(i,j) = K(Xtrain(i,:),Xtrain(j,:),sigma);
    end
  end
end

function g = K(x1,x2,sigma)
  g = exp(-1 .* ((norm(x1 - x2) ^ 2) / (2 * sigma)));
end
