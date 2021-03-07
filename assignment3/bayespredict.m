function Ypredict = bayespredict(allpos, ppos, pneg, Xtest)
  [m_tag,d] = size(Xtest);
  Ypredict = zeros(m_tag,1);

  for i=1:m_tag
    Ypredict(i) = predict(allpos,ppos,pneg,Xtest(i,:),d);
  end
end

function guess = predict(allpos,ppos,pneg,x,d)
  pos_sum = 0;
  neg_sum = 0;
  isNaN = 0;
  for i = 1:d
    if logical(isnan(ppos(i))) + isnan(pneg(i)) > 0
      isNaN = 1;
    elseif x(i) == 1
      pos_sum = pos_sum + log(ppos(i) / pneg(i));
    else
      neg_sum = neg_sum + log((1-pneg(i))/(1-ppos(i)));
    end
  end   
   
  if isNaN == 1 || isnan(log(allpos/(1-allpos)) + pos_sum - neg_sum)
    guess = 0;
  else
    guess = sign(log(allpos/(1-allpos)) + pos_sum - neg_sum);
  end
  % if NaN -> return 0
end