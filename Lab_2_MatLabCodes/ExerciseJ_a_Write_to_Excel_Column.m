clc; close all; clear all;
x = -3*pi:pi/20:3*pi;
y = sin(x)+sin(2*x)+sin(3*x)+sin(4*x);
x_y = [x;y];
xlswrite('exercise_j_column.xlsx',x_y')
