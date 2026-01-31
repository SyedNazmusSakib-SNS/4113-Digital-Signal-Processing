clc; clear; close all;

Fs = 1000;
T = 1/Fs;
F1 = 100;
F2 = 50;

n = 0:1:Fs/2-1;

s1 = cos(2*pi*F1*n*T);
s2 = cos(2*pi*F2*n*T);
s = s1 + s2;

h = [1 -1.9021130326 1];

[H, f] = freqz(h, 1, 512, Fs);

figure;
plot(f, abs(H));
title('Filter Frequency Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
xlim([0 200]);