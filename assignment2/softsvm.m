function w = softsvm(lambda, Xtrain, Ytrain)
  [m,d] = size(Xtrain);
 
  u = [zeros(d,1);
       (1.0/m)*ones(m,1)];
       
  H = [eye(d),     zeros(d,m);
       zeros(m,d), zeros(m)] * 2 * lambda;
  
  A3  = Ytrain .* Xtrain;

  A = [zeros(m,d),eye(m);
       A3,        eye(m)];
       
  v = [zeros(m,1);
       ones(m,1)];
  
  z = quadprog(H,u,-A,-v);
  w = z(1:d,:);
end