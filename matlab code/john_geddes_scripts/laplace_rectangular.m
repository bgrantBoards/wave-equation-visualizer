%% Definitions
clear
L = 1; % set the length of the domain
H = 2; % set the height of the domain
Nmodes = 100; % set the number of modes
Nspace = 200; % set the number of spatial points
x = linspace(0,L,Nspace); % define a grid in x space
y = linspace(0,H,Nspace); % define a grid in y space
[xx,yy]=meshgrid(x,y); % define a mesh grid
%% Set the mode amplitudes directly
A = zeros(Nmodes,1); % initialize mode amplitudes = 0
A(3) = 1; % set A_1 = 1
%% Compute mode amplitudes from initial conditions
%gee = @(Y) Y./Y; % constant value of 1
%gee = @(Y) exp(-(2*(Y-H/2)).^2); % Guassian pulse
%gee = @(Y) 0*Y + 1.*((5*H/12<Y)&(Y<7*H/12)); % Rectangular pulse
% fplot(@(Y) gee(Y),[0,H])
% for n = 1:Nmodes
%     A(n) = 2*integral(@(Y) gee(Y).*sin(n*pi*Y/H),0,H)/(H*sinh(n*pi*(-L)/H)); % define the An coefficient
% end
%% Compute the solution and visualize
u = zeros(Nspace,Nspace); % set the solution to zero
for n = 1:Nmodes % loop through the modes
    u = u + A(n).*sinh(n*pi*(xx-L)/H).*sin(n*pi*yy/H); % update the solution
end
surf(xx,yy,u), shading interp; % plot the solution as a surface
%pcolor(xx,yy,u), shading interp; % plot the solution as a pseudo-color contour plot
xlabel('x')
ylabel('y')