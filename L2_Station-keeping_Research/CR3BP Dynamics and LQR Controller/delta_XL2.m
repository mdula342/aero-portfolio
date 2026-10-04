% define a function for calculating the error of any state vector from the 
% L2 equilibrium state

function dx = delta_XL2(X)
    
    X_L2 = [1.155682164448510; 0; 0; 0; 0; 0];

    dx = X - X_L2;
end