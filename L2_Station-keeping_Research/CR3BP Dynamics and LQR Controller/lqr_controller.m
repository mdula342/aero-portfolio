% define function to calculate the three control accelerations

function u = lqr_controller(K, X)
    u = -K * delta_XL2(X);
end
