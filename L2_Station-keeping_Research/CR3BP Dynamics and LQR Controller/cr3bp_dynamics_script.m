clear;
clc;
close all;

% Initial state:
% X = [x; y; z; dx; dy; dz]
X0 = [1.1556821654; 0; 0; 0; 0; 0];

% Time interval
tspan = [0 10];

% Solver accuracy settings
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);

% Run ode45
[t, X] = ode45(@cr3bp_dynamics, tspan, X0, opts);

% Plot trajectory
figure;
plot3(X(:,1), X(:,2), X(:,3), 'LineWidth', 1.5);
grid on;
axis equal;

xlabel('x');
ylabel('y');
zlabel('z');
title('Uncontrolled CR3BP Trajectory');

