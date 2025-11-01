N1 = ones(5);
N2 = magic(5);
N3 = eye(5);
E = N1./N2;
F = N2*N3;
G = E+F;
d = det(G)
r24 = G(4,2)
