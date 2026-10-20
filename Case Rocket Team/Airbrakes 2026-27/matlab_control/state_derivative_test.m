clear;
clc;
close all;

X0 = [2286; 0];
CdA = 0.016;
CdA_0 = 0.008;
CdA_1 = 0.03;

options = odeset('Events', @hit_ground_function);

[t, X, t_event, X_event] = ode45(@(t, X) state_derivative(t, X, CdA), [0, 40], X0, options);

figure(1)
plot(t, X)
title('State Over Time')
xlabel('Time(s)')
ylabel('Decomposed State Vector')
legend('Altitude (m)', 'Velocity (m/s)')

%%
figure(2)
Xs = [];
CdA_values = [];
Vs_rows = [];
Xs_rows = [];
F_CdAs = {};
poly_coeffs = {};
x_v_cda = [];

for idx = 1:100
    CdAs = linspace(CdA_0, CdA_1, 100);
    hold on
    [t, X, t_event, X_event] = ode45(@(t, X) state_derivative(t, X, CdAs(idx)), [0, 40], X0, options);

    Xs = [Xs; X];

    CdA_news = linspace(CdAs(idx), CdAs(idx), size(X, 1))';
    CdA_values = [CdA_values; CdA_news];

    plot(t, X)

    % Load velocity vector and X vector for each trajectory into successive
    % rows for use in "CdA_calculator_linear_test.m")
    Vs_rows = [Vs_rows; X(:, 2)'];
    Xs_rows = [Xs_rows; X(:, 1)'];
    
    % for jdx = 1:15
    %     coeffs_row = polyfit(Xs_rows(idx, :), Vs_rows(idx, :), jdx);
    %     poly_coeffs = [poly_coeffs; {coeffs_row}];
    % end

    x_F_CdAs = flip(X(:, 1)');
    x_V_CdAs = flip(X(:, 2)');

    F_CdAs{idx} = griddedInterpolant(x_F_CdAs, x_V_CdAs, 'pchip', 'none');
    
    % make matrix of x and v values in rows 1 and 2 with the CdA value for
    % the pair in row 3
    col_three_cdas = [];
    for jdx = 1:size(X, 1)
        col_three_cdas = [col_three_cdas, CdAs(idx)];
    end
    
    x_v_cda = [x_v_cda; [X, col_three_cdas']];
   
    hold off
end
x_v_cda(1, :)
x_v_cda(end, :)
save('CdA_calculator_polynomial_fit_loop_data.mat', 'poly_coeffs')
xlabel('Time')
ylabel('Decomposed State Vector')

figure(3)
plot(t, Vs_rows)
length(Vs_rows(:, 1))

save('CdA_function_data', 'F_CdAs', "CdAs")

figure(4)

for idx = 1:length(F_CdAs)
    hold on
    plot(0:2286, F_CdAs{idx}(0:2286))
    hold off
end

load("CdA_calculator_polynomial.mat")

CdA_0 = 0.008;
CdA_1 = 0.03;
CdAs = linspace(CdA_0, CdA_1, 100);

X_test = [449.0790; -214.3062];

figure(5)
CdA = CdA_calculator_polynomial(X_test, CdAs, poly_coeffs);

hold on
plot(Xs_rows(1, :), Vs_rows(1, :))
legend('Polynomial Trajectory Interpolation', 'Sampled Data Point', 'True Curve')
hold off

% load('CdA_calculator_polynomial_fit_loop_data.mat')
% 
% for idx = 1:15
%     figure(idx+5)
%     hold on
%     plot(0:2286, polyval(poly_coeffs{idx}, 0:2286))
%     plot(Xs_rows(1, :), Vs_rows(1, :))
%     hold off
%     legend('Polynomial Fit', 'True Curve')
% end

[unique_Xs_values, ia] = unique(x_v_cda(:, 1:2), 'rows', 'stable');

duplicate_idx = [];

for idx = 1:size(x_v_cda(:, 1:2), 1)
    if ismember(idx, ia) == false
        duplicate_idx = [duplicate_idx, idx];
    end
end

x_v_cda(duplicate_idx, :) = [];
F = scatteredInterpolant(x_v_cda(:, 1), x_v_cda(:, 2), x_v_cda(:, 3), 'natural', 'none');

% Create a grid of position and velocity values
x_range = linspace(min(x_v_cda(:,1)), max(x_v_cda(:,1)), 200);
v_range = linspace(min(x_v_cda(:,2)), max(x_v_cda(:,2)), 200);

[X_grid, V_grid] = meshgrid(x_range, v_range);

% Evaluate the interpolant across the grid
CdA_grid = F(X_grid, V_grid);

% Plot the interpolated surface
figure
surf(X_grid, V_grid, CdA_grid, 'EdgeColor', 'none')

xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('CdA (m^2)')
title('Interpolated CdA Surface')

colorbar
view(3)