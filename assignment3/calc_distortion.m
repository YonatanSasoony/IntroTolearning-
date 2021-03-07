function [A,V,D] = calc_distortion()
x1 = [1 2 3 4];
x2 = [3 4 1 -5];
x3 = [-10 1 4 6];
X = [x1;x2;x3];

A = X'*X;

d = 4;
k = 2;

[V,D] = eig(A);

U = V(:,3:4);

x1_new = U*U'*x1';
x2_new = U*U'*x2';
x3_new = U*U'*x3';

sum = dot(x1' - x1_new,x1' - x1_new) + dot(x2' - x2_new,x2' - x2_new) + dot(x3' - x3_new,x3' - x3_new)
end