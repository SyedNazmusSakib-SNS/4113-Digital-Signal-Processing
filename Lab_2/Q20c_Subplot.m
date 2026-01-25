t = 0:0.001:0.5;
F1 = 10;
F2 = 20;
F3 = 30;
F4 = 40;
x1 = 10*sin(2*pi*F1*t);
x2 = 10*sin(2*pi*F2*t);
x3 = 10*sin(2*pi*F3*t);
x4 = 10*sin(2*pi*F4*t);
figure;
subplot(2,2,1)
plot(t,x1)
title('F1=10Hz')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(2,2,2)
plot(t,x2)
title('F2=20Hz')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(2,2,3)
plot(t,x3)
title('F3=30Hz')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(2,2,4)
plot(t,x4)
title('F4=40Hz')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
