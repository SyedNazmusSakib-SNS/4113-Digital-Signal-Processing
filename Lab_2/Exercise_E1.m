A = [2 3 5 -1; -5 2 -1 2; 1 -4 7 6; 5 2 1 -4];
B = [3 1 2 -1; -4 -5 5 2; 1 -2 -3 3; 6 3 1 -4];
A
B
M1 = A+B;
M1
r3 = M1(3,:)
% M2 = A.*B;
% c5 = M2(:,5)
% c5
% M3 = A*B;
% e42 = M3(4,2)
invA = inv(A)
invA
B_trans = B'
B_trans
rankA = rank(A)
rankA
diagB = diag(B)
diagB