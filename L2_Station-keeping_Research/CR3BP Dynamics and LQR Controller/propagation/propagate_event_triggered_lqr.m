% This function takes as inputs initial time, final time, K, a current
% sampled state vector, and sigma_T. It returns a list of times and
% corresponding states, along with the state at each event update and the
% corresponding time

function [times, Xs, t_updates, X_updates] = propagate_event_triggered_lqr(t0, tf, K, X0, sigma_T)
    
    % Define initial condition to put into the ode
    X_input = X0;

    % define vector of times to be successively filled 
    times = [t0];

    % Define matrix of states to be successively filled
    Xs = [0,0,0,0,0,0];
    
    % Define update states and times
    t_updates = [0];
    X_updates = [X0'];

    

    while t0 < tf
        
        % call events function which prescribes the appropriate triggering
        % condition and stores in options for the ode45
        options = odeset('Events', @(t, X) orbital_trigger_event(t, X, X_input, sigma_T));
        
        % integrate trajectory until event is triggered
        [t, X, t_update, X_update] = ode45(@(t, X) cr3bp_sampled_dynamics(t, K, X, X_input), [t0, tf], X_input, options);
        
        % fill in list of times, states, and update initial conditions
        times(end) = [];
        times = [times; t];
        t0 = t_update;

        Xs(end, :) = [];
        Xs = [Xs; X];
        X_input = X_update';

        t_updates = [t_updates; t_update];
        X_updates = [X_updates; X_update];
        
        % if there is no event then break
        if isempty(t_update)
            break
        end
    end
end

