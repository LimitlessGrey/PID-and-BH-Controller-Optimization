function weighted_error = PID_FMIN_WeightedError(Parameters)

global u ; 

z1 = Parameters(1);
z2 = Parameters(2);
K = Parameters(3);

kd = K;
kp = (z1 + z2)*kd;
ki = (z1*z2)*kd;

assignin('base', 'kd', kd);
assignin('base', 'kp', kp);
assignin('base', 'ki', ki);

y = sim("PNEU_PID.slx");

erro = u' - y.Y(:,2);

% Calculate the different error metrics
mse = mean((erro).^2);
mae = mean(abs(erro));
medae = median(abs(erro));
rmse = sqrt(mse);
peak = 20 * log10(max(abs(u)) / sqrt(mse));

% Calculate the overshoot
overshoot = max(y.Y(:,2)) - 1; % Assuming the reference is 1

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
