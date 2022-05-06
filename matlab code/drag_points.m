%% Create figure and give it callback functions
F = figure('NumberTitle', 'off'); set(F, 'Renderer', 'OpenGL');

% set(F, 'WindowButtonDownFcn', @MouseClick);
% set(F, 'WindowButtonMotionFcn', @MouseMove);
% set(F, 'WindowScrollWheelFcn', @MouseScroll);
% set(F, 'KeyPressFcn', @KeyPress );




% Plot a line and points
hold on; ylim([-10 10])
% points = [zeros(1,10); 1:10] 
points = struct("x", 1:10, "y", zeros(1,10));

xx = linspace(points.x(1), points.x(end), 100);
yy = spline(points.x, points.y, xx);
plot(points.x, points.y, "o", xx, yy)

scatter(points.x, points.y,'o','buttondownfcn',{@Mouse_Callback,'down'},'MarkerFaceColor','flat');


% Callback function for each point
function Mouse_Callback(hObj,~,action)
    persistent curobj xdata ydata ind 
    pos = get(gca,'CurrentPoint');
    switch action
      case 'down'
          curobj = hObj;
          xdata = get(hObj,'xdata');
          ydata = get(hObj,'ydata');
          [~,ind] = min(sum((xdata-pos(1)).^2+(ydata-pos(3)).^2,1));
          set(gcf,...
              'WindowButtonMotionFcn',  {@Mouse_Callback,'move'},...
              'WindowButtonUpFcn',      {@Mouse_Callback,'up'});
      case 'move'
          % vertical move
          ydata(ind) = pos(3);
          set(curobj,'ydata',ydata)
      case 'up'
          set(gcf,...
              'WindowButtonMotionFcn',  '',...
              'WindowButtonUpFcn',      '');
    end
end