%% Definitions
clear
R = 2; % set the radial size of the domain
Theta = 2*pi; % set the angular size of the domain
Nmodes = 100; % set the number of modes
Nspace = 200; % set the number of spatial points
r = linspace(0,R,Nspace); % define a grid in r space
theta = linspace(0,Theta,Nspace); % define a grid in theta space
[rr,tt]=meshgrid(r,theta); % define a mesh grid in r-theta space
%% Set the mode amplitudes directly
A0 = 1;
A = zeros(Nmodes,1); % initialize mode amplitudes = 0
B = zeros(Nmodes,1);
%A(3) = 1; % set A_1 = 1
B(2) = 1;
%% Compute mode amplitudes from boundary conditions
eff = @(TH) TH./TH; % constant value of 1
eff = @(TH) exp(-(2*TH).^2); % Guassian pulse
eff = @(TH) sin(5.*TH);
%gee = @(Y) 0*Y + 1.*((5*H/12<Y)&(Y<7*H/12)); % Rectangular pulse
% fplot(@(Y) gee(Y),[0,H])
A0 = integral(@(TH) eff(TH),-pi,pi)/(2*pi);
for n = 1:Nmodes
    A(n) = integral(@(TH) eff(TH).*cos(n*TH),-pi,pi)/(pi.*R.^n); % define the An coefficient
    B(n) = integral(@(TH) eff(TH).*sin(n*TH),-pi,pi)/(pi.*R.^n); % define the Bn coefficient
end
%% Compute the solution and visualize
u = zeros(Nspace,Nspace); % set the solution to zero
u = u + A0; % add in the constant term
for n = 1:Nmodes % loop through the modes
    u = u + A(n).*(rr.^n).*cos(n.*tt) + B(n).*(rr.^n).*sin(n.*tt); % update the solution
end

xx = rr.*cos(tt); % define the x coordinates
yy = rr.*sin(tt); % define the y coordinates
surf(xx,yy,u), shading interp; % plot the solution as a surface
%pcolor(xx,yy,u), shading interp; % plot the solution as a pseudo-color contour plot
xlabel('x')
ylabel('y')
