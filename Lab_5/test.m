% Define the parameters for the square wave
duty = 50;        % On-OFF time ratio of the square wave (50%)
f = 4*10.^9;      % Frequency of the rectangular pulse (4 GHz)
ti = 1/f;         % Time period of one cycle
s = ti/100;       % Sampling period (100 samples per cycle)
t = 0:s:8*ti;     % Time vector, from 0 to 8 periods

% Generate the square wave
x = square(2*pi*f*t, duty);

% Let's visualize it to see what we made
figure; % Creates a new figure window
plot(t, x);
title('Clean Square Wave (x)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-1.5 1.5]); % Adjust y-axis to see the square shape clearly