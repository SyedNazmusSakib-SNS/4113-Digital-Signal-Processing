a = 0.1;
f(1) = 1;
for i = 2:5
    f(i) = (1-a)*f(i-1);
end
f
