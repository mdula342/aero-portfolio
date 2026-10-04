% define the L2 point
X_L2 = [1.155682164448510; 0; 0; 0; 0; 0];

% define a slightly perturbed test vector
X_test = [1.155682264448510; -1e-5; 2e-5; 5e-6; -1e-5; 2e-6];

% calculate A
A = cr3bp_A_calculation(X_L2);

% calculate K using A
K = lqr_design(A);

% calculate u 
u = lqr_controller(K, X_test);

fprintf('\nControl Accelerations:\n')
disp(u)

% define t so the function can run
t = 0;

% call controlled dynamics function
controlled_Xdot = controlled_cr3bp_dynamics(t, K, X_test);
fprintf('Controlled State Vector Derivative:\n')
disp(controlled_Xdot)

