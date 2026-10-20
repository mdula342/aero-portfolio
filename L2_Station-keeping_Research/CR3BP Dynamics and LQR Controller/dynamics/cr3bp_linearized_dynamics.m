% define function to calculate the linearized approximation of Xdot given
% A and a state vector. t is also used as an input because ode45 requires
% it later on

function Xdot_linear = cr3bp_linearized_dynamics(t, X, A)
    
    % use my calculation of the L2 point
    X_L2 = [1.155682164448510; 0; 0; 0; 0; 0];
    
    % linearized Xdot using A and my "error from L2 equilibrium" function
    Xdot_linear = A*l2_state_error(X);

end