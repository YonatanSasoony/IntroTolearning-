function classifier = learnknn (k, Xtrain, Ytrain)
  classifier = @(x) learnknn_helper(k,Xtrain,Ytrain,x);
endfunction

function y = learnknn_helper (k, Xtrain, Ytrain, x)
  #calc y for the specific x using knn algo...
  m = size(Xtrain,1);
  norms = zeros(1,m);

  for (i = 1 : m)
    norms(1,i) = norm(x-Xtrain(i,:));
  endfor
  
  [_, sorted_norms_index] = sort(norms);
  
  histogram = zeros(1,10);
  for (i = 1 : k)
    x_i = sorted_norms_index(1,i);
    y_i = Ytrain(x_i);
    histogram(y_i + 1) = histogram(y_i + 1) + 1;
  endfor
      
  max_shows = 0;
  y = 0;
  for (i = 1 : 10)
    if (histogram(i) > max_shows)
      max_shows = histogram(i) ;
      y = i - 1;
    endif
  endfor
endfunction
