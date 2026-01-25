% Complete DSP Lab: LTI System Response - Time and Frequency Domain
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

% Create index for output
k = 0:1:L-1;

%% ===== PART 1: TIME-DOMAIN CONVOLUTION =====

% Perform convolution in time-domain
yc = conv(xn, hn);

% Plot all three signals (Figure 1)
figure('Name', 'Figure 1: Time Domain Signals');

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

fprintf('===== PART 1: TIME-DOMAIN CONVOLUTION =====\n');
fprintf('Length of input x[m]: %d\n', Lx);
fprintf('Length of impulse response h[n]: %d\n', Lh);
fprintf('Length of output yc[k]: %d (= %d + %d - 1)\n', L, Lx, Lh);

%% ===== PART 2: FREQUENCY DOMAIN ANALYSIS (DFT) =====

% Calculate L-point DFT of input signal and impulse response
X = fft(xn, L);  % L-point DFT of x
H = fft(hn, L);  % L-point DFT of h

% Calculate magnitude and phase
mX = abs(X);      % Magnitude of X
pX = angle(X);    % Phase of X

mH = abs(H);      % Magnitude of H
pH = angle(H);    % Phase of H

% Plot magnitude and phase of X and H (Figure 2)
figure('Name', 'Figure 2: Frequency Domain - DFT of X and H');

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

fprintf('\n===== PART 2: FREQUENCY DOMAIN (DFT) =====\n');
fprintf('DFT Length (L): %d points\n', L);

%% ===== PART 3: VERIFY CONVOLUTION THEOREM =====

% Multiply in frequency domain
Y = X .* H;  % Element-wise multiplication

% Convert back to time-domain using inverse DFT
yf = ifft(Y, L);

% Plot comparison (Figure 3)
figure('Name', 'Figure 3: Verification of Convolution Theorem');

% Plot yc (from convolution)
subplot(1, 2, 1);
stem(k, yc, 'g', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
xlabel('Index, k');
ylabel('Output yc(k)');
title('Time Domain: yc = conv(x, h)');
grid on;

% Plot yf (from frequency domain multiplication)
subplot(1, 2, 2);
stem(k, yf, 'm', 'LineWidth', 1.5, 'MarkerFaceColor', 'm');
xlabel('Index, k');
ylabel('Output yf(k)');
title('Frequency Domain: yf = ifft(X .* H)');
grid on;

fprintf('\n===== PART 3: VERIFICATION OF CONVOLUTION THEOREM =====\n');
fprintf('Convolution Theorem: x[n]*h[n] <=> X(k)·H(k)\n\n');

% Check if they are equal
difference = abs(yc - yf);
max_difference = max(difference);

fprintf('Maximum difference between yc and yf: %.10e\n', max_difference);

if max_difference < 1e-10
    fprintf('✓ SUCCESS! yc and yf are IDENTICAL (within numerical precision)\n');
    fprintf('✓ Convolution Theorem VERIFIED!\n');
else
    fprintf('⚠ WARNING: Difference detected!\n');
end

fprintf('\nFirst 5 values comparison:\n');
fprintf('  k  |   yc(k)   |   yf(k)   | Difference\n');
fprintf('-----|-----------|-----------|------------\n');
for i = 1:5
    fprintf('  %2d | %9.4f | %9.4f | %.2e\n', i-1, yc(i), yf(i), difference(i));
end