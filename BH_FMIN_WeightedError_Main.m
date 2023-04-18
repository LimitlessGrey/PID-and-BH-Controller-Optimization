%% Main script
clc;

global u t;

% Test preliminar
M0 = 480;
BH_y = 170;
ro = 0.62;
a = 3.2;
k1 = 11;
k2 = 0.9;

% Time vector
t = 0:5e-5:10;

% Input signal
u = ones(1,length(t));

% Initial parameters
parameters(1) = M0;
parameters(2) = BH_y;
parameters(3) = ro;
parameters(4) = a;
parameters(5) = k1;
parameters(6) = k2;

% Optimization options
options = optimset('Display','iter', 'MaxIter', 2^16,'TolFun',1e-6, 'TolX',1e-6,'MaxFunEvals',2^16);

% Run optimization
[parameters_out, Error] = fminsearch(@BH_FMIN_WeightedError, parameters, options);


%Funcoes de calculo de erro
% BH_FMIN_MAE(Parameters)
% BH_FMIN_MedAE(Parameters)
% BH_FMIN_MSE(Parameters)
% BH_FMIN_PEAK(Parameters)

% Display results
disp('Optimized Parameters:');
disp(['M0: ', num2str(parameters_out(1))]);
disp(['BH_y: ', num2str(parameters_out(2))]);
disp(['ro: ', num2str(parameters_out(3))]);
disp(['a: ', num2str(parameters_out(4))]);
disp(['k1: ', num2str(parameters_out(5))]);
disp(['k2: ', num2str(parameters_out(6))]);
disp(['Error: ', num2str(Error)]); %VERIFICAR SAIDA