function err = calc_err_softsvm(w,X,Y)
  [m,~] = size(X);
  mistake_count = 0;
  for i = 1:m
    guess_label = sign(dot(w,X(i,:)));
    if (Y(i) ~= guess_label)
      mistake_count = mistake_count + 1;
    end
  end
  
  err = mistake_count / m;
end