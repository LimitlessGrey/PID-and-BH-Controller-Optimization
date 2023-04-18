function weighted_error = BH_FMIN_WeightedError(Parameters)

global u t; 

M0 = Parameters(1);
BH_y  = Parameters(2);
r0 = Parameters(3);
a  = Parameters(4);
k1 = Parameters(5);
k2 = Parameters(6);

% Assign the updated parameters to the base workspace
assignin('base', 'M0', M0);
assignin('base', 'BH_y', BH_y);
assignin('base', 'r0', r0);
assignin('base', 'a', a);
assignin('base', 'k1', k1);
assignin('base', 'k2', k2);

% Simulate the model with updated parameters
sim_out = sim("PNEU_BH.slx");

erro = u' - sim_out.Y(:,2);

% Calculate the different error metrics
mse = mean((erro).^2);
mae = mean(abs(erro));
medae = median(abs(erro));
rmse = sqrt(mse);
peak = 20 * log10(max(abs(u)) / sqrt(mse));

% Calculate the overshoot
overshoot = max(sim_out.Y(:,2)) - 0.2;

% Apply a penalty for overshoot
if overshoot > 0
    overshoot_penalty = 100 * overshoot;
else
    overshoot_penalty = 0;
end

% Assign weights to the error metrics
w_mse = 0.6;
w_mae = 0.1;
w_medae = 0.1;
w_rmse = 0.1;
w_peak = 0.1;
w_overshoot = 1; % Assign a weight to the overshoot penalty

% Calculate the weighted error
weighted_error = w_mse * mse + w_mae * mae + w_medae * medae + w_rmse * rmse - w_peak * peak + w_overshoot * overshoot_penalty;

if weighted_error > 1e5
    weighted_error = 1e5;
end

end
