clear all;
close all;
clc;

m = 0:15;
x = (0.8).^m;

n = 0:10;
h = (1.4).^n;

L26 = 26;
L50 = 50;

X26 = fft(x, L26);
H26 = fft(h, L26);
Y26 = X26 .* H26;
yf26 = ifft(Y26, L26);

X50 = fft(x, L50);
H50 = fft(h, L50);
Y50 = X50 .* H50;
yf50 = ifft(Y50, L50);

yc = conv(x, h);

figure;
subplot(2,2,1);
stem(0:L26-1, abs(X26), 'b', 'LineWidth', 1.5);
xlabel('k');
ylabel('|X(k)|');
title('L = 26 points');
grid on;

subplot(2,2,2);
stem(0:L50-1, abs(X50), 'r', 'LineWidth', 1.5);
xlabel('k');
ylabel('|X(k)|');
title('L = 50 points');
grid on;

subplot(2,2,3);
stem(0:length(yc)-1, yc, 'b', 'LineWidth', 1.5);
hold on;
stem(0:L26-1, real(yf26), 'ro', 'LineWidth', 1.5);
xlabel('k');
ylabel('y[k]');
title('Output: L=26 (blue=conv, red=FFT)');
legend('conv', 'FFT L=26');
grid on;

subplot(2,2,4);
stem(0:length(yc)-1, yc, 'b', 'LineWidth', 1.5);
hold on;
stem(0:L50-1, real(yf50), 'mo', 'LineWidth', 1.5);
xlabel('k');
ylabel('y[k]');
title('Output: L=50 (blue=conv, magenta=FFT)');
legend('conv', 'FFT L=50');
grid on;

fprintf('Original signal x has %d samples\n', length(x));
fprintf('Original signal h has %d samples\n', length(h));
fprintf('Convolution output has %d samples\n', length(yc));
fprintf('\n');

fprintf('L = 26:\n');
fprintf('  Length of X26: %d\n', length(X26));
fprintf('  Length of yf26: %d\n', length(yf26));
fprintf('  Max difference from conv: %.15e\n', max(abs(yc - real(yf26))));
fprintf('\n');

fprintf('L = 50:\n');
fprintf('  Length of X50: %d\n', length(X50));
fprintf('  Length of yf50: %d\n', length(yf50));
fprintf('  First 26 samples match conv: %.15e\n', max(abs(yc - real(yf50(1:26)))));
fprintf('  Samples 27-50 should be zero: max value = %.15e\n', max(abs(yf50(27:50))));