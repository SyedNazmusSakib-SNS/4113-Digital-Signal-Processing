clc;
clear;
close all;

Fs = 800;
T = 1/Fs;
n = 0:399;

f1 = 120;
f2 = 80;

x1 = cos(2*pi*f1*n*T);
x2 = cos(2*pi*f2*n*T);
x  = x1 + x2;

w0 = 2*pi*f2/Fs;
h = [1 -2*cos(w0) 1];

N = 1024;
H = fft(h,N);
f = (0:N-1)*(Fs/N);

y = conv(x,h);
y = y(1:length(x));

X = abs(fft(x,N));
Y = abs(fft(y,N));

figure;
zplane(h,1);
grid on




figure;
subplot(3,1,1)
plot(n,x1)
grid on
subplot(3,1,2)
plot(n,x2)
grid on
subplot(3,1,3)
plot(n,x)
grid on

figure;
plot(f,abs(H),'LineWidth',1.5)
xlabel('Frequency (Hz)')
ylabel('|H(f)|')
grid on

figure;
plot(n,x,'b')
hold on
plot(n,y,'r')
grid on
legend('Input','Output')

figure;
subplot(2,1,1)
stem(f,X,'filled')
xlim([0 Fs/2])
grid on
subplot(2,1,2)
stem(f,Y,'filled')
xlim([0 Fs/2])
grid on
