clear all;
close all;
clc;

% Parameters
A = 5;
F = 100;
Fs = 5000;

% Time setup
T = 1/F;
tmin = 0;
tmax = 2*T;
dt = T/100;
t = tmin:dt:tmax;
Ts = 1/Fs;
ts = tmin:Ts:tmax;
n = 0:length(ts)-1;
f = F/Fs;

% Original analog signal
xt = A*sin(2*pi*F*t);

% Sampled signal
xs = A*sin(2*pi*f*n);

% Plot setup
figure;
hold on;

colors = ['r', 'g', 'b', 'm', 'c'];
legends = cell(1, 6);
legends{1} = 'Original';

plot(t, xt, 'k-', 'LineWidth', 1.5);

% Reconstruct for b = 1 to 5
for b = 1:5
    L = 2^b - 1;
    del = 2*A/L;
    xn = xs/del;
    xn = xn - min(xn);
    xq = round(xn);
    xc = dec2bin(xq, b);
    xr = (bin2dec(xc) - L/2)*del;
    
    plot(ts, xr, [colors(b), 'o-']);
    legends{b+1} = sprintf('b = %d', b);
end

title('Reconstructed Signals for Different Bit Numbers');
xlabel('t');
ylabel('Signal');
legend(legends);
grid on;
hold off;

