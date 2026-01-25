% =========================================================================
% Lab-03 Simulation: Triangular Wave with Various Noise Types
% 
% This script demonstrates the effect of different types and amplitudes of
% noise on a clean triangular wave signal.
%
% It will:
% 1. Generate a clean triangular wave.
% 2. Create 7 different noisy versions of the signal.
% 3. Plot each case in a separate figure window.
% 4. Save all generated plots as JPG files in a new subfolder.
% =========================================================================

% --- 0. Initialization ---
clc;            % Clear the command window
clear;          % Clear all variables from the workspace
close all;      % Close all existing figure windows

% --- Create a directory to save the plots ---
outputDir = 'Triangular_Wave_Plots';
if ~exist(outputDir, 'dir') % Check if the folder doesn't already exist
    mkdir(outputDir);       % Create the folder
end

% --- 1. Generate the Clean Triangular Wave ---
fprintf('Step 1: Generating the clean triangular wave...\n');

f = 4*10^9;      % Frequency (using the same as the lab for consistency)
ti = 1/f;         % Time period
s = ti/100;       % Sampling period
t = 0:s:8*ti;     % Time vector for 8 periods

% Generate the clean triangular wave using the sawtooth function
% A width of 0.5 creates a symmetrical triangular wave.
x_tri = sawtooth(2*pi*f*t, 0.5);

% --- Plot and save the original clean signal ---
figure('Name', 'Clean Triangular Wave', 'NumberTitle', 'off');
plot(t, x_tri, 'k', 'LineWidth', 1.5);
title('Original Clean Signal (Triangular Wave)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-4 4]); % Set a consistent Y-axis limit for all plots for easy comparison
saveas(gcf, fullfile(outputDir, 'Triangular_0_Clean_Signal.jpg'));

% =========================================================================
% --- 2. Generate and Plot Noisy Signals ---
% =========================================================================

% --- Case 1: Very Low Uniform Noise [-0.1, 0.1] ---
fprintf('Step 2.1: Processing Case 1 - Very Low Noise...\n');
a1 = 0.1; b1 = -0.1;
n1 = (b1-a1) .* rand(size(x_tri)) + a1;
xn1 = x_tri + n1;
figure('Name', 'Case 1: Very Low Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n1, 'r');
title('Noise (n1): Uniform [-0.1, 0.1]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn1);
title('Noisy Signal (xn1): Triangular wave is clearly visible');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_1_Low_Uniform_Noise.jpg'));

% --- Case 2: Moderate Uniform Noise [-0.5, 0.5] ---
fprintf('Step 2.2: Processing Case 2 - Moderate Noise...\n');
a2 = 0.5; b2 = -0.5;
n2 = (b2-a2) .* rand(size(x_tri)) + a2;
xn2 = x_tri + n2;
figure('Name', 'Case 2: Moderate Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n2, 'r');
title('Noise (n2): Uniform [-0.5, 0.5]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn2);
title('Noisy Signal (xn2): Shape is distorted but recognizable');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_2_Moderate_Uniform_Noise.jpg'));

% --- Case 3: High Uniform Noise (Signal = Noise) [-1, 1] ---
fprintf('Step 2.3: Processing Case 3 - High Noise...\n');
a3 = 1.0; b3 = -1.0;
n3 = (b3-a3) .* rand(size(x_tri)) + a3;
xn3 = x_tri + n3;
figure('Name', 'Case 3: High Noise (Signal = Noise)', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n3, 'r');
title('Noise (n3): Uniform [-1, 1]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn3);
title('Noisy Signal (xn3): Difficult to see the underlying pattern');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_3_High_Uniform_Noise.jpg'));

% --- Case 4: Very High Uniform Noise (Noise > Signal) [-2, 2] ---
fprintf('Step 2.4: Processing Case 4 - Very High Noise...\n');
a4 = 2.0; b4 = -2.0;
n4 = (b4-a4) .* rand(size(x_tri)) + a4;
xn4 = x_tri + n4;
figure('Name', 'Case 4: Very High Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n4, 'r');
title('Noise (n4): Uniform [-2, 2]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn4);
title('Noisy Signal (xn4): The periodic signal is visually lost');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_4_Very_High_Uniform_Noise.jpg'));

% --- Case 5: High Gaussian Noise ---
fprintf('Step 2.5: Processing Case 5 - High Gaussian Noise...\n');
n5 = 1.0 * randn(size(x_tri)); % Gaussian noise with standard deviation 1.0
xn5 = x_tri + n5;
figure('Name', 'Case 5: High Gaussian Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n5, 'r');
title('Noise (n5): Gaussian (Std Dev = 1.0)');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn5);
title('Noisy Signal (xn5): Pattern is lost, with larger spikes');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_5_High_Gaussian_Noise.jpg'));

% --- Case 6: Positive-Only Uniform Noise [0, 1] ---
fprintf('Step 2.6: Processing Case 6 - Positive-Only Noise...\n');
a6 = 1.0; b6 = 0;
n6 = (b6-a6) .* rand(size(x_tri)) + a6;
xn6 = x_tri + n6;
figure('Name', 'Case 6: Positive-Only Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n6, 'r');
title('Noise (n6): Uniform [0, 1]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn6);
title('Noisy Signal (xn6): Entire signal is shifted upwards');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_6_Positive_Uniform_Noise.jpg'));

% --- Case 7: Negative-Only Uniform Noise [-1, 0] ---
fprintf('Step 2.7: Processing Case 7 - Negative-Only Noise...\n');
a7 = 0; b7 = -1.0;
n7 = (b7-a7) .* rand(size(x_tri)) + a7;
xn7 = x_tri + n7;
figure('Name', 'Case 7: Negative-Only Noise', 'NumberTitle', 'off');
subplot(2,1,1);
plot(t, n7, 'r');
title('Noise (n7): Uniform [-1, 0]');
ylabel('Amplitude'); grid on; ylim([-4 4]);
subplot(2,1,2);
plot(t, xn7);
title('Noisy Signal (xn7): Entire signal is shifted downwards');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);
saveas(gcf, fullfile(outputDir, 'Triangular_7_Negative_Uniform_Noise.jpg'));

% --- 3. Finalization ---
fprintf('\nProcessing Complete!\n');
fprintf('All 8 plots have been saved as JPG files in the folder: "%s"\n', outputDir);