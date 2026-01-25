clear all;
close all;
clc;

% Parameters
A = 5;
F = 100;
b = 3;
Fs = 5000;

% Time period
T = 1/F;

% Time vector for analog signal
tmin = 0;
tmax = 2*T;
dt = T/100;
t = tmin:dt:tmax;

% Analog signal
xt = A*sin(2*pi*F*t);

% Plot analog signal
figure;
plot(t, xt, '-ks');
title('Analog Signal');
xlabel('t');
ylabel('x(t)');
grid on;

% Sampling
Ts = 1/Fs;
ts = tmin:Ts:tmax;
n = 0:length(ts)-1;
f = F/Fs;
xs = A*sin(2*pi*f*n);

% Plot sampled signal
figure;
plot(n, xs, 'bd');
title('Sampled Signal');
xlabel('n');
ylabel('xs(n)');
grid on;

% Quantization
L = 2^b - 1;
del = 2*A/L;
xn = xs/del;
xn = xn - min(xn);
xq = round(xn);
en = xq - xn;

% Plot quantization
figure;
plot(n, xn, 'r-', n, xq, 'bo', n, en, 'g*');
title('Quantization');
xlabel('n');
ylabel('Signal');
legend('xn', 'xq', 'en');
grid on;

% SQNR
Px = A^2/2;
Pe = A^2/(3*2^(2*b));
SQNR = 10*log10(Px/Pe);
fprintf('SQNR = %.2f dB\n', SQNR);

% Coding
xc = dec2bin(xq, b);
disp('Coded sequence (first 10 samples):');
disp(xc(1:min(10, length(xq)), :));

% Reconstruction
xr = (bin2dec(xc) - L/2)*del;

% Plot reconstruction
figure;
plot(t, xt, 'r-', ts, xr, 'b*');
title('Reconstruction');
xlabel('t');
ylabel('Signal');
legend('Original', 'Reconstructed');
grid on;