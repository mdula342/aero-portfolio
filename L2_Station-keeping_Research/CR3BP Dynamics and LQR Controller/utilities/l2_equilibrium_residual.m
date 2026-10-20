% define function for calculating L2 according to my specific model for
% consistency reasons. This function returns the x-acceleration, which
% allows me to later solve for its root to find L2

function ax = l2_equilibrium_residual(x)

    X = [x;0;0;0;0;0];

    Y = cr3bp_dynamics(0, X);

    ax = Y(4);

end

