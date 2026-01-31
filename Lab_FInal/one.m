clear all;
close all;
clc;

m = 0:15;
x = (0.8).^m;

n = 0:10;
h = (1.4).^n;

yc = conv(x, h);

L = length(x) + length(h) - 1;

figure;
subplot(1,3,1);
stem(m, x);
xlabel('m');
ylabel('x[m]');
title('Input Signal');

subplot(1,3,2);
stem(n, h);
xlabel('n');
ylabel('h[n]');
title('Impulse Response');

subplot(1,3,3);
stem(0:L-1, yc);
xlabel('k');
ylabel('y[k]');
title('Output (Convolution)');

X = fft(x, L);
H = fft(h, L);

figure;
subplot(2,2,1);
stem(0:L-1, abs(X));
xlabel('k');
ylabel('|X(k)|');
title('Magnitude of X(k)');

subplot(2,2,2);
stem(0:L-1, angle(X));
xlabel('k');
ylabel('Phase of X(k)');
title('Phase of X(k)');

subplot(2,2,3);
stem(0:L-1, abs(H));
xlabel('k');
ylabel('|H(k)|');
title('Magnitude of H(k)');

subplot(2,2,4);
stem(0:L-1, angle(H));
xlabel('k');
ylabel('Phase of H(k)');
title('Phase of H(k)');

Y = X .* H;
yf = ifft(Y, L);

figure;
subplot(1,2,1);
stem(0:L-1, yc);
xlabel('k');
ylabel('y_c[k]');
title('Time Domain (Convolution)');

subplot(1,2,2);
stem(0:L-1, real(yf));
xlabel('k');
ylabel('y_f[k]');
title('Frequency Domain (Multiplication)');

diff = max(abs(yc - real(yf)));
fprintf('Maximum difference: %.15e\n', diff);