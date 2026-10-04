clear;
clc;
close all;

% L2 equilibrium
X_L2 = [1.155682164448510; 0; 0; 0; 0; 0];
 
% Small perturbation
deltaX = [1e-6; 0; 0; 0; 0; 0];

% Perturbed state
X_test = X_L2 + deltaX;

% Nonlinear derivative
Xdot_nonlinear = cr3bp_dynamics(0, X_test);

% Linearized prediction
A = cr3bp_A_calculation(X_L2);
Xdot_linear = cr3bp_linear_dynamics(0, X_test, A);

% Display results
disp('Nonlinear derivative:')
disp(Xdot_nonlinear)

disp('Linearized prediction:')
disp(Xdot_linear)

disp('Difference:')
disp(Xdot_nonlinear - Xdot_linear)