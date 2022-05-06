clear
k = 2.2*10^-5; % set the diffusion constant (iron)
L = 1; % set the length of the domain
T = 10^5; % set the total time (estimate from k*pi^2*t/L^2 = 1)
dt = 10; % set the time step
Nmodes = 10; % set the number of modes
Nspace = 2000; % set the number of spatial points
x = linspace(0,L,Nspace); % define a grid in space
% c = rand(Nmodes,1) % define random mode amplitudes
c = zeros(Nmodes,1); % define mode amplitues as zero
c(3) = 1; % set a specific mode amplitude  
for t = 0:dt:T % loop through time
    u = zeros(1,Nspace); % set the solution to zero
    for n = 1:Nmodes % loop through the modes
        u = u + c(n).*sin(n*pi*x/L).*exp(-k*(n*pi/L)^2*t); % update the solution
    end
    plot(x,u) % plot the solution
    axis([0 L -1 1]) % set the axes
    xlabel('x')
    ylabel('u')
    title(['time = ', num2str(t)])
    drawnow % force the graphics 
    %pause
end