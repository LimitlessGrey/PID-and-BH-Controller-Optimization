clear all;
close all;
clc;

%% parâmetros
Fext = 0;
M = 2.7;
Aa = 6.91e-4;
Ab = 8.94e-4;
ka = 36;
R = 8.314e-5;
y = 1.4;
GuA0 = 3.2e3;
GuB0 = 3.2e3;
ta = 0.112;
tb = 0.104;
VA0 = 0.2*Aa;
VB0 = 0.2*Ab;
TA0 = 293.15;
TB0 = 293.15;
PB0 = 5.61;
PA0 = 4.97;



%% espaço de matrizes (sem efeito)

% s = tf('s');
% A = [0 1 0 0; 0 -ka/M Aa/M -Ab/M; 0 psi_A -1/ta 0; 0 psi_B 0 -1/tb]
% B = [0 0; 0 -1; GuA0*((y*R*TA0)/VA0) 0;-GuB0*((y*R*TB0)/VB0) 0]
% C = [1 0 0 0]
% D = [0 0]
% 
% ss_Y = ss(A,B,C,D);
% F = tf(ss_Y)
% Y = F(1,1)
% %rlocus(Y)

% [num den] = ss2tf(A,B,C,D,2);  
% G = tf(num,den)
% rlocus(G)
%% 
P=5e5;
Y=sim("PNEU_PID.slx")
plot(Y.Y(:,1),Y.Y(:,2))
% TF = feedback(Y,1);
% step(TF)

