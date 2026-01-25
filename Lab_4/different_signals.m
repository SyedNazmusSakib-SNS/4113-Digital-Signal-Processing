% DSP Lab: Testing LTI System Response with Different Input Signals
% Testing 5 different types of input signals
clear all;
close all;
clc;

%% Define the impulse response (SAME for all tests)
n = 0:1:10;  % n goes from 0 to 10 (11 samples)
hn = (1.4).^n;  % Impulse response: h[n] = (1.4)^n

% We'll test with 5 different input signals
m = 0:1:15;  % Index for all input signals (16 samples)

%% ===== SIGNAL 1: EXPONENTIAL DECAY (Original) =====
x1 = (0.8).^m;
signal_name1 = 'Exponential Decay: (0.8)^m';

%% ===== SIGNAL 2: RAMP (Linear Increase) =====
x2 = m;  % Ramp: 0, 1, 2, 3, 4, ...
signal_name2 = 'Ramp: x[m] = m';

%% ===== SIGNAL 3: UNIT STEP =====
x3 = ones(1, length(m));  % All ones: 1, 1, 1, 1, ...
signal_name3 = 'Unit Step: x[m] = 1';

%% ===== SIGNAL 4: IMPULSE (Delta Function) =====
x4 = zeros(1, length(m));
x4(1) = 1;  % Only first sample is 1, rest are 0
signal_name4 = 'Unit Impulse: δ[m]';

%% ===== SIGNAL 5: SINUSOIDAL =====
x5 = sin(2*pi*0.1*m);  % Sine wave with frequency 0.1
signal_name5 = 'Sinusoidal: sin(2π·0.1·m)';

%% Store all signals in a cell array for easy processing
signals = {x1, x2, x3, x4, x5};
signal_names = {signal_name1, signal_name2, signal_name3, signal_name4, signal_name5};

%% Process each signal
for sig_idx = 1:5
    fprintf('\n========================================\n');
    fprintf('TESTING SIGNAL %d: %s\n', sig_idx, signal_names{sig_idx});
    fprintf('========================================\n');
    
    % Get current signal
    xn = signals{sig_idx};
    
    % Calculate lengths
    Lx = length(xn);
    Lh = length(hn);
    L = Lx + Lh - 1;
    k = 0:1:L-1;
    
    % TIME DOMAIN: Convolution
    yc = conv(xn, hn);
    
    % FREQUENCY DOMAIN: DFT → Multiply → IDFT
    X = fft(xn, L);
    H = fft(hn, L);
    Y = X .* H;
    yf = ifft(Y, L);
    
    % Verify they match
    difference = max(abs(yc - yf));
    fprintf('Max difference between time & freq domain: %.2e\n', difference);
    
    %% Create comprehensive plot for this signal
    figure('Name', sprintf('Signal %d: %s', sig_idx, signal_names{sig_idx}), ...
           'Position', [100, 100, 1400, 800]);
    
    % Row 1: Time Domain Signals
    subplot(3, 3, 1);
    stem(m, xn, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    xlabel('Index, m');
    ylabel('x[m]');
    title(['Input: ' signal_names{sig_idx}]);
    grid on;
    
    subplot(3, 3, 2);
    stem(n, hn, 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
    xlabel('Index, n');
    ylabel('h[n]');
    title('Impulse Response: (1.4)^n');
    grid on;
    
    subplot(3, 3, 3);
    stem(k, yc, 'g', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
    xlabel('Index, k');
    ylabel('y[k]');
    title('Output: y = x * h');
    grid on;
    
    % Row 2: Magnitude Spectra
    subplot(3, 3, 4);
    stem(k, abs(X), 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    xlabel('Index, k');
    ylabel('|X(k)|');
    title('Magnitude of X(k)');
    grid on;
    
    subplot(3, 3, 5);
    stem(k, abs(H), 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
    xlabel('Index, k');
    ylabel('|H(k)|');
    title('Magnitude of H(k)');
    grid on;
    
    subplot(3, 3, 6);
    stem(k, abs(Y), 'g', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
    xlabel('Index, k');
    ylabel('|Y(k)|');
    title('Magnitude of Y(k) = X·H');
    grid on;
    
    % Row 3: Phase Spectra
    subplot(3, 3, 7);
    stem(k, angle(X), 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    xlabel('Index, k');
    ylabel('∠X(k)');
    title('Phase of X(k)');
    grid on;
    
    subplot(3, 3, 8);
    stem(k, angle(H), 'r', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
    xlabel('Index, k');
    ylabel('∠H(k)');
    title('Phase of H(k)');
    grid on;
    
    subplot(3, 3, 9);
    stem(k, angle(Y), 'g', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
    xlabel('Index, k');
    ylabel('∠Y(k)');
    title('Phase of Y(k)');
    grid on;
    
    % Print statistics
    fprintf('Input signal range: [%.4f, %.4f]\n', min(xn), max(xn));
    fprintf('Output signal range: [%.4f, %.4f]\n', min(yc), max(yc));
    fprintf('Output mean: %.4f\n', mean(yc));
end

%% Create comparison plot of all outputs
figure('Name', 'Comparison of All Outputs', 'Position', [100, 100, 1200, 800]);

for sig_idx = 1:5
    xn = signals{sig_idx};
    Lx = length(xn);
    Lh = length(hn);
    L = Lx + Lh - 1;
    k = 0:1:L-1;
    yc = conv(xn, hn);
    
    subplot(2, 3, sig_idx);
    stem(k, yc, 'LineWidth', 1.5, 'MarkerFaceColor', 'auto');
    xlabel('Index, k');
    ylabel('Output y[k]');
    title(signal_names{sig_idx});
    grid on;
end

fprintf('\n========================================\n');
fprintf('ALL TESTS COMPLETED!\n');
fprintf('========================================\n');
fprintf('\nKey Observations:\n');
fprintf('1. IMPULSE: Output = Impulse Response (system characteristic)\n');
fprintf('2. STEP: Output = Running sum of impulse response\n');
fprintf('3. RAMP: Output grows due to accumulation\n');
fprintf('4. EXPONENTIAL: Output shows interaction of decay vs growth\n');
fprintf('5. SINUSOIDAL: Output is also sinusoidal (freq preserved)\n');