% This function computes the sampled-data controlled trajectory by running
% ode45 for each individual update interval with a constant acceleration,
% and then recalculating the acceleration at the update time for the next
% run.

% Input the start time, end time, step size, K, and an initial
% perturbation, X0
function [times, X_inputs, Xs] = sampled_data_control_propogator(t0, tf, h, K, X0)
    
    % Compute list of update times
    steps = t0:h:tf;

    % Create a variable, X_input, that will update every loop to act as the
    % new initial condition for ode45
    X_input = X0;

    % Define state vector matrix and time vector to be successively filled
    % by the ode45 runs. Fill both with zeros because the (end, :) syntax
    % used inside the loop does not work on an empty object
    Xs = [0,0,0,0,0,0];
    ts = [0];

    % Define matrix of state vectors that correspond to the update times
    X_inputs = [];
    
    % Loop through the update times and run ode45 once for each update
    % interval
    for ii = 1:(length(steps)-1)
        [t, X] = ode45(@(t, X) sampled_controlled_cr3bp_dynamics(t, K, X, X_input), [steps(ii), steps(ii+1)], X_input);
        
        % Cut the last row/element because X_input gets set equal to the
        % last row of Xs. The start time for the next ode45 run is also the
        % same as the last time for the previous run. So this is to avoid
        % duplicating the time and state at every update
        Xs(end, :) = [];
        ts(end, :) = [];
        
        % Successively store results of each run
        Xs = [Xs; X];
        ts = [ts; t];
        X_inputs = [X_inputs, X_input];
        
        % Update the initial condition for ode45 as the last state of the
        % previous run
        X_input = X(end, :)';           
    end
    
    % Define times from the list inside the loop
    times = ts;

end