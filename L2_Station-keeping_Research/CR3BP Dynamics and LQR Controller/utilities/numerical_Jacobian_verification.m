
% L2 equilibrium
X_L2 = [1.155682164448510; 0; 0; 0; 0; 0];

% Analytical Jacobian from existing function
A_analytical = cr3bp_jacobian(X_L2);

% Numerical Jacobian using central finite differences
h = 1e-6;
A_numerical = zeros(6,6);

for j = 1:6
    perturbation = zeros(6,1);
    perturbation(j) = h;

    Xdot_plus = cr3bp_dynamics(0, X_L2 + perturbation);
    Xdot_minus = cr3bp_dynamics(0, X_L2 - perturbation);

    A_numerical(:,j) = (Xdot_plus - Xdot_minus)/(2*h);
end

% Compare results
disp('Analytical Jacobian:')
disp(A_analytical)

disp('Numerical Jacobian:')
disp(A_numerical)

max_error = max(abs(A_analytical - A_numerical), [], 'all');

fprintf('Maximum absolute difference: %.3e\n', max_error);
