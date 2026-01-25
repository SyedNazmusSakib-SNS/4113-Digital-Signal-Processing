%% Exp-06 Advanced: Ablation and Sensitivity Analysis of Null Filter
clc; close all; clear;

% --- Base Parameters ---
Fs = 1000; T = 1/Fs;
n = 0:1:499;
f_axis = linspace(0, Fs/2, 1000); % High res frequency axis

% Input: 100Hz Signal + 50Hz Noise
s_clean = cos(2*pi*100*n*T);
s_noise = cos(2*pi*50*n*T);
s_total = s_clean + s_noise;

%% EXPERIMENT 1: The "Notch" Upgrade (FIR vs IIR)
% Problem: The manual's FIR filter attenuates the 100Hz signal too!
% Solution: Add a Pole close to the Zero to push the passband back up.

% Manual's Filter (FIR) - Zeros only
b_fir = [1 -2*cos(pi/10) 1];
a_fir = 1;

% Improved Notch Filter (IIR) - Zeros + Poles
% We place poles at the same angle, but radius r = 0.9
r = 0.9;
b_notch = [1 -2*cos(pi/10) 1];       % Zeros at unit circle
a_notch = [1 -2*r*cos(pi/10) r^2];   % Poles at r=0.9

% Calculate Frequency Responses
H_fir = freqz(b_fir, a_fir, f_axis, Fs);
H_notch = freqz(b_notch, a_notch, f_axis, Fs);

% Filter the signal using Time-Domain difference equation (filter function)
y_fir = filter(b_fir, a_fir, s_total);
y_notch = filter(b_notch, a_notch, s_total);

figure('Name', 'Exp 1: FIR vs Notch Performance');
subplot(2,1,1);
plot(f_axis, abs(H_fir), 'b--', 'LineWidth', 1.5); hold on;
plot(f_axis, abs(H_notch), 'r', 'LineWidth', 1.5);
xline(50, 'k:', 'Label', 'Noise (50Hz)');
xline(100, 'k:', 'Label', 'Signal (100Hz)');
legend('Original FIR (Manual)', 'Improved IIR Notch');
title('Magnitude Response Comparison');
ylabel('Gain'); grid on; xlim([0 200]);

subplot(2,1,2);
plot(n(1:100), s_clean(1:100), 'k', 'LineWidth', 2); hold on;
plot(n(1:100), y_fir(1:100), 'b--');
plot(n(1:100), y_notch(1:100), 'r-.', 'LineWidth', 1.5);
legend('Original Clean Signal', 'FIR Output (Amplitude Loss)', 'Notch Output (Correct Amp)');
title('Time Domain Restoration'); grid on;

%% EXPERIMENT 2: Sensitivity Analysis (Frequency Mismatch)
% What if the noise isn't exactly 50Hz? What if it drifts to 55Hz?

freq_drift = 40:0.5:60; % Test noise from 40Hz to 60Hz
attenuation_db = zeros(size(freq_drift));

for i = 1:length(freq_drift)
    f_test = freq_drift(i);
    % Evaluate the filter H(z) at this specific frequency
    z_test = exp(1j*2*pi*f_test/Fs);
    
    % H(z) calculation for the FIR filter
    H_val = abs((z_test^2 - 1.902*z_test + 1) / z_test^2);
    attenuation_db(i) = 20*log10(H_val + eps);
end

figure('Name', 'Exp 2: Sensitivity');
plot(freq_drift, attenuation_db, 'LineWidth', 2);
yline(-20, 'r--', 'Label', '20dB Attenuation');
title('Filter Sensitivity: How precise must the noise be?');
xlabel('Noise Frequency (Hz)'); ylabel('Attenuation (dB)');
grid on;

%% EXPERIMENT 3: 3D Visualization of the Notch (Pole-Zero Pair)
% Visualizing why the Notch filter is better (The "Volcano" Effect)

figure('Name', 'Exp 3: 3D Notch Surface');
[Re, Im] = meshgrid(-1.2:0.05:1.2, -1.2:0.05:1.2);
z = Re + 1j*Im;

% Calculate Magnitude of IIR Notch Filter on Z-plane
% H(z) = N(z) / D(z)
Num = 1 - 1.902*z.^(-1) + z.^(-2);
Den = 1 - 1.711*z.^(-1) + 0.81*z.^(-2); % Coefficients for r=0.9
H_surf = abs(Num ./ Den);
H_surf(H_surf > 10) = 10; % Cap height

surf(Re, Im, H_surf);
shading interp; colormap jet; hold on;

% Draw Unit Circle
theta = 0:0.01:2*pi;
plot3(cos(theta), sin(theta), ones(size(theta))*2, 'w', 'LineWidth', 3);

title('3D View of IIR Notch Filter');
xlabel('Real'); ylabel('Imag'); zlabel('|H(z)|');
view(-45, 60);