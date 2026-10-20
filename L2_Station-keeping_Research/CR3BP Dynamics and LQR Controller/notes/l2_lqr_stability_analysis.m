clear;
clc;
close all;

% Define position of L2
X_L2 = [1.155682164448510;
    0;
    0];

% Define a test perturbation
X0 = [1.155682164448510 + 1e-4;
    1e-4;
    1e-4;
    0;
    0;
    0];

opts = odeset('RelTol', 1e-11, 'AbsTol', 1e-13);

% Run ode45
[t_unc, X_unc] = ode45(@cr3bp_dynamics, [0 10], X0, opts);

norm_uncontrolled = zeros(1, length(X_unc(:, 1)));

for idx = 1:size(X_unc, 1)
    X_err = X_unc(idx, 1:3)' - X_L2;
    norm_uncontrolled(idx) = norm(X_err);
end

% Define A, B, and calculate K
A = cr3bp_jacobian(X_L2);
K = design_lqr(A);
B = [zeros(3,3); eye(3)];

% Propagate trajectory
[t_con, X_con] = ode45(@(t, X) cr3bp_controlled_dynamics(t, K, X), [0 10], X0, opts);

norm_controlled = zeros(1, length(X_con(:, 1)));

for idx = 1:size(X_con, 1)
    X_err = X_con(idx, 1:3)' - X_L2;
    norm_controlled(idx) = norm(X_err);
end

figure;
semilogy(t_unc, norm_uncontrolled, 'r-', 'LineWidth', 2);
hold on;
semilogy(t_con, norm_controlled, 'b-', 'LineWidth', 2);

xlabel('Time (nondimensional)');
ylabel('Position Error Norm (nondimensional)');
title('Controlled vs. Uncontrolled L2 Error');
legend('Uncontrolled', 'Controlled');
grid on;
hold off;

% calculate and display eigenvalues
uncontrolled_eigen = eig(A);        % Uncontrolled system
controlled_eigen = eig(A - B*K);    % LQR-controlled system

disp('The real part of the maximum uncontrolled eigenvalue is:')
disp(max(real(uncontrolled_eigen)))

disp('The real part of the maximum controlled eigenvalue is:')
disp(max(real(controlled_eigen)))

% display equilibrium residual and matrix dimensions
X_L2_full = [X_L2; 0; 0; 0];

fprintf('Equilibrium residual: %.3e\n\n', ...
    norm(cr3bp_dynamics(0, X_L2_full)));

fprintf('Dimensions of A, B, and K: %ix%i, %ix%i, and %ix%i\n', size(A), size(B), size(K))
