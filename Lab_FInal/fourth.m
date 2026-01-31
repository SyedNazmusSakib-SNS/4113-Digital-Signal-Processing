clear all;
close all;
clc;

fprintf('========== TWEAKING EXAMPLES ==========\n\n');

%% TWEAK 1: Change FFT Length
fprintf('TWEAK 1: Different FFT Lengths\n');
fprintf('----------------------------------\n');

m = 0:15;
x = (0.8).^m;
n = 0:10;
h = (1.4).^n;

yc = conv(x, h);
L_correct = 26;

fprintf('Testing different FFT lengths:\n\n');

X_16 = fft(x, 16);
H_16 = fft(h, 16);
Y_16 = X_16 .* H_16;
yf_16 = ifft(Y_16, 16);
diff_16 = max(abs(yc(1:16) - real(yf_16)));
fprintf('L = 16 (WRONG - circular convolution):\n');
fprintf('  Difference from conv: %.6f\n', diff_16);
fprintf('  Result: INCORRECT (aliases/wraps around)\n\n');

X_26 = fft(x, 26);
H_26 = fft(h, 26);
Y_26 = X_26 .* H_26;
yf_26 = ifft(Y_26, 26);
diff_26 = max(abs(yc - real(yf_26)));
fprintf('L = 26 (CORRECT - minimum length):\n');
fprintf('  Difference from conv: %.15e\n', diff_26);
fprintf('  Result: CORRECT (essentially zero difference)\n\n');

X_50 = fft(x, 50);
H_50 = fft(h, 50);
Y_50 = X_50 .* H_50;
yf_50 = ifft(Y_50, 50);
diff_50 = max(abs([yc, zeros(1,24)] - real(yf_50)));
fprintf('L = 50 (OVER-SPECIFIED - zero padded):\n');
fprintf('  Difference from conv: %.15e\n', diff_50);
fprintf('  Result: CORRECT (just more zeros at end)\n\n');

figure;
subplot(1,3,1);
stem(0:15, real(yf_16));
title('FFT Length = 16 (WRONG)');
xlabel('k'); ylabel('y[k]');

subplot(1,3,2);
stem(0:25, real(yf_26));
title('FFT Length = 26 (CORRECT)');
xlabel('k'); ylabel('y[k]');

subplot(1,3,3);
stem(0:49, real(yf_50));
title('FFT Length = 50 (PADDED)');
xlabel('k'); ylabel('y[k]');

%% TWEAK 2: Change Impulse Response (Stable vs Unstable)
fprintf('\nTWEAK 2: Stable vs Unstable Systems\n');
fprintf('-------------------------------------\n');

h_unstable = (1.4).^n;
h_stable = (0.5).^n;

sum_unstable = sum(h_unstable);
sum_stable = sum(h_stable);

fprintf('Unstable: h[n] = (1.4)^n\n');
fprintf('  Sum of h[n]: %.4f\n', sum_unstable);
fprintf('  Converges? NO (would go to infinity)\n');
fprintf('  System stable? NO\n\n');

fprintf('Stable: h[n] = (0.5)^n\n');
fprintf('  Sum of h[n]: %.4f\n', sum_stable);
fprintf('  Theoretical sum (geometric series): 1/(1-0.5) = 2.0\n');
fprintf('  Converges? YES\n');
fprintf('  System stable? YES\n\n');

yc_unstable = conv(x, h_unstable);
yc_stable = conv(x, h_stable);

figure;
subplot(2,2,1);
stem(n, h_unstable);
title('Unstable: h[n] = (1.4)^n');
xlabel('n'); ylabel('h[n]');

subplot(2,2,2);
stem(0:L_correct-1, yc_unstable);
title('Output with Unstable System');
xlabel('k'); ylabel('y[k]');

subplot(2,2,3);
stem(n, h_stable);
title('Stable: h[n] = (0.5)^n');
xlabel('n'); ylabel('h[n]');

subplot(2,2,4);
stem(0:L_correct-1, yc_stable);
title('Output with Stable System');
xlabel('k'); ylabel('y[k]');

%% TWEAK 3: Different Input Signals
fprintf('\nTWEAK 3: Different Input Signals\n');
fprintf('----------------------------------\n');

x_impulse = [1, zeros(1, 15)];
x_step = ones(1, 16);
x_ramp = 0:15;
x_sine = sin(2*pi*0.1*m);

yc_impulse = conv(x_impulse, h_unstable);
yc_step = conv(x_step, h_unstable);
yc_ramp = conv(x_ramp, h_unstable);
yc_sine = conv(x_sine, h_unstable);

