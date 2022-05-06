classdef Spline < handle
    %SPLINE Class for storing a spline's data and its plot handle

    properties
        name     % name of the spline

        ctrl_xs  % vector of control point x values
        ctrl_ys  % vector of control point y values
        xs       % vector of spline x values
        ys       % vector of spline y values
        method   % interpolation method
        
        axes        % axes to plot on
        spline_plot % spline plot handle
        ctrl_plot   % control points plot handle
    end

    methods
        function obj = Spline(ctrl_xs, ctrl_ys, res, axes, name)
            %SPLINE Construct an instance of this class
            %   ctrl_xs: vector of control point x values
            %   ctrl_ys: vector of control point y values
            %   res: number of points in the spline interpolation

            % set control point propeties
            obj.ctrl_xs = ctrl_xs;
            obj.ctrl_ys = ctrl_ys;

            % compute spline x values
            obj.xs = linspace(ctrl_xs(1), ctrl_xs(end), res);

            % set default interpolation method
            obj.method = "pchip";

            % set axes handle
            obj.axes = axes;

            % set name
            obj.name = name;

            % compute spline y values
            obj.update(ctrl_xs, ctrl_ys);
        end

        function plot(obj, plot_ctrls, varargin)
            %PLOT Create a plot of the spline and control points
            % on the spline's axes

            % plot spline
            obj.spline_plot = plot(obj.axes, obj.xs, obj.ys, varargin{:});
            
            if plot_ctrls
                % plot control points
                obj.ctrl_plot = plot(obj.axes, obj.ctrl_xs, obj.ctrl_ys, ...
                    "o", 'DisplayName',obj.name, varargin{:});
            end
        end

        function update(obj, new_ctrl_xs, new_ctrl_ys)
            %UPDATE update the spline with new control points

            % set new control points
            obj.ctrl_xs = new_ctrl_xs;
            obj.ctrl_ys = new_ctrl_ys;

            % compute interpolation
            obj.ys = interp1(new_ctrl_xs, new_ctrl_ys, obj.xs, obj.method);

            % update spline plot y data
            set(obj.spline_plot,'ydata',obj.ys)
        end

        function reset(obj)
            % reset spline and control points to lie on the x-axis
            obj.ctrl_plot.YData = zeros(1, length(obj.ctrl_plot.XData));
            obj.update(obj.ctrl_xs, zeros(1, length(obj.ctrl_xs)));
        end

        function pp = get_pp(obj)
            %GET_PP return the piecewise polynomial function of this spline
            pp = interp1(obj.ctrl_xs, obj.ctrl_ys, obj.method, 'pp');
        end
    end
end