clear
c = 1; % set the wave speed
L = 10; % set the length of the domain
T = 20; % set the total time 
dt = 0.1; % set the time step
Nmodes = 10; % set the number of modes
Nspace = 2000; % set the number of spatial points
x = linspace(0,L,Nspace); % define a grid in space
A = rand(Nmodes,1) % define cosine mode amplitudes
%A(1) = 1
%A(4) = 0.5;
B = zeros(Nmodes,1) % define sine mode amplitudes
B(1) = 0;
for t = 0:dt:T % loop through time
    u = zeros(1,Nspace); % set the solution to zero
    for n = 1:Nmodes % loop through the modes
        u = u + sin(n*pi*x/L).*(A(n).*cos(n*pi*c*t/L) + B(n).*sin(n*pi*c*t/L)); % update the solution
    end
    plot(x,u) % plot the solution
    axis([0 L -1 1]) % set the axes
    xlabel('x')
    ylabel('u')
    title(['time = ', num2str(t)])
    drawnow % force the graphics 
    %pause
end