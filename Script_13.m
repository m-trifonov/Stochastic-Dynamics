%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #13: Kalman filter
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 27-02-2021
%==========================================================================
clc; clear; close all;
% 1. Initial data
K_eta=eye(2,2); D_eta=900;
K_eta=D_eta*K_eta; % noise covariance
dt=5; % step time
Fi=eye(4,4); Fi(1,3)=dt; Fi(2,4)=dt; % Transition matrix
C=zeros(2,4); C(1,1)=1; C(2,2)=1; % Measurement matrix
Kx0=zeros(4,4); Kx0(1,1)=D_eta; Kx0(2,2)=D_eta; 
D_V0=25; Kx0(3,3)=D_V0;Kx0(4,4)=25;
N=8; % Number of steps for cycle
for i=1:N
    t(i)=i*dt;
    if i==1
        Papr=Fi*Kx0*Fi';
    else
        Papr=Fi*Paps*Fi'; % before observation
    end
    Sxapr(i)=sqrt(Papr(1,1));
    SVxapr(i)=sqrt(Papr(3,3)); % data for plots
    Paps=Papr-Papr*C'*inv(K_eta+C*Papr*C')*C*Papr; % after observation
    Sxaps(i)=sqrt(Paps(1,1));SVxaps(i)=sqrt(Paps(3,3)); % data for plots
end
disp(Paps);
tap=[0,t]; % time for plots including 0 
dxaps=[sqrt(D_eta),Sxaps]; 
dxapr=[0,Sxapr];
dVxaps=[sqrt(D_V0),SVxaps];
dVxapr=[0,SVxapr];
%plotting
figure(1)
grid on;hold on;
stem(tap,dxaps,':Db');
stem(tap,dxapr,'--k')
xlabel('Time (s)'); ylabel('Standard deviation of \itx \rmposition \it\sigma_x \rm(m)');
legend('\it\sigma_x \rm, apr','\it\sigma_x \rm, aps')
figure(2)
grid on;hold on;
stem(tap,dVxaps,':Db');
stem(tap,dVxapr,'--k')
xlabel('Time (s)'); ylabel('Standard deviation of speed \itV_x \rm, \it\sigma_V_x \rm(m/s)');
legend('\sigma_V_x , apr','\sigma_V_x , aps')