fprintf('Input: Impulse δ[n]\n');
fprintf('  Output equals: h[n] exactly!\n');
fprintf('  Max output: %.4f, Max h[n]: %.4f\n\n', max(yc_impulse), max(h_unstable));

fprintf('Input: Unit Step u[n]\n');
fprintf('  Output is running sum of h[n]\n');
fprintf('  Max output: %.4f\n\n', max(yc_step));

fprintf('Input: Ramp n\n');
fprintf('  Output grows rapidly\n');
fprintf('  Max output: %.4f\n\n', max(yc_ramp));

fprintf('Input: Sine wave\n');
fprintf('  Output is also sinusoidal\n');
fprintf('  Max output: %.4f\n\n', max(yc_sine));

figure;
subplot(2,4,1);
stem(m, x_impulse);
title('Input: Impulse');
xlabel('m'); ylabel('x[m]');

subplot(2,4,5);
stem(0:L_correct-1, yc_impulse);
title('Output');
xlabel('k'); ylabel('y[k]');

subplot(2,4,2);
stem(m, x_step);
title('Input: Step');
xlabel('m'); ylabel('x[m]');

subplot(2,4,6);
stem(0:L_correct-1, yc_step);
title('Output');
xlabel('k'); ylabel('y[k]');

subplot(2,4,3);
stem(m, x_ramp);
title('Input: Ramp');
xlabel('m'); ylabel('x[m]');

subplot(2,4,7);
stem(0:L_correct-1, yc_ramp);
title('Output');
xlabel('k'); ylabel('y[k]');

subplot(2,4,4);
stem(m, x_sine);
title('Input: Sine');
xlabel('m'); ylabel('x[m]');

subplot(2,4,8);
stem(0:L_correct-1, yc_sine);
title('Output');
xlabel('k'); ylabel('y[k]');

%% TWEAK 4: Comparing conv() modes
fprintf('\nTWEAK 4: Different conv() Modes\n');
fprintf('--------------------------------\n');

yc_full = conv(x, h_unstable);
yc_same = conv(x, h_unstable, 'same');
yc_valid = conv(x, h_unstable, 'valid');

fprintf('conv(x, h) - Full:\n');
fprintf('  Length: %d samples\n', length(yc_full));
fprintf('  Returns: All non-zero output samples\n\n');

fprintf('conv(x, h, ''same'') - Same:\n');
fprintf('  Length: %d samples (same as x)\n', length(yc_same));
fprintf('  Returns: Central portion of convolution\n\n');

fprintf('conv(x, h, ''valid'') - Valid:\n');
fprintf('  Length: %d samples\n', length(yc_valid));
fprintf('  Returns: Only fully overlapping samples\n');
fprintf('  Formula: max(length(x), length(h)) - min(length(x), length(h)) + 1\n\n');

figure;
subplot(1,3,1);
stem(0:length(yc_full)-1, yc_full);
title('Full Convolution');
xlabel('k'); ylabel('y[k]');

subplot(1,3,2);
stem(0:length(yc_same)-1, yc_same);
title('Same Size');
xlabel('k'); ylabel('y[k]');

subplot(1,3,3);
stem(0:length(yc_valid)-1, yc_valid);
title('Valid Only');
xlabel('k'); ylabel('y[k]');

%% TWEAK 5: Real vs Complex parts after IFFT
fprintf('\nTWEAK 5: Real vs Imaginary Parts\n');
fprintf('----------------------------------\n');

X = fft(x, 26);
H = fft(h_unstable, 26);
Y = X .* H;
yf = ifft(Y, 26);

max_real = max(abs(real(yf)));
max_imag = max(abs(imag(yf)));

fprintf('After ifft(Y, 26):\n');
fprintf('  Max real part: %.6f\n', max_real);
fprintf('  Max imaginary part: %.15e\n', max_imag);
fprintf('  Ratio (imag/real): %.15e\n', max_imag/max_real);
fprintf('  Conclusion: Imaginary part is numerical noise!\n\n');

figure;
subplot(2,1,1);
stem(0:25, real(yf));
title('Real Part of ifft(Y)');
xlabel('k'); ylabel('real(y[k])');

subplot(2,1,2);
stem(0:25, imag(yf));
title('Imaginary Part of ifft(Y) - Numerical Noise');
xlabel('k'); ylabel('imag(y[k])');

fprintf('\n========== END OF TWEAKING EXAMPLES ==========\n');