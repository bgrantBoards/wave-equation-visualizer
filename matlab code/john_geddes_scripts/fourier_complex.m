clear % clear all variables
clf % clear the figure window
L = 1; % define the domain size
x = linspace(-3*L,3*L,1000); %lay down a grid of points
%c0 = integral(@(X) X.^2,-L,L)/(2*L) % compute the first coefficient of the series for x^2
c0 = integral(@(X) heaviside(X),-L,L)/(2*L) % compute the first coefficient of the series for x^2
series = c0*ones(size(x)); % start the series
plot(0,abs(c0),'k*'), hold on
for n = 1:200 % add terms to the series
%     plot(x,series), axis([-3*L 3*L -1 2]) % visualize it
%     title(['Number of terms = ',num2str(n)]) % define a title
    drawnow % force graphics
    %pause % handy dandy pause
    %define the coefficients for the function x^2 on [-L,L] using integrals
%    cn = integral(@(X) X.^2.*exp(i*n*pi*X/L),-L,L)/(2*L) % define the cn coefficient
%    cnegn = integral(@(X) X.^2.*exp(-i*n*pi*X/L),-L,L)/(2*L) % define the c-n coefficient
    %define the coefficients for the function x^2 on [-L,L] using integrals
    cn = integral(@(X) heaviside(X).*exp(i*n*pi*X/L),-L,L)/(2*L) % define the cn coefficient
    cnegn = integral(@(X) heaviside(X).*exp(-i*n*pi*X/L),-L,L)/(2*L) % define the c-n coefficient
    series = series + cn*exp(-i*n*pi*x/L) + cnegn*exp(i*n*pi*x/L); % add to the series
    plot(n,abs(cn),'k*'), hold on
    plot(-n,abs(cnegn),'k*')
end