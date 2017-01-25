function [U, V] = dftuv(M, N)
%DFTUV Computes meshgrid frequency matrices.
% [U, V] = DFTUV(M, N) computes meshgrid frequency matrices U and
% V. u and v are useful for computing frequency -domain filter
% functions that can be used with DFTFILT. U and V are both
% M-by-N. 1 if D(u, v) 5 Do
% Set up range of variables.
u = 0:(M-1);
v = 0: (N-1);
idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v> N/2);
v(idy) = v(idy) - N;

[V,U] = meshgrid(v,u);