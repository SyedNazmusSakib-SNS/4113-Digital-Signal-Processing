% --- Step 4: Create the Final Noisy Signal ---

% Add the clean signal and the uniform noise
xn = x + n;

% --- Create Figure-1 for the Lab Report ---
figure; % Create a new window for our multi-plot figure

% Plot 1: The clean signal
subplot(3, 1, 1); % (3 rows, 1 column, 1st plot)
plot(t, x);
title('1. Clean Square Wave (x)');
ylabel('Amplitude');
grid on;
ylim([-2.5 2.5]); % Adjust y-axis to be consistent for all plots

% Plot 2: The noise
subplot(3, 1, 2); % (3 rows, 1 column, 2nd plot)
plot(t, n);
title('2. Uniform Random Noise (n)');
ylabel('Amplitude');
grid on;
ylim([-2.5 2.5]);

% Plot 3: The final noisy signal
subplot(3, 1, 3); % (3 rows, 1 column, 3rd plot)
plot(t, xn);
title('3. Noisy Signal (xn = x + n)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-2.5 2.5]);