clear % clear all variables
clf % clear the figure window
L = 1; % define the domain size
x = linspace(-3*L,3*L,1000); %lay down a grid of points
%a0 = 1/4 % define the first a coeff for the function f=0 for x<L/2 and f = 1 for x > L/2
a0 = integral(@(X) X.^2,-L,L)/(2*L) % compute the first coefficient of the series for x^2
series = a0*ones(size(x)); % start the series
for n = 1:200 % add terms to the series
    plot(x,series), axis([-3*L 3*L -1 2]) % visualize it
    title(['Number of terms = ',num2str(n)]) % define a title
    drawnow % force graphics
    %pause % handy dandy pause
    %define the coefficients for f=0 for x<L/2 and f=1 for x>L/2
    %a = (sin(n*pi)-sin(n*pi/2))/(n*pi) % define the a coefficient
    %b = (cos(n*pi/2)-cos(n*pi))/(n*pi) % define the b coefficient
    %define the coefficients for the function x^2 on [-L,L] using integrals
    a = integral(@(X) X.^2.*cos(n*pi*X/L),-L,L)/L % define the a coefficient
    b = integral(@(X) X.^2.*sin(n*pi*X/L),-L,L)/L % define the b coefficient
    series = series + a*cos(n*pi*x/L) + b*sin(n*pi*x/L); % add to the series
end