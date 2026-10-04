clear;
clc;
close all;

% Define a small test perturbation
X0 = [1.155682164448510 + 1e-1;
     1e-1;
     1e-1;
     0;
     0;
     0];

% Define X_L2, A, and calculate K
X_L2 = [1.155682164448510;
        0;
        0;
        0;
        0;
        0];

A = cr3bp_A_calculation(X_L2);
K = lqr_design(A);

[t, X] = ode45(@(t, X) controlled_cr3bp_dynamics(t, K, X), [0 2], X0);

X_err = [];
us = [];


for ii = 1:size(X, 2)
    X_err = [X_err, X(:, ii) - X_L2(ii)];  
end

for ii = 1:(size(X, 1))
    us = [us, lqr_controller(K, X(ii, :)')];
end

figure(1)
plot3(X(:, 1), X(:, 2), X(:, 3))
xlabel('X-position')
ylabel('Y-position')
zlabel('Z-position')
title('Controlled Trajectory of Initial Perturbation')

figure(2)
plot(t,X_err(:,1),'-', t,X_err(:,2),'--', t,X_err(:,3),':', t,X_err(:,4),'-.', t,X_err(:,5),'-*', t,X_err(:,6),'--x')
legend('X', 'Y', 'Z', 'Xdot', 'Ydot', 'Zdot')
title('Decomposed State Vector Errors')
xlabel('Time (DU)')
ylabel('State Vector Errors')
figure(3)
plot(t, us(1, :), '-', t, us(2, :), '--', t, us(3, :), '.-')
legend('X acceleration', 'Y acceleration', 'Z acceleration')
title('Decomposed Control Acceleration')
xlabel('Time (TU)')
ylabel('Acceleration (DU/TU^2)')