function LQR_Xdot = sampled_controlled_cr3bp_dynamics(t, K, X, X_input)

    % add u (control accelerations) to the nonlinear derivative of the 
    % state vector to define the controlled cr3bp function
    B = [zeros(3,3); eye(3)];
    LQR_Xdot = cr3bp_dynamics(t, X) + (B*lqr_controller(K, X_input));
end

