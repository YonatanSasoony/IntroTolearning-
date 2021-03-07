function [best_alpha,epsilon,test_error] = k_fold_cross_validation(Xtrain,Ytrain,Xtest,Ytest,k,algo,psi, isRBF)

  [m,~] = size(Xtrain);
  row_dist = ones(k,1) * (m/k);
  Xs = mat2cell(Xtrain,row_dist); %cell
  Ys = mat2cell(Ytrain,row_dist); %cell
  [psi_len,~] = size(psi);
  epsilon = zeros(psi_len,1);

  for a = 1:psi_len
    alpha = psi(a,:);
    sum = 0;
    for i = 1:k
      Xv = cell2mat(Xs(i)); % mat
      Yv = cell2mat(Ys(i)); % mat
      Xs_tag = sub_s(Xs,i,k); %cell
      Ys_tag = sub_s(Ys,i,k); %cell
      
      Xs_tag = rearrange(Xs_tag); % mat
      Ys_tag = rearrange(Ys_tag); % mat
      [m_tag,~] = size(Xs_tag);

      w = algo(alpha,Xs_tag,Ys_tag); 
      if isRBF == 1
        h_w = @(x) h_w_helper(w,x,m_tag,alpha(2),Xs_tag);
      else
        h_w = @(x) sign(dot(w,x));
      end  
      sum = sum + calc_err(h_w,Xv,Yv);
    end
    epsilon(i) = sum / k;
  end
  best_alpha = argmin(epsilon,psi);
  w = algo(best_alpha,Xtrain,Ytrain);
  
  if isRBF == 1
    best_h_w = @(x) h_w_helper(w,x,m,best_alpha(2),Xtrain);
  else
    best_h_w = @(x) sign(dot(w,x));
  end
  test_error = calc_err(best_h_w,Xtest,Ytest);
end

function res = sub_s(S,i,k)
  res = [];
  for j = 1:k
    if (j~= i)
      res = [res,S(j,:)];
    end
  end
end

function arranged = rearrange(Xcell)
  [~,m] = size(Xcell);
  arranged = [];
  
  for i = 1:m
    arranged = [arranged ; cell2mat(Xcell(1,i))];
  end
  
end

function res = h_w_helper(w,x,m,sigma,Xtrain)
  sum = 0;
  for i = 1:m
    sum =sum + ( w(i) * K(Xtrain(i,:),x,sigma) );
  end
  res = sign(sum);
end

function err = calc_err(h_w,Xtest,Ytest)
  [n,~] = size(Xtest);
  sum = 0;
  for i = 1:n
    guess_label = h_w(Xtest(i,:));
    if (guess_label ~= Ytest(i))
      sum = sum + 1;
    end
  end
  err = 1 / n * sum;
end

function res = argmin(epsilon,psi)
  [epsilon_len,~] = size(epsilon);
  epsilon_min = min(epsilon); 
  res = [];
  for a = 1:epsilon_len
    if (epsilon(a) == epsilon_min)
      res = psi(a,:);
    end
  end
end

function g = K(x1,x2,sigma)
  g = exp(-1 * ((norm(x1-x2) ^ 2) / (2 * sigma)));
end