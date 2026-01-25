x = 0:1:10;
m = 0.5;
c = 2;
y = m*x+c;
figure;
plot(x,y,':rs','Linewidth',2)
title('Name of the graph')
xlabel('value of x')
ylabel('value of y')
xlim([0 15])
ylim([0 12])
grid on
