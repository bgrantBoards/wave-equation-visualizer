%% Definitions
clear
c = 1; % set the wave speed
L = 10; % set the length of the domain
T = 20; % set the total time (2*L/c)
dt = 0.1; % set the time step
Nmodes = 100; % set the number of modes
Nspace = 2000; % set the number of spatial points

%% Set the mode amplitudes directly
A = zeros(Nmodes,1); % initialize cosine mode amplitudes = 0
A(2) = 1; % set A_1 = 1
B = zeros(Nmodes,1); % initialize sine mode amplitudes = 0
B(2) = 1/4; % set B_1 = 1

%% Compute mode amplitudes from initial conditions
% eff = @(X) exp(-(X-L/2).^2); % Guassian pulse
% gee = @(X) 0*X/L;
eff = @(X) 0*X + 1.*((5*L/12<X)&(X<7*L/12)); % Rectangular pulse
gee = @(X) 0*X/L;
fplot(@(X) [eff(X),gee(X)],[0,L])
for n = 1:Nmodes
    A(n) = 2*integral(@(X) eff(X).*sin(n*pi*X/L),0,L)/L; % define the An coefficient
    B(n) = 2*integral(@(X) gee(X).*sin(n*pi*X/L),0,L)/(n*pi*c); % define the Bn coefficient
end

%% Compute the solution and visualize
% xx = linspace(-L,2*L,Nspace); % define a set of points on a larger domain
xx = linspace(0,L,Nspace); % define a set of points on a larger domain
j = 1; % set a counter at the start of the time loop
for t = 0:dt:T % loop through time
    uL = zeros(1,Nspace); % set the left traveling solution to zero
    uR = zeros(1,Nspace); % set the right traveling solution to zero
    u = zeros(1,Nspace); % set the solution to zero
    for n = 1:Nmodes % loop through the modes
        uL = uL + 0.5*(A(n)*sin(n*pi*(xx+c*t)/L) - B(n)*cos(n*pi*(xx+c*t)/L)); % update the left traveling solution
        uR = uR + 0.5*(A(n)*sin(n*pi*(xx-c*t)/L) + B(n)*cos(n*pi*(xx-c*t)/L)); % update the right traveling solution
        u = uL + uR; % update the total solution
    end
    plot(xx,uL,'b'), hold on % plot the left traveling solution
    plot(xx,uR,'r') % plot the right traveling solution
    plot(xx,u,'k') % plot the total solution
%     axis([-L 2*L -2 2]) % set the axes
    axis([0 L -2 2]) % set the axes
    xlabel('x')
    ylabel('u')
    title(['time = ', num2str(t)])
    drawnow % force the graphics 
    hold off
    %pause
    usave(j,:) = u; % save the solution
    tsave(j) = t; % save the time
    j = j+1; % advance the time counter
end
[XX,T]=meshgrid(xx,tsave); % make the meshgrid for plotting
% surf(XX,T,usave), shading interp; % plot the solution as a surface
pcolor(XX,T,usave), shading interp; % plot the solution as a pseudo-color contour plot
colorbar;