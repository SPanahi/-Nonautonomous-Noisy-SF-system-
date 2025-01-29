function [t,x] = ode_Noise(f,g,t,x0,sigma)
% has non-negative clipping

% Van den Broeck, Christian, et al. "Nonequilibrium phase transitions induced by multiplicative noise." Physical Review E 55.4 (1997): 4084
% dx/dt = f(t,x) + yita(t), without g

% sigma is a column vector (for each dim) about the scales of the noise level in
% each dimension

d = length(x0); % system dimension
x = zeros(d,length(t)); % output time series
x(:,1) = x0; % setting initial condition
h = t(2) - t(1); % temporal step length

for step_i = 1: length(t)-1
    w = sqrt(h) * sigma .* randn(d,1);
    y = x(:,step_i) + h * f(t(step_i),x(:,step_i)) ...
        + g(x(:,step_i)) .* w;
    y = max(y,0); % non-negative clipping

    x_new = x(:,step_i) + h/2 * ( f(t(step_i),x(:,step_i)) + f(t(step_i),y) )...
        + (g(x(:,step_i))+g(y))/2 .* w;

    x(:,step_i + 1) = abs(x_new); % non-negative clipping

end

x = x';

end

