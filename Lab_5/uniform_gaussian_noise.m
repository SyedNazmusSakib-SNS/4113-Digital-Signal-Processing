% --- For Comparison: Create Gaussian Noise ---

% The '0.5' here controls the "power" or standard deviation of the noise.
% A larger number means louder, more extreme noise.
noise_power = 0.5;
n_gaussian = noise_power * randn(size(x));

% Let's visualize this different kind of noise
figure;
plot(t, n_gaussian);
title('Gaussian Random Noise (for comparison)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;