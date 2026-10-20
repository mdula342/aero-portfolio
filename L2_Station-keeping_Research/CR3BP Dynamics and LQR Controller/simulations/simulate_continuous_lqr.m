clear;
clc;
close all;

% Define a test perturbation
X0 = [1.155682164448510 + 1e-4;
     1e-4;
     1e-4;
     0;
     0;
     0];

% Define X_L2, A, B, and calculate K
X_L2 = [1.155682164448510;
        0;
        0;
        0;
        0;
        0];

A = cr3bp_jacobian(X_L2);
K = design_lqr(A);
B = [zeros(3,3); eye(3)];

% Propagate trajectory
[t, X] = ode45(@(t, X) cr3bp_controlled_dynamics(t, K, X), [0 2], X0);

% 
X_err = [];
us = [];


for ii = 1:size(X, 2)
    X_err = [X_err, X(:, ii) - X_L2(ii)];  
end

for ii = 1:(size(X, 1))
    us = [us, lqr_control(K, X(ii, :)')];
end

% calculate and display eigenvalues
uncontrolled_eigen = eig(A);        % Uncontrolled system
controlled_eigen = eig(A - B*K);    % LQR-controlled system

disp('The uncontrolled eigenvalues are:')
disp(uncontrolled_eigen)

disp('The controlled eigenvalues are:')
disp(controlled_eigen)
figure(1)
plot3(X(:, 1), X(:, 2), X(:, 3))
xlabel('X-position')
ylabel('Y-position')
zlabel('Z-position')
title('Controlled Trajectory of Initial Perturbation')

figure(2)
plot(t, X_err)
legend({'$x$', '$y$', '$z$', ...
        '$\dot{x}$', '$\dot{y}$', '$\dot{z}$'}, ...
       'Interpreter', 'latex', ...
       'Location', 'best', ...
       'FontSize', 12, ...
       'NumColumns', 2, ...
       'Box', 'on');
title('Controlled State Errors')
xlabel('Time (TU)')
ylabel('State Error')

figure(2)
figure(3)
plot(t, us(1, :), '-', t, us(2, :), '--', t, us(3, :), '.-')
legend('X acceleration', 'Y acceleration', 'Z acceleration')
title('Decomposed Control Acceleration')
xlabel('Time (TU)')
ylabel('Acceleration (DU/TU^2)')