% --- Step 3: Create Uniform Random Noise ---

% Define the noise range
a = 1;  % Maximum value of noise
b = -1; % Minimum value of noise

% Generate the noise signal
% We use rand(size(x)) to make sure 'n' is the same size as 'x'
n = (b-a) .* rand(size(x)) + a;

% Let's visualize the noise by itself
figure;
plot(t, n);
title('Uniform Random Noise (n)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-1.5 1.5]); % Set limits to see the bounds clearly