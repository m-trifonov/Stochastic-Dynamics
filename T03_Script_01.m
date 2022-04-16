%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #3: Covariance function
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 10-05-2020
%==========================================================================
clc;clear;close all
% Start Simulink model
sim('T03_SimModel_01.slx')
% Initial data
dt = 0.2; % step time 
Tcor = 20; % time international interval
time = X1(:,1)'; % simulation time
X=[time; X1(:,2)']; % time series array of the stochastic process X
Xnew = iddata(X',[],0.2);
Rx = covf(Xnew,100); % Tcor/dt=60
tau=[0:dt:Tcor-dt]; % tau values
a0=[3 0.1 0.2]; % initial values of the Dx, alpha, beta
fun=@(a0,tau)(a0(1)*cos(a0(3).*tau).*exp(-a0(2)*abs(tau)));
[a,resnorm] = lsqcurvefit(fun,a0,tau,Rx(4,:))  % optimization program
% exact function
for j = 1:length(tau)  
    Rx2(1,j) = a(1)*cos(a(3).*tau(1,j)).*exp(-a(2)*abs(tau(1,j))); 
end
% plotting
figure(1);
plot(tau,Rx(4,:),'gp'),grid on; hold on 
plot(tau,Rx2),grid on;hold on
legend('\itR_X \rm(\it\tau\rm)','\itR_X_2 \rm(\it\tau\rm)');
xlabel('\tau (s)');ylabel('\itR_X \rm(\it\tau\rm), \itR_X_2 \rm(\it\tau\rm)')
