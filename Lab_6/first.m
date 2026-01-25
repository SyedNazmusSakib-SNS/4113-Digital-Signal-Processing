clc; close all; clear all;

% --- Initialization ---
Fs = 1000;          % Sampling frequency
T = 1/Fs;           % Sampling period
F1 = 100;           % Frequency of component 1
F2 = 50;            % Frequency of component 2 (To be removed)
n = 0:1:Fs/2-1;     % Time vector (500 samples)

% --- Signal Generation ---
s1 = cos(2*pi*F1*n*T);        % 100 Hz signal
s2 = cos(2*pi*F2*n*T);        % [BLANK 1] 50 Hz signal
s = s1 + s2;                  % [BLANK 2] Combined signal

% --- Filter Design ---
% H(z) = 1 - 1.9021130326 z^-1 + z^-2
h = [1 -1.9021130326 1]; 

% --- Frequency Domain Setup ---
N = Fs/2;           % N = 500 points
df = 1/(N*T);       % This equals 1/(0.5) = 2 Hz resolution (Wait, Fs/N = 1000/500 = 2Hz)
df = Fs/N;          % Correct calculation for frequency resolution
f = (0:N-1)*df;     % Frequency vector

% --- FFT Calculations (Complex for processing, Abs for plotting) ---
S1_complex = fft(s1, N);
S2_complex = fft(s2, N);
S_complex  = fft(s, N);
H_complex  = fft(h, N); % FFT of the filter coefficients

% Calculate Magnitudes for Plotting (Filling the manual's variables)
FFTs1 = abs(S1_complex);    % Fourier transform of s1
FFTs2 = abs(S2_complex);    % [BLANK 3] Fourier transform of s2
FFTs  = abs(S_complex);     % [BLANK 4] Fourier transform of s
FFTh  = abs(H_complex);     % Fourier transform of h

% --- Filtering in Frequency Domain ---
% Multiply COMPLEX vectors to preserve phase info for reconstruction
Y_complex = S_complex .* H_complex; 

% Calculate Magnitude for plotting spectrum
FFTy = abs(Y_complex);      % [BLANK 5] Multiplication (Magnitude)

% --- Inverse FFT ---
% Use complex Y to get proper time domain signal, then take real part
y = real(ifft(Y_complex, N)); % [BLANK 6] Inverse Fourier transform

% ==========================================
%              PLOTTING SECTION
% ==========================================

% --- Figure 1: Time-Domain Signals ---
figure('Name', 'Time Domain Input');
subplot(3,1,1);
plot(n, s1);
title('Signal s1 (Frequency F1 = 100 Hz)');
xlabel('Sample (n)'); ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(n, s2);
title('Signal s2 (Frequency F2 = 50 Hz)');
xlabel('Sample (n)'); ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(n, s);
title('Combined Signal s (100 Hz + 50 Hz)');
xlabel('Sample (n)'); ylabel('Amplitude');
grid on;

% --- Figure 2: Frequency-Domain Input ---
figure('Name', 'Frequency Domain Input');
subplot(3,1,1);
stem(f, FFTs1, '-b');
title('Magnitude Spectrum of 100 Hz Signal');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on;

subplot(3,1,2);
stem(f, FFTs2, '-b');
title('Magnitude Spectrum of 50 Hz Signal');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on;

subplot(3,1,3);
stem(f, FFTs, '-b');
title('Magnitude Spectrum of Combined Signal');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on;

% --- Figure 3: Filter Response ---
figure('Name', 'Filter Frequency Response');
stem(f, FFTh, '-b');
title('Magnitude Spectrum of System H(z) (Null Filter)');
xlabel('Frequency (Hz)'); ylabel('|H(f)|');
grid on;

% --- Figure 4: Output Spectrum ---
figure('Name', 'Output Spectrum');
stem(f, FFTy, '-b');
title('Magnitude Spectrum of System Output');
xlabel('Frequency (Hz)'); ylabel('|Y(f)|');
grid on;

% --- Figure 5: Final Comparison ---
figure('Name', 'Input vs Output Comparison');
plot(n, s1, 'b', 'LineWidth', 1.5); hold on;
plot(n, y, 'r--', 'LineWidth', 1.5);
title('Comparison: Original 100Hz Signal vs Filtered Output');
xlabel('Sample (n)'); ylabel('Amplitude');
grid on;
legend('Original 100 Hz signal (s1)', 'Filtered Output (y)');