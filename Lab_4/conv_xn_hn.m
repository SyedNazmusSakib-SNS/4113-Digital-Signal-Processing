% Step 3: Perform convolution in time-domain
clear all;
close all;
clc;

% Define the index for input signal
m = 0:1:15;  % m goes from 0 to 15 (16 samples)

% Create the input signal: x[m] = (0.8)^m
xn = (0.8).^m;

% Define the index for impulse response
n = 0:1:10;  % n goes from 0 to 10 (11 samples)

% Create the impulse response: h[n] = (1.4)^n
hn = (1.4).^n;

% Calculate lengths
Lx = length(xn);  % Length of x
Lh = length(hn);  % Length of h
L = Lx + Lh - 1;  % Length of output (convolution result)

% Perform convolution in time-domain
yc = conv(xn, hn);

% Create index for output
k = 0:1:L-1;

% Plot all three signals
figure;

% Plot input signal
subplot(1, 3, 1);
stem(m, xn, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
xlabel('Index, m');
ylabel('Input sequence, x(m)');
title('Input Signal x[m]');
grid on;

% Plot impulse response
subplot(1, 3, 2);
stem(n, hn, 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
xlabel('Index, n');
ylabel('Impulse response, h(n)');
title('Impulse Response h[n]');
grid on;

% Plot output (convolution result)
subplot(1, 3, 3);
stem(k, yc, 'g', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
xlabel('Index, k');
ylabel('Output, yc(k)');
title('Output yc[k] = x[m] * h[n]');
grid on;

% Display information
fprintf('===== PART 1: TIME-DOMAIN CONVOLUTION =====\n');
fprintf('Length of input x[m]: %d\n', Lx);
fprintf('Length of impulse response h[n]: %d\n', Lh);
fprintf('Length of output yc[k]: %d (= %d + %d - 1)\n', L, Lx, Lh);
fprintf('\nFirst few values of output yc[k]:\n');
disp(yc(1:5));
fprintf('Maximum value of output: %.2f\n', max(yc));