% Parameters
duty = 50; % Duty cycle
f = 4e9;   % Frequency (Hz)
ti = 1/f;  % Time period (s)
s = ti/100; % Sampling period (s)
t = 0:s:8*ti; % Time range (s)
x = square(2*pi*f*t, duty); % Square wave
