%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #4: Periodogram & Welch power spectral density estimate
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 14-10-2021
%==========================================================================
clc; clear; close all
% Analyzed dynamical systems
W_d=tf([0.3878 -0.3366],[1 -1.801 0.8187],0.2)
Wc_new=tf([2 1.414],[1 1 0.5])

% plotting#1
figure(1);hold on
step(W_d);
W_c=d2c(W_d)
step(W_c)
figure(2);hold on
step (Wc_new)
Wd_new=c2d(Wc_new,0.1)
step (Wd_new)

% Start simulink model
sim('SimModel_3')

%plotting#2
figure(3)
periodogram(X1(:,2),[],[],1)
figure(4)
pwelch(X1(:,2),[],[],[],1)

% Covariance function
% R_X1=covf(X1(:,2),200)
% Rx_tau=R_X1(1:5:200);
% tau=[1:5:200]
% figure(5)
% plot(tau/10,Rx_tau)
