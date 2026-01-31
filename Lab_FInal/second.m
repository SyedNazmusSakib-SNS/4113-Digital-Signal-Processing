clear all;
close all;
clc;

m = 0:15;
x = (0.8).^m;

N = 26;
X = fft(x, N);

figure;
subplot(3,1,1);
stem(m, x, 'b', 'LineWidth', 1.5);
xlabel('m');
ylabel('x[m]');
title('Original Signal');
grid on;

k_values = [0, 1, 2, 5];
for idx = 1:length(k_values)
    k = k_values(idx);
    
    freq_component = abs(X(k+1)) * cos(2*pi*k*(0:N-1)/N + angle(X(k+1)));
    
    subplot(3,1,idx+1);
    if idx <= 2
        stem(0:N-1, freq_component, 'r', 'LineWidth', 1.5);
        xlabel('n');
        ylabel(sprintf('Component k=%d', k));
        title(sprintf('Frequency Component k=%d, |X(%d)|=%.2f, Phase=%.2f', k, k, abs(X(k+1)), angle(X(k+1))));
        grid on;
    end
end

figure;
subplot(2,2,1);
stem(0:N-1, abs(X), 'b', 'LineWidth', 1.5);
xlabel('k');
ylabel('|X(k)|');
title('Magnitude Spectrum');
grid on;

subplot(2,2,2);
stem(0:N-1, angle(X), 'r', 'LineWidth', 1.5);
xlabel('k');
ylabel('Phase of X(k)');
title('Phase Spectrum');
grid on;

subplot(2,2,3);
stem(0:N-1, real(X), 'g', 'LineWidth', 1.5);
xlabel('k');
ylabel('Real(X(k))');
title('Real Part');
grid on;

subplot(2,2,4);
stem(0:N-1, imag(X), 'm', 'LineWidth', 1.5);
xlabel('k');
ylabel('Imag(X(k))');
title('Imaginary Part');
grid on;

fprintf('DC Component X[0] = %.4f\n', X(1));
fprintf('Sum of x[m] = %.4f\n', sum(x));
fprintf('Nyquist frequency (k=13): |X[13]| = %.4f\n', abs(X(14)));

fprintf('\nSymmetry Check:\n');
fprintf('|X[1]| = %.4f, |X[25]| = %.4f\n', abs(X(2)), abs(X(26)));
fprintf('|X[2]| = %.4f, |X[24]| = %.4f\n', abs(X(3)), abs(X(25)));
fprintf('|X[5]| = %.4f, |X[21]| = %.4f\n', abs(X(6)), abs(X(22)));