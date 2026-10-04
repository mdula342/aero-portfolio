clear;
clc;
close all;

% solve for the root of my function that calculates x-acceleration so I can
% obtain corresponding state vector

xL2 = fzero(@L2_calculation_function, 1.15);

format long
disp(xL2)