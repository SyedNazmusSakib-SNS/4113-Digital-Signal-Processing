% Step 1: Create and plot the input signal x[m]
clear all;
close all;
clc;

% Define the index for input signal
m = 0:1:15;  % m goes from 0 to 15 (16 samples)

% Create the input signal: x[m] = (0.8)^m
xn = (0.8).^m;

% Plot the input signal
figure;
stem(m, xn, 'b', 'LineWidth', 1.5);
xlabel('Index, m');
ylabel('Input sequence, x(m)');
title('Input Signal x[m] = (0.8)^m');
grid on;

% Display some information
fprintf('Length of input signal x[m]: %d\n', length(xn));
fprintf('First few values of x[m]:\n');
disp(xn(1:5));