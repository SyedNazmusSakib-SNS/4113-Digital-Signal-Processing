% --- Case 4: Very High Noise (Amplitude: 2.0) ---

% Generate noise between -2.0 and +2.0
a4 = 0; b4 = -2.0;
n4 = (b4-a4) .* rand(size(x)) + a4;
xn4 = x + n4;

% Plotting
figure('Name', 'Case 4: Very High Noise');
subplot(2,1,1);
plot(t, n4, 'r');
title('Noise (n4) - Amplitude 2.0');
ylabel('Amplitude'); grid on; ylim([-4 4]);

subplot(2,1,2);
plot(t, xn4);
title('Noisy Signal (xn4) - The periodic signal is visually lost');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-4 4]);