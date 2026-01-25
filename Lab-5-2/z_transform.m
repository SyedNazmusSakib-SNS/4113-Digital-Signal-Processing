%% Lab-05: Analysis of difference equation in z-domain

clc;
clear;
close all;

% --- Part-1: Setup and Transfer Function ---

% Define Sampling Frequency and Time
Fs = 10 * 10^3; % 10 kHz
T = 1/Fs;

% Define Coefficients based on difference equation:
% y[n] - 1.2y[n-1] + 0.75y[n-2] = x[n] + 2x[n-1] + x[n-2]
% The manual defines 'a' as 'x' coefficients (Numerator)
% The manual defines 'b' as 'y' coefficients (Denominator)
a = [1 2 1];       % Numerator
b = [1 -1.2 0.75]; % Denominator

% 1(a) Transfer Function H(z)
% Note: The syntax tf(num, den, T) usually expects tf(numerator, denominator, T).
% Based on the manual's assignment of 'a' and 'b', 'a' is num and 'b' is den.
H = tf(a, b, T, 'Variable', 'z^-1');
disp('1(a) Transfer Function H(z):');
disp(H);

% 1(b) Determination of poles and zeroes
[zero_loc, pole_loc] = tf2zp(a, b);
disp('1(b) Zeros of the system:');
disp(zero_loc);
disp('1(b) Poles of the system:');
disp(pole_loc);

% 1(c) Pole-zero diagram
figure(1);
zplane(a, b);
grid on;
title('Pole-Zero Diagram');

% --- Part-2: Frequency Response ---

% Define number of DFT points
N = 512;

% Calculate Frequency Response
Hz = freqz(a, b, N, 'whole');

% Calculate Magnitude and Phase
Mz = abs(Hz);
Pz = angle(Hz);

% Create Frequency Vector (0 to Fs)
f = 0 : Fs/(N-1) : Fs;

% 2(a) Plot Frequency Response
figure(2);

% Magnitude Plot
subplot(2,1,1);
plot(f, Mz, 'LineWidth', 1.5);
title('Magnitude response of the system');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');
grid on;

% Phase Plot
subplot(2,1,2);
plot(f, Pz, 'LineWidth', 1.5);
title('Phase response of the system');
xlabel('Frequency (Hz)');
ylabel('\angle H(f) (radians)');
grid on;

% 2(b) Analyze Max Magnitude and Bandwidth
% We are interested in the range 0 to Fs/2 for analysis
f_half = f(1:floor(N/2));
Mz_half = Mz(1:floor(N/2));

% Find Maximum Magnitude
[max_mag, max_idx] = max(Mz_half);
freq_at_max = f_half(max_idx);

% Calculate 3dB Cutoff Magnitude
cutoff_3dB = max_mag / sqrt(2);

% Find indices where magnitude is above the 3dB cutoff
% This helps identify the bandwidth
above_cutoff_indices = find(Mz_half >= cutoff_3dB);
freq_low_cutoff = f_half(above_cutoff_indices(1));
freq_high_cutoff = f_half(above_cutoff_indices(end));
bandwidth = freq_high_cutoff - freq_low_cutoff;

% Display Results for Part 2
fprintf('\n--- Part 2 Analysis ---\n');
fprintf('Maximum Magnitude: %.4f\n', max_mag);
fprintf('Frequency at Max Magnitude: %.2f Hz\n', freq_at_max);
fprintf('3dB Cutoff Level: %.4f\n', cutoff_3dB);
fprintf('Lower Cutoff Frequency: %.2f Hz\n', freq_low_cutoff);
fprintf('Upper Cutoff Frequency: %.2f Hz\n', freq_high_cutoff);
fprintf('Bandwidth: %.2f Hz\n', bandwidth);

% Highlight these on the plot (Zoomed in view similar to Lab Manual Page 2)
figure(3);
plot(f, Mz, 'LineWidth', 1.5);
xlim([0 Fs/2]); % Limit to Nyquist as requested
ylim([0 20]);
hold on;
yline(cutoff_3dB, 'r--', 'Label', ['3dB = ' num2str(cutoff_3dB, '%.2f')]);
xline(freq_at_max, 'g--', 'Label', ['Center = ' num2str(freq_at_max, '%.0f') 'Hz']);
title('Magnitude Response with Bandwidth Analysis');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');
grid on;