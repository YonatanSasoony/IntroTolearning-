function [allpos,ppos,pneg] = bayeslearn(Xtrain, Ytrain)
  [m,d] = size(Xtrain);

  posYtrain = Ytrain(Ytrain>0);
  [pos_count,~] = size(posYtrain);
  neg_count = m - pos_count;
  allpos = pos_count / m;

  ppos = zeros(d,1);
  pneg = zeros(d,1);

  for i = 1:m
    for j = 1:d
      if (Ytrain(i) > 0)
        ppos(j) = ppos(j) + Xtrain(i,j);
      else
        pneg(j) = pneg(j) + Xtrain(i,j);
      end
    end
  end

  ppos = ppos / pos_count;
  pneg = pneg / neg_count;
end