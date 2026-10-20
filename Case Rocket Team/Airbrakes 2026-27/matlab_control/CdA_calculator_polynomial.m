% This function takes as arguments the state vector, the list of CdA
% values, and a matrix of polynomial coefficients such that the row number of
% coefficients corresponds to the interpolated velocity function of the CdA
% value of the same index

function CdA = CdA_calculator_polynomial(X, CdAs, poly_coeffs)
    
    x = X(1);
    v = X(2);
    
    % preallocate list of velocity errors
    velocity_errors = zeros(1, 100);
    
    % loop through the list of polynomials and calculate the velocity for
    % the given position, calculate the error, and store. 
    for idx = 1:length(CdAs)

        velocity_errors(idx) = abs(polyval(poly_coeffs(idx, :), x) - v);

    end
    
    % select CdA value corresponding to the index of the smallest velocity
    % error
    CdA = CdAs(velocity_errors == min(velocity_errors));

    hold on
    plot(0:2286, polyval(poly_coeffs(CdAs == CdA, :), 0:2286), '-')
    plot(x, v, 'o')
    legend('Polynomial Trajectory Interpolation', 'Sampled Data Point')
    hold off
    
    disp(CdA)
end