% Define CR3BP dynamics function for calculating the derivative of the
% state vector X = [x,y,z,dx,dy,dz]

function Xdot = cr3bp_dynamics(t, X)
    
% Assign intuitive variables to the appropriate elements of X
    x = X(1);
    y = X(2);
    z = X(3);
    dx = X(4);
    dy = X(5);
    dz = X(6);

% Define mu, which is the fraction of the combined earth-moon mass made up
% by the moon
    mu = 1.215058535056245e-2;

% Define the distances between the spacecraft and earth (r1) & the
% spacecraft and the moon (r2)

    r1 = sqrt((-mu-x)^2 + y^2 + z^2);
    r2 = sqrt((1-mu-x)^2 + y^2 + z^2);

% Define the component-wise accelerations using the CR3BP dynamics
% equations

    ddx = -(1-mu)*(x+mu)/r1^3 + mu*(1-mu-x)/r2^3 + x + 2*dy;
    ddy = -(1-mu)*(y)/r1^3 - mu*(y)/r2^3 + y - 2*dx;
    ddz = -(1-mu)*(z)/r1^3 - mu*(z)/r2^3;

% Assign the derivative matrix of X
    Xdot = [dx; dy; dz; ddx; ddy; ddz];

end