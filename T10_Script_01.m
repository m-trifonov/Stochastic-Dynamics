%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #10: Calculation the covariance matrix of state estimation errors
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 28-07-2021
%==========================================================================
clear;clc;close all
% Initial data
Sigma=900;   % Variance of the (x,z) position
dt=5; % time step
Fi=eye(4,4); Fi(1,3)=dt; Fi(2,4)=dt; % transfer matrix
c=zeros(2,4); c(1,1)=1; c(2,2)=1; % measurments matrix
% Cycle on N
for N=2:10
     % Full matrix of measurments formation
    Cs=c*Fi;
    for i=1:N
        if i==1
            C=Cs;
        else
            C=[C;Cs];
        end
        Cs=Cs*Fi; 
    end
    % Calculation of the covariance matrix ошибок оценки начального состояния
    KXs_est=inv((C'*C))*Sigma
    Sigma_x(N)=sqrt(KXs_est(1,1));
    Sigma_Vx(N)=sqrt(KXs_est(3,3));
end
% plotting
figure(1); grid on
subplot(2,1,1);stem(Sigma_x,'k'); grid on
subplot(2,1,1);xlabel('Number of measurements \itN');
subplot(2,1,1);ylabel('\it\sigma_x \rm(m)');
subplot(2,1,2);stem(Sigma_Vx,'k'); grid on
subplot(2,1,2);xlabel('Number of measurements \itN');
subplot(2,1,2);ylabel('\it\sigma_V_x \rm(m/s)');