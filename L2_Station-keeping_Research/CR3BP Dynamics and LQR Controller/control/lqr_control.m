% define function to calculate the three control accelerations

function u = lqr_control(K, X)
    u = -K * l2_state_error(X);
end
