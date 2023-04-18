% clear all
close all
s = tf('s');
clc
global G u t;
%% Modelo de sistema de 2ª ordem

G = 1/((s+5)*(s+4));

%% teste preliminar
z1 = 10;
z2 = 6;
K = 0.1;

kd = K;
kp = (z1 + z2)*kd;
ki = (z1*z2)*kd;

PID = K*(s+z1)*(s+z2)/s;
TF_MA =  PID * G;


%% Identificação do controlador PID - optimização local
t = 0:1e-3:10;
u = ones(1,length(t));


parameters(1) = z1;
parameters(2) = z2;
parameters(3) = K; 

options = optimset('Display','iter', 'MaxIter', 2^16,'TolFun',1e-6, 'TolX',1e-6,'MaxFunEvals',2^16);
[parameters_out, Error] = fminsearch(@PID_FMIN_WeightedError, parameters, options);


%% simulação optimização local
z1 = parameters_out(1);
z2 = parameters_out(2);
K = parameters_out(3); 

PID = K*(s+z1)*(s+z2)/s;

TF = feedback(PID*G,1);

step(TF,10)
