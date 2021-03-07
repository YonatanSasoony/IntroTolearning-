function h = draw_heatmap(guess_mat,Xtrain,Ytrain)

  h = heatmap(guess_mat);
  colormap([1 0 0;0 0 1])
  grid off

  hs = struct(h);

  hs.XAxis.TickValues = [];
  hs.YAxis.TickValues = [];
  ax = axes();
  ax.Color = 'none';
  hold on
  [Rx,Ry,Bx,By] = filter_colors(Xtrain,Ytrain);
  plot(Bx,By,'blacko', 'MarkerFaceColor', 'b');
  plot(Rx,Ry,'blacko', 'MarkerFaceColor', 'r');

  hold off
  
  hs.XAxis.TickValues = [];
  hs.YAxis.TickValues = [];

  
end