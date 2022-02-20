%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #6: Shaping filters
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 13-07-2020
%==========================================================================
clc; clear; close all
% Case study, initial data
Wkf = tf([0.5 1],[0.1 1]); % filter
Wrp = 1; % actuator
Wla = tf([0.7 1],[0.25 0.3 1]); % UAV dynamics
Wdus = 0.5; % Rate gyroscope
% Transfer Fcn of the system
Wz = feedback(Wkf*Wrp*Wla,Wdus);
% Parameter of the shaping filter
D = 3.9033; alfa = 0.5091; beta = 0.5615;
% Transfer Fcn of the shaping filter
Wff = tf([sqrt(2*alfa*D)  sqrt(2*alfa*D)*sqrt(alfa^2+beta^2)],...
    [1 2*alfa alfa^2+beta^2]);
% Start Simulink model
sim('SimModel_6.slx');
% Transfer Fcn of the augmented system
Wrs = Wz*Wff;
% Frequency domain analysis
Dy = covar(Wrs,1)
% Plotting
figure(1)
subplot(2,1,1);plot(tout,X1);grid on
xlabel('\ittime \rm(\its\rm)');ylabel('\itX\rm(\itt\rm)');
subplot(2,1,2);plot(tout,X1_color);grid on
xlabel('\ittime \rm(\its\rm)');ylabel('\itX_c\rm(\itt\rm)');

