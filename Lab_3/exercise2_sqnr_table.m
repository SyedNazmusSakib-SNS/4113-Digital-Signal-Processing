% Exercise 2: SQNR vs Bit Analysis
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
Ts = 1/Fs;
ts = tmin:Ts:tmax;
n = 0:length(ts)-1;
f = F/Fs;
xs = A*sin(2*pi*f*n);

% SQNR calculation for b = 1 to 10
b_values = 1:10;
SQNR_values = zeros(1, 10);

for i = 1:10
    b = b_values(i);
    Px = A^2/2;
    Pe = A^2/(3*2^(2*b));
    SQNR_values(i) = 10*log10(Px/Pe);
end

% Display table
fprintf('Bit used (b)\tSQNR (dB)\n');
fprintf('----------------------------\n');
for i = 1:10
    fprintf('%d\t\t%.2f\n', b_values(i), SQNR_values(i));
end

% Plot SQNR vs b
figure;
plot(b_values, SQNR_values, 'bo-', 'LineWidth', 2);
title('SQNR vs Number of Bits');
xlabel('Number of Bits (b)');
ylabel('SQNR (dB)');
grid on;

fprintf('\nComment: SQNR increases approximately 6 dB for each additional bit.\n');