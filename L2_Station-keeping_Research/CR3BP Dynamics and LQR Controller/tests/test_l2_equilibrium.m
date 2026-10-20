clear;
clc;
close all;

% solve for the root of my function that calculates x-acceleration so I can
% obtain corresponding state vector

xL2 = fzero(@l2_equilibrium_residual, 1.15);

format long
disp(xL2)