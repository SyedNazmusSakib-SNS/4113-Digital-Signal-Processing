x1 = 0:1:10;
x2 = 2:1:12;
m1 = 0.5;
m2 = 0.6;
c1 = 2;
c2 = 3;
y1 = m1*x1+c1;
y2 = m2*x2+c2;
figure;
plot(x1,y1,'-bo','Linewidth',2)
hold on
stem(x2,y2,':rs','Linewidth',2)
title('Name of the graph')
xlabel('value of x')
ylabel('value of y')
xlim([0 15])
ylim([0 12])
grid on
legend('graph of x1','graph of x2')
