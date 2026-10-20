clear;
clc;
close all;

t0 = 0;
tf = 2;
sigma_T = 0.01;

X_L2 = [1.155682164448510;
    0;
    0;
    0;
    0;
    0];

A = cr3bp_jacobian(X_L2);

K = design_lqr(A);

X0 = [1.155682164448510 + 1e-1;
    1e-1;
    1e-1;
    0;
    0;
    0];

[times, Xs, t_updates, X_updates] = propagate_event_triggered_lqr(t0, tf, K, X0, sigma_T);

figure(1)
plot(times, Xs)
xlabel('Time')
ylabel('State')
title('Event Triggered Controlled Trajectory')
legend('$x$', '$y$', '$z$', ...
       '$\dot{x}$', '$\dot{y}$', '$\dot{z}$', ...
       'Interpreter', 'latex', ...
       'Location', 'best')

figure(2)
plot(t_updates, X_updates)
xlabel('Update Times')
ylabel('State')
title('Event Triggered State Updates')
legend('$x$', '$y$', '$z$', ...
    '$\dot{x}$', '$\dot{y}$', '$\dot{z}$', ...
    'Interpreter', 'latex', ...
    'Location', 'best')

us = zeros(size(X_updates, 1), 3);

for idx = 1:size(X_updates, 1)
    u = lqr_control(K, X_updates(idx, :)');
    us(idx, :) = u';
end

figure(3)
stairs(t_updates, us)
xlabel('Update Times')
ylabel('Control Acceleration')
title('Event Triggered Control Accelerations')
legend('$u_x$', '$u_y$', '$u_z$', ...
    'Interpreter', 'latex', ...
    'Location', 'best')

