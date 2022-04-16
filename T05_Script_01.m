%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #5: Frequency domain analysis of LTI systems (spectral densities)
% Authors: V.Bobronnikov & M.Trifonov
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 22-08-2021
%==========================================================================
clc; clear; close all;
% mathematical model of the dynamic system
Wkf=tf([0.5 1],[0.1 1]);
Wrp=1;
Wla=tf([0.7 1],[0.25 0.3 1]);
Wdus=0.5;
% transfer function of the system
Wz=feedback(Wkf*Wrp*Wla,Wdus);
u=3; D=3.9033; alfa=0.5091; beta=0.5615;
% calculation of a low-frequency gain
mom=dcgain(Wz)*u
% max frequency and step frequency
ommax=25; N=200; dom=ommax/N;
% covar() - covariance of response to ! WHITE noise
for i=1:N
    om(i)=(i-1+0.00001)*dom;
    % calculation of a magnitude and phase data
    [A(i),fi]=bode(Wz,om(i));
    Akv(i)=A(i)^2;
    %input-output relations in the frequency domain: spectral densities
    Sksi(i)=D*alfa*(alfa^2+beta^2+om(i)^2)/pi/...
        ((om(i)^2-alfa^2-beta^2)^2+4*alfa^2*om(i)^2);
    Sy(i)=2*Sksi(i)*Akv(i);
end
% calculation variance of the system output using Riemann sum
Dy=sum(Sy)*dom
% plotting
figure(1);plot(om,Sksi);grid on;
figure(1);xlabel('\omega (1/s)');ylabel('S_\xi'); 
figure(2);
subplot(2,1,1);plot(om,A);grid on;
xlabel('\omega (1/s)');ylabel('A(\omega)');
subplot(2,1,2);plot(om,Sy);grid on;
xlabel('\omega (1/s)');ylabel('S_y(\omega)');

