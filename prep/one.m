% Step 1: Define parameters
fs = 1000;           % Sampling rate (Hz)
T = 1/fs;            % Sampling period
t = 0:T:1- T;        % Time vector (1 second duration)
f = 50;              % Frequency of the sine wave (Hz)
x = sin(2 * pi * f * t); % Signal (sine wave)

% Step 2: Compute FFT
X = fft(x);

% Step 3: Compute frequency axis
N = length(x);       % Number of samples
frequencies = (0:N-1) * fs / N; % Frequency bins

% Step 4: Plot magnitude spectrum
figure;
plot(frequencies, abs(X));
title('Magnitude Spectrum of Sine Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Optional: Plot only the first half (for real signals)
figure;
plot(frequencies(1:N/2), abs(X(1:N/2)));
title('Magnitude Spectrum (First Half)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
