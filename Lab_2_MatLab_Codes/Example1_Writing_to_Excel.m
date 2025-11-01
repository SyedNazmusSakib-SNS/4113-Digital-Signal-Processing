clc; close all; clear all;
x = -2*pi:pi/32:2*pi;
y = sin(x);
x_y = [x;y];
figure;
plot(x,y)
xlabel('value of x')
ylabel('value of sinx')
grid on
xlswrite('x_vs_sinx_column.xlsx',x_y')
xlswrite('x_vs_sinx_row.xlsx',x_y)
