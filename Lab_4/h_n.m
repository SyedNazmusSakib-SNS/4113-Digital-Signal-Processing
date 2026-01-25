% Step 2: Create and plot both input signal and impulse response
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

% Plot both signals side by side
figure;

% Plot input signal
subplot(1, 2, 1);
stem(m, xn, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
xlabel('Index, m');
ylabel('Input sequence, x(m)');
title('Input Signal x[m] = (0.8)^m');
grid on;

% Plot impulse response
subplot(1, 2, 2);
stem(n, hn, 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
xlabel('Index, n');
ylabel('Impulse response, h(n)');
title('Impulse Response h[n] = (1.4)^n');
grid on;

% Display information
fprintf('Length of input signal x[m]: %d\n', length(xn));
fprintf('Length of impulse response h[n]: %d\n', length(hn));
fprintf('\nFirst few values of x[m]:\n');
disp(xn(1:5));
fprintf('First few values of h[n]:\n');
disp(hn(1:5));