Fs = 800;       
T = 1/Fs;       
n = 0:399;    

f1 = 120;        
f2 = 80;         

x1 = cos(2*pi*f1*n*T);   
x2 = cos(2*pi*f2*n*T);   

x = x1 + x2;


w0 = 2*pi*f2/Fs;

a = 2*cos(w0);
h = [1  -a  1];

y = conv(x, h);

figure;
plot(n, x(1:length(n)));
hold on;
plot(n, y(1:length(n)));
grid on;
legend('Input signal','Filtered output');






