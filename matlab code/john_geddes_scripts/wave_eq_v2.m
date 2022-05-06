%% Definitions
clear
c = 1; % set the wave speed
L = 10; % set the length of the domain
T = 20; % set the total time (2*L/c)
dt = 0.1; % set the time step
Nmodes = 100; % set the number of modes
Nspace = 2000; % set the number of spatial points
x = linspace(0,L,Nspace); % define a grid in space
%% Set the mode amplitudes directly
A = zeros(Nmodes,1); % initialize cosine mode amplitudes = 0
A(2) = 1; % set A_1 = 1
B = zeros(Nmodes,1); % initialize sine mode amplitudes = 0
B(2) = 1/4; % set B_1 = 1
%% Compute mode amplitudes from initial conditions
eff = @(X) 2*X/L.*(X<L/2)+(2-(2*X/L)).*(X>=L/2);
gee = @(X) 0*X;
eff = @(X) exp(-(X-L/2).^2);
gee = @(X) 0*X/L;
fplot(@(X) [eff(X),gee(X)],[0,L])
for n = 1:Nmodes
A(n) = 2*integral(@(X) eff(X).*sin(n*pi*X/L),0,L)/L; % define the An coefficient
B(n) = 2*integral(@(X) gee(X).*sin(n*pi*X/L),0,L)/(n*pi*c); % define the Bn coefficient
end
pause
%% Compute the solution and visualize
for t = 0:dt:T % loop through time
    u = zeros(1,Nspace); % set the solution to zero
    for n = 1:Nmodes % loop through the modes
        u = u + sin(n*pi*x/L).*(A(n).*cos(n*pi*c*t/L) + B(n).*sin(n*pi*c*t/L)); % update the solution
    end
    plot(x,u) % plot the solution
    axis([0 L -2 2]) % set the axes
    xlabel('x')
    ylabel('u')
    title(['time = ', num2str(t)])
    drawnow % force the graphics 
    %pause
end