%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #9: Moment's equations
% Authors: V.Bobronnikov & M.Trifonov
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 22-08-2021
%==========================================================================
clc;clear;close all;
% Mathematical model of the dynamic system
W1=tf([0 2 1.5158],[1 1.02 0.575]);
W2=tf([ 0.5 1],[0.1 1]);
W3=tf([0 0.7 1],[0.75 0.35 1]);
Kos=0.5;u=3; Neta=1;
Wu=feedback(W2*W3,Kos);
Weta=W1*Wu;
% State-space model (LTI array)
[Au,Bu,Cu,Du]=ssdata(Wu);
[Aeta,Beta,Ceta,Deta]=ssdata(Weta);
% Input data for simulation
T=10; dt=0.01; Nt=fix(T/dt);
mx=zeros(3,1);Kx=zeros(5,5);
% Integration of moment's equations using Euler's method
for i=1:Nt
    t(i)=(i-1)*dt; 
    mx=mx+(Au*mx+Bu*u)*dt;
    Kx=Kx+(Aeta*Kx+Kx*Aeta'+Beta*Neta*Beta')*dt; 
    %Mean
    my(i)=Cu*mx+Du*u;
    %Variance
    Dy(i)=Ceta*Kx*Ceta';
end
% plotting
figure(1)
grid on; hold on;
plot(t,my,'b',t,Dy,'g',LineWidth=1);
legend('m_\omega, (grad/s)','D_\omega, (grad/s)^2');
xlabel('Time (s)'); ylabel('Rate of angular motion (grad/s), (grad/s)^2');
figure(2); 
grid on; hold on;
plot(t,my,'b',t,my+3*sqrt(Dy),'g',t,my-3*sqrt(Dy),'g',LineWidth=1); 
legend('m_\omega','m_\omega \pm 3\sigma_\omega');
xlabel('Time (s)'); ylabel('Rate of angular motion (grad/s)');


