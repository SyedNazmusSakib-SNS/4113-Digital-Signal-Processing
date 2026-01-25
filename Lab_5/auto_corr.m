% =========================================================================
% Lab-03 Part 2: Detailed 3x2 Cross-Correlation Plots for RADAR
%
% This script generates a series of detailed figures, one for each RADAR
% scenario. Each figure uses a 3x2 subplot layout to visualize the
% transmitted signal, the received noisy echo, and the cross-correlation
% used to find the time delay.
% =========================================================================

% --- 0. Initialization ---
clc; clear; close all;

% --- Create a directory to save the plots ---
outputDir = 'RADAR_Cross_Correlation_Plots';
if ~exist(outputDir, 'dir'), mkdir(outputDir); end

% --- 1. Generate the Transmitted RADAR Pulse (x1) ---
fprintf('Step 1: Generating the transmitted RADAR pulse...\n');

% Signal Parameters
duty = 50;
f = 10 * 10^9;       % 10 GHz frequency
ti = 1/f;            % Time period of one pulse cycle
s = ti/100;          % Sampling period

% Generate the transmitted signal x1, which lasts for 10 cycles
t1 = 0:s:10*ti;
n1 = 0:length(t1)-1; % Sample indices for x1
x1 = square(2*pi*f*t1, duty);

% =========================================================================
% --- 2. Loop Through All 4 Scenarios to Generate Plots ---
% =========================================================================
fprintf('Step 2: Generating a detailed 3x2 plot for each RADAR scenario...\n\n');

for case_num = 1:4
    
    % --- Define the parameters for the current scenario ---
    switch case_num
        case 1
            case_name = 'Ideal Case (No Noise)';
            delay_time = 20 * ti; % Delay is 20 cycles
            SNR = inf; % Infinite SNR means no noise
        case 2
            case_name = 'Realistic Case (Moderate Noise)';
            delay_time = 20 * ti;
            SNR = 5; % Signal-to-Noise Ratio of 5 dB
        case 3
            case_name = 'Difficult Case (Heavy Noise)';
            delay_time = 20 * ti;
            SNR = -5; % SNR of -5 dB (noise power > signal power)
        case 4
            case_name = 'Different Delay (Heavy Noise)';
            delay_time = 35 * ti; % A new delay of 35 cycles
            SNR = -5;
    end
    
    fprintf('Processing Case %d: %s\n', case_num, case_name);
    
    % --- Create the delayed, noisy "Received" signal (x2) ---
    n0 = round(delay_time / s); % Convert time delay to sample shift
    [x2, n2] = sigshift(x1, n1, n0); % Create the delayed signal
    t2 = n2 * s; % Time vector for the delayed signal
    
    % --- Align signals to a common time axis for operations ---
    % This is a crucial step from the lab manual
    min_n = min(min(n1), min(n2));
    max_n = max(max(n1), max(n2));
    n = min_n:max_n; % Common sample index vector
    t = n * s;       % Common time vector
    
    y1 = zeros(1, length(n)); % Zero-padded version of transmitted signal
    y2 = zeros(1, length(n)); % Zero-padded version of delayed signal
    
    y1(find((n >= min(n1)) & (n <= max(n1)))) = x1;
    y2(find((n >= min(n2)) & (n <= max(n2)))) = x2;
    
    % Add noise to the received signal using AWGN
    y2n = awgn(y2, SNR, 'measured');
    
    % --- Calculate Correlations ---
    [ACF_y1, lag_acf1] = xcorr(y1, 'coeff');
    [ACF_y2n, lag_acf2] = xcorr(y2n, 'coeff');
    [CCF, lag_ccf] = xcorr(y2n, y1, 'coeff'); % The KEY calculation
    
    % --- Find the peak of the Cross-Correlation to measure delay ---
    [~, max_idx] = max(CCF);
    measured_lag_samples = lag_ccf(max_idx);
    measured_delay_time = measured_lag_samples * s;
    
    % --- Create the Figure and the 3x2 Subplot Layout ---
    figure('Name', ['Case ' num2str(case_num) ': ' case_name], 'NumberTitle', 'off', 'Position', [50, 50, 1000, 800]);
    sgtitle(['RADAR Analysis for Case ' num2str(case_num) ': ' case_name], 'FontSize', 14, 'FontWeight', 'bold');
    
    % --- Top Row: Transmitted Signal ---
    subplot(3, 2, 1);
    plot(lag_acf1*s, ACF_y1, 'k');
    title('Auto-Correlation of Transmitted Signal');
    xlabel('Lag (s)'); ylabel('ACF'); grid on;

    subplot(3, 2, 2);
    plot(t, y1, 'k');
    title('Transmitted Signal (y1)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-3 3]);

    % --- Middle Row: Received Signal ---
    subplot(3, 2, 3);
    plot(lag_acf2*s, ACF_y2n, 'r');
    title('Auto-Correlation of Received Signal');
    xlabel('Lag (s)'); ylabel('ACF'); grid on;

    subplot(3, 2, 4);
    plot(t, y2n, 'r');
    title('Received Noisy Signal (y2n)');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-3 3]);

    % --- Bottom Row: The Result ---
    subplot(3, 2, 5);
    plot(lag_ccf*s, CCF, 'b', 'LineWidth', 1.5); hold on;
    plot(measured_delay_time, CCF(max_idx), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    title('Cross-Correlation (y2n vs y1)');
    xlabel('Lag (s)'); ylabel('CCF'); grid on;
    legend('CCF', sprintf('Peak Detected!\nDelay = %.2e s', measured_delay_time));

    subplot(3, 2, 6);
    plot(t, y1, 'k:'); hold on; % Transmitted in dotted black
    plot(t, y2n, 'r-'); % Received in solid red
    title('Transmitted vs. Received Signal');
    xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-3 3]);
    legend('y1 (Transmitted)', 'y2n (Received)');
    
    % --- Save the complete figure ---
    filename = sprintf('RADAR_Case_%d_%s.jpg', case_num, strrep(case_name, ' ', '_'));
    saveas(gcf, fullfile(outputDir, filename));
    
end

% --- 3. Finalization ---
fprintf('\nProcessing Complete!\n');
fprintf('All 4 detailed plots saved in folder: "%s"\n', outputDir);

% =========================================================================
% --- Local Function Definition (as required by lab manual) ---
% This function must be at the end of the script file.
% =========================================================================
function [y, n] = sigshift(x, m, n0)
    % Implements y(n) = x(n-n0)
    % -------------------------
    % [y,n] = sigshift(x,m,n0)
    % y = output sequence
    % n = time index for y
    % x = input sequence
    % m = time index for x
    % n0 = integer shift
    n = m + n0;
    y = x;
end