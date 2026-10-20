
clear; 
clc;
close all;

% Initial guess for L2 (nondimensional CR3BP coordinates)
x_guess = 1.15;

% Solve for zero acceleration
x_L2 = fzero(@l2_equilibrium_residual, x_guess);

% Display result
fprintf('L2 x-coordinate: %.15f\n', x_L2);

% Verify the residual is approximately zero
fprintf('Residual: %.3e\n', l2_equilibrium_residual(x_L2));
