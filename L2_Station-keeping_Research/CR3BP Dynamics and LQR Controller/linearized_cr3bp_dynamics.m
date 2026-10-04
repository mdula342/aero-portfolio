% f(x0) = f(xeq) + df/dx(x0-xeq), where xeq is the state vector of a
% motionless particle at the L2 equilibrium point, and x0 is a perturbed
% condition, i.e., a state vector only slightly removed from xeq. df/dx is
% a 6x6 matrix of partial derivatives. Take the x' component of f(x), for example.
% To find the new position, we need to know how the x' component of f(x) changes
% with respect to each component of the state vector x. So to find the
% cumulative change in x' we have dx' = (dx'/dx)dx + (dx'/dy)dy +
% (dx'/dz)dz + (dx'/dx')dx' + (dx'/dy')dy' + (dx'/dz')dz'. And df is this
% process for each of its components. So we need to multiply the vector
% (x0-xeq), i.e., [dx,dy,dz,dx',dy',dz'], by matrix A = df/dx, which
% contains a derivative of every component of f(x) with respect to each
% component of x

% define X_L2
X = [1.155682164448510; 0; 0; 0; 0; 0];

% assign appropriate variables
x = X(1);
y = X(2);
z = X(3);

% define mu
mu = 1.215058535056245e-2;

% distance functions from the cr3bp dynamics 
r1 = sqrt((-mu-x)^2 + y^2 + z^2);
r2 = sqrt((1-mu-x)^2 + y^2 + z^2); 

% derivatives of distance functions for use in repeated differentiation
% later
dr1_dx = (mu+x)*((-mu-x)^2 + y^2 + z^2)^(-1/2);
dr2_dx = (mu+x-1)*((1-mu-x)^2 + y^2 + z^2)^(-1/2);

dr1_dy = y*((-mu-x)^2 + y^2 + z^2)^(-1/2);
dr2_dy = y*((1-mu-x)^2 + y^2 + z^2)^(-1/2);

dr1_dz = z*((-mu-x)^2 + y^2 + z^2)^(-1/2);
dr2_dz = z*((1-mu-x)^2 + y^2 + z^2)^(-1/2);

% start defining derivatives of each component of Xdot with
% respect to each component of X

dvx_x = 0;
dvx_y = 0;
dvx_z = 0;
dvx_vx = 1;
dvx_vy = 0;
dvx_vz = 0;

dvy_x = 0;
dvy_y = 0;
dvy_z = 0;
dvy_vx = 0;
dvy_vy = 1;
dvy_vz = 0;

dvz_x = 0;
dvz_y = 0;
dvz_z = 0;
dvz_vx = 0;
dvz_vy = 0;
dvz_vz = 1;

% analytical calculations for some of the acceleration derivatives
dax_x = (-(1-mu)*r1^3 + 3*r1^2*dr1_dx*(1-mu)*(x+mu))/r1^6 - (mu*r2^3 + 3*r2^2*dr2_dx*mu*(1-mu-x))/r2^6 + 1;
dax_y = 3*(1-mu)*(x+mu)*dr1_dy/r1^4 - 3*mu*(1-mu-x)*dr2_dy/r2^4;
dax_z = 3*(1-mu)*(x+mu)*dr1_dz/r1^4 - 3*mu*(1-mu-x)*dr2_dz/r2^4;
dax_vx = 0;
dax_vy = 2;
dax_vz = 0;

day_x = 3*(1-mu)*y*dr1_dx/r1^4 + 3*mu*y*dr2_dx/r2^4;
day_y = ((mu-1)*r1^3 + 3*r1^2*dr1_dy*(1-mu)*y)/r1^6 - (mu*r2^3 - 3*r2^2*dr2_dy*mu*y)/r2^6 + 1;
day_z = 3*(1-mu)*y*dr1_dz/r1^4 + 3*mu*y*dr2_dz/r2^4;
day_vx = -2;
day_vy = 0;
day_vz = 0;

daz_x = 3*(1-mu)*z*dr1_dx/r1^4 + 3*mu*z*dr2_dx/r2^4;
daz_y = 3*(1-mu)*z*dr1_dy/r1^4 + 3*mu*z*dr2_dy/r2^4;
daz_z = ((mu-1)*r1^3 + 3*r1^2*dr1_dz*(1-mu)*z)/r1^6 - (mu*r2^3 - 3*r2^2*dr2_dz*mu*z)/r2^6;
daz_vx = 0;
daz_vy = 0;
daz_vz = 0;

% calculate A
A = [dvx_x, dvx_y, dvx_z, dvx_vx, dvx_vy, dvx_vz;
     dvy_x, dvy_y, dvy_z, dvy_vx, dvy_vy, dvy_vz;
     dvz_x, dvz_y, dvz_z, dvz_vx, dvz_vy, dvz_vz;
     dax_x, dax_y, dax_z, dax_vx, dax_vy, dax_vz;
     day_x, day_y, day_z, day_vx, day_vy, day_vz;
     daz_x, daz_y, daz_z, daz_vx, daz_vy, daz_vz]

