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
plot(t,x1)
hold on
plot(t,x2)
plot(t,x3)
plot(t,x4)
title('Four Sine Waves')
xlabel('Time (s)')
ylabel('Amplitude')
legend('F1=10Hz','F2=20Hz','F3=30Hz','F4=40Hz')
grid on
