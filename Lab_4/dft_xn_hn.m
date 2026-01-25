% Step 4: Calculate DFT and plot magnitude and phase
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
L = Lx + Lh - 1;  % Length of output (26 samples)

% Perform convolution in time-domain
yc = conv(xn, hn);

% Create index for output
k = 0:1:L-1;

%% PART 2: FREQUENCY DOMAIN ANALYSIS (DFT)

% Calculate L-point DFT of input signal and impulse response
X = fft(xn, L);  % L-point DFT of x
H = fft(hn, L);  % L-point DFT of h

% Calculate magnitude and phase
mX = abs(X);      % Magnitude of X
pX = angle(X);    % Phase of X

mH = abs(H);      % Magnitude of H
pH = angle(H);    % Phase of H

% Plot magnitude and phase of X and H
figure;

% Magnitude of X
subplot(2, 2, 1);
stem(k, mX, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
xlabel('Index, k');
ylabel('Magnitude, |X(k)|');
title('Magnitude Spectrum of X');
grid on;

% Phase of X
subplot(2, 2, 2);
stem(k, pX, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
xlabel('Index, k');
ylabel('Phase, ∠X(k) (radians)');
title('Phase Spectrum of X');
grid on;

% Magnitude of H
subplot(2, 2, 3);
stem(k, mH, 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
xlabel('Index, k');
ylabel('Magnitude, |H(k)|');
title('Magnitude Spectrum of H');
grid on;

% Phase of H
subplot(2, 2, 4);
stem(k, pH, 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
xlabel('Index, k');
ylabel('Phase, ∠H(k) (radians)');
title('Phase Spectrum of H');
grid on;

% Display information
fprintf('===== PART 2: FREQUENCY DOMAIN (DFT) =====\n');
fprintf('DFT Length (L): %d points\n', L);
fprintf('Number of frequency bins: %d\n', L);
fprintf('\nMagnitude of X at k=0 (DC component): %.4f\n', mX(1));
fprintf('Magnitude of H at k=0 (DC component): %.4f\n', mH(1));
fprintf('\nMax magnitude of X: %.4f\n', max(mX));
fprintf('Max magnitude of H: %.4f\n', max(mH));