%% Definitions
clear
clf
c = 1; % set the wave speed
L = 10; % set the length of the domain
H = 5; % set the height of the domain
T = 20; % set the total time
dt = 0.1; % set the time step
Nmodes = 10; % set the number of modes (double)
Nspace = 100; % set the number of spatial points
x = linspace(0,L,Nspace); % define a grid in x-space
y = linspace(0,H,Nspace); % define a grid in y-space
[X,Y]=meshgrid(x,y); % define a mesh grid
n = 5;
m = 7;
u = sin(n*pi*X/L).*sin(m*pi*Y/H);
surf(X,Y,u), shading interp
pause
pcolor(X,Y,u), shading interp
%% Set the mode amplitudes directly
A = zeros(Nmodes,Nmodes); % initialize cosine mode amplitudes = 0
A(2,3) = 1; % set A_12 = 1
B = zeros(Nmodes,Nmodes); % initialize sine mode amplitudes = 0
B(2,1) = 0.1; % set B_21 = 1
%% Compute mode amplitudes from initial conditions
alpha = @(X,Y) 0.*exp(-(X-L/2).^2).*exp(-(Y-H/2).^2);
beta= @(X,Y) 0.1*X;
for n = 1:Nmodes
    for m = 1:Nmodes
        rl = sqrt((n*pi/L)^2 + (m*pi/H)^2);
        A(n,m) = 4*integral2(@(X,Y) alpha(X,Y).*sin(n*pi*X/L).*sin(m*pi*Y/H),0,L,0,H)/(L*H); % define the Anm coefficient
        B(n,m) = 4*integral2(@(X,Y) beta(X,Y).*sin(n*pi*X/L).*sin(m*pi*Y/H),0,L,0,H)/(L*H*c*rl); % define the Bnm coefficient
    end
end
fsurf(@(X,Y) alpha(X,Y), [0 L 0 H]), shading interp
pause
%% Compute the solution and visualize
for t = 0:dt:T % loop through time
    u = zeros(Nspace,Nspace); % set the solution to zero
    for n = 1:Nmodes % loop through the x-modes
        for m = 1:Nmodes % loop through the y-modes
            rl = sqrt((n*pi/L)^2 + (m*pi/H)^2);
            u = u + A(n,m).*sin(n*pi*X/L).*sin(m*pi*Y/H).*cos(c*rl*t) + B(n,m).*sin(n*pi*X/L).*sin(m*pi*Y/H).*sin(c*rl*t); % update the solution
        end
    end
    surf(X,Y,u), shading interp % plot the solution
    axis([0 L 0 H -1.5 1.5])
    xlabel('x')
    ylabel('y')
    title(['time = ', num2str(t)])
    drawnow % force the graphics
end