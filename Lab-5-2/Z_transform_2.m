%% Lab-05 In-Depth: Sensitivity Analysis and Variations
clc; clear; close all;

% --- Base Parameters ---
Fs = 10e3;              % 10 kHz
N = 1024;               % Higher resolution for smooth plots
f = linspace(0, Fs, N); % Frequency vector 0 to Fs

% The Original Zeros are fixed at z = -1 (High freq suppression)
% This corresponds to numerator coefficients a = [1 2 1]
zeros_sys = [-1; -1];
a = poly(zeros_sys); 

%% EXPERIMENT 1: The Effect of Pole Radius (r)
% Hypothesis: As poles get closer to the Unit Circle (r -> 1), 
% the filter becomes SHARPER (narrower bandwidth, higher gain).
% As r -> 0, the filter becomes flatter.

figure('Name', 'Exp 1: Varying Pole Radius', 'Color', 'w');
radii = [0.5, 0.75, 0.9, 0.98]; % Increasing sharpness
theta = 46 * (pi/180);          % Keep angle fixed (~1270 Hz)

colors = lines(length(radii));
hold on;

for i = 1:length(radii)
    r = radii(i);
    
    % Create conjugate poles from polar coordinates
    p1 = r * exp(1j * theta);
    p2 = r * exp(-1j * theta);
    poles_sys = [p1; p2];
    
    % Convert poles to denominator coefficients 'b'
    b = poly(poles_sys);
    
    % Calculate response
    [H, ~] = freqz(a, b, N, 'whole');
    mag = abs(H);
    
    % Normalize magnitude to 1 (0dB) for easier shape comparison
    % (Optional, but helps compare "sharpness" rather than raw gain)
    mag = mag / max(mag); 
    
    plot(f, mag, 'LineWidth', 2, 'Color', colors(i,:), ...
        'DisplayName', sprintf('r = %.2f', r));
end

title('Experiment 1: Effect of Pole Radius (r) on Bandwidth');
xlabel('Frequency (Hz)'); ylabel('Normalized Magnitude');
legend('show'); grid on; xlim([0 Fs/2]);
text(1500, 0.5, '\leftarrow Closer to 1 = Sharper Peak', 'FontSize', 12);

%% EXPERIMENT 2: The Effect of Pole Angle (theta)
% Hypothesis: The angle of the pole determines the Center Frequency.
% Theta = 0 is DC, Theta = pi is Fs/2.

figure('Name', 'Exp 2: Varying Pole Angle', 'Color', 'w');
angles_deg = [20, 45, 70, 90]; % Degrees
r = 0.9;                       % Keep radius constant (sharpness constant)

hold on;
colors = parula(length(angles_deg)+1);

for i = 1:length(angles_deg)
    deg = angles_deg(i);
    theta_rad = deg * (pi/180);
    
    % Calculate expected center frequency
    expected_freq = (deg / 360) * Fs;
    
    % Create poles
    poles_sys = [r * exp(1j * theta_rad); r * exp(-1j * theta_rad)];
    b = poly(poles_sys);
    
    % Calculate response
    [H, ~] = freqz(a, b, N, 'whole');
    
    plot(f, abs(H), 'LineWidth', 2, 'Color', colors(i,:), ...
        'DisplayName', sprintf('\\theta = %d^o (f_c \\approx %.0f Hz)', deg, expected_freq));
end

title('Experiment 2: Effect of Pole Angle on Center Frequency');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
legend('Location', 'NorthEast'); grid on; xlim([0 Fs/2]);

%% EXPERIMENT 3: The 3D "Rubber Sheet" Visualization
% This creates the surface plot of the Z-plane.
% X and Y are Real and Imaginary axes. Z-height is Magnitude.

figure('Name', 'Exp 3: 3D Z-Domain Surface', 'Color', 'w');

% Create a grid of z values (Real vs Imaginary)
grid_range = -1.5:0.05:1.5;
[Re, Im] = meshgrid(grid_range, grid_range);
z = Re + 1j*Im;

% Define the specific filter from your Lab (Part 1)
% y[n] - 1.2y[n-1] + 0.75y[n-2] ...
b_lab = [1 -1.2 0.75];
a_lab = [1 2 1];

% Evaluate H(z) on the whole grid
% H(z) = N(z) / D(z)
% We evaluate polynomial manually on the grid
Num = a_lab(1) + a_lab(2)*z.^(-1) + a_lab(3)*z.^(-2);
Den = b_lab(1) + b_lab(2)*z.^(-1) + b_lab(3)*z.^(-2);
H_surface = abs(Num ./ Den);

% Cap the height for visualization (poles go to infinity)
H_surface(H_surface > 15) = 15; 

% Plot Surface
surf(Re, Im, H_surface, 'EdgeColor', 'none');
colormap jet; 
hold on;

% Draw the Unit Circle (This is where Frequency Response lives!)
theta_circ = 0:0.01:2*pi;
unit_circ_x = cos(theta_circ);
unit_circ_y = sin(theta_circ);
z_circ = unit_circ_x + 1j*unit_circ_y;

% Calculate height along the unit circle (Frequency Response)
Num_circ = a_lab(1) + a_lab(2)*z_circ.^(-1) + a_lab(3)*z_circ.^(-2);
Den_circ = b_lab(1) + b_lab(2)*z_circ.^(-1) + b_lab(3)*z_circ.^(-2);
H_circ = abs(Num_circ ./ Den_circ);

% Plot the "Frequency Response Wall" on the unit circle
plot3(unit_circ_x, unit_circ_y, H_circ+0.1, 'w', 'LineWidth', 3);
plot3(unit_circ_x, unit_circ_y, zeros(size(unit_circ_x)), 'k--', 'LineWidth', 1);

title('3D View: Poles (Peaks), Zeros (Valleys), and Unit Circle');
xlabel('Real Part'); ylabel('Imaginary Part'); zlabel('|H(z)|');
view(-30, 45); % Set camera angle
shading interp; camlight; lighting gouraud;

disp('Analysis Complete. Check Figures 1, 2, and 3.');