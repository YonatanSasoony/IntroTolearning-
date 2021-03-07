function [Rx,Ry,Bx,By] = filter_colors(Xtrain,Ytrain)
  Blues = Xtrain(Ytrain > 0,:);
  Bx = Blues(:,1);
  By =  Blues(:,2);
  Reds = Xtrain(Ytrain < 0,:);
  Rx = Reds(:,1);
  Ry = Reds(:,2);
end