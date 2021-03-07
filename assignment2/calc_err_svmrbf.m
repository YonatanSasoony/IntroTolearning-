function err = calc_err_svmrbf(h_w,X,Y)
  
  [m,~] = size(X);
  mistake_count = 0;
  for i = 1:m
    guess_label = h_w(X(i,:));
    if (Y(i) ~= guess_label)
      mistake_count = mistake_count + 1;
    end
  end
  err = mistake_count / m;
end
