function [value, isterminal, direction] = orbital_trigger_event(t, X, X_sample, sigma_T)

    % Define triggering condition so that condition is violated when sample
    % error becomes a fraction of the tracking error constrained by
    % sigma_T. Ode45 solves this function for zero and breaks off when the
    % condition is violated
    value = sigma_T*norm(l2_state_error(X))^2 - norm(X - X_sample)^2;

    % Tell ode45 whether to break off when condition is violated
    isterminal = 1;

    % Specify direction of boundary violation for ode45 to look for. This 
    % will be a positive to negative crossing
    direction = -1;

end

    
    