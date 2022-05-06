%% Create figure and give it callback functions
F = figure('NumberTitle', 'off'); set(F, 'Renderer', 'OpenGL'); hold on;
ylim([-5 5]);

% define control points
ctrl_xs = 0:10;
ctrl_ys = zeros(1, 11);

% define spline between control points
s = Spline(ctrl_xs, ctrl_ys, 100, gca, "my_spline");

% plot spline without ctrl points
s.plot(false);

% plot(ctrl_xs, ctrl_ys, "o")
p = plot(ctrl_xs, ctrl_ys, "o", 'buttondownfcn', ...
    {@Mouse_Callback,s,"down"});


% Callback function for each point
function Mouse_Callback(hObj,~,spline,action)
    persistent cur_obj ctrl_xs ctrl_ys ctrl_idx
    pos = get(gca,'CurrentPoint');

    switch action
        case 'down'
            cur_obj = hObj;
            ctrl_xs = get(hObj,'xdata');
            ctrl_ys = get(hObj,'ydata');
            [~,ctrl_idx] = min(sum((ctrl_xs-pos(1)).^2+(ctrl_ys-pos(3)).^2,1));
            set(gcf,...
                'WindowButtonMotionFcn',  {@Mouse_Callback,spline,'move'},...
                'WindowButtonUpFcn',      {@Mouse_Callback,spline,'up'});
        case 'move'
            % vertical move control point
            ctrl_ys(ctrl_idx) = pos(3);
            set(cur_obj,'ydata',ctrl_ys)

            % update spline
            spline.update(ctrl_xs, ctrl_ys);

        case 'up'
            set(gcf,...
                'WindowButtonMotionFcn',  '',...
                'WindowButtonUpFcn',      '');
    end
end