%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #4: Spectral density
% Authors: M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 13-01-2020
%==========================================================================
clc; clear; close all;
% Input parameters
D=1; A=1; B=2;  
N=1000; OmMax=10; dom=2*OmMax/N;
% Spectral densities -> S1, S2, S3, S4
for i=1:N
    om(i)=-OmMax+(i-1)*dom;
    S1(i)=D*A/(pi*(A^2+om(i)^2));
    S2(i)=D*A*(A^2+B^2+om(i)^2)/(pi*((om(i)^2-A^2-B^2)^2+4*A^2*om(i)^2));
    S3(i)=D*(1+3*om(i)^2/A^2)/(2*pi*A*(1+om(i)^2/A^2)^2);
    S4(i)=2*D*A*(A^2+B^2)/(pi*((om(i)^2-A^2-B^2)^2+4*A^2*om(i)^2));
end
%plotting#1
figure(1)
subplot(2,2,1);plot(om,S1);grid on; hold on;title('\itSx_1(\omega)');xlabel('\omega (1/s)');
subplot(2,2,2);plot(om,S2);grid on; hold on;title('\itSx_2(\omega)');xlabel('\omega (1/s)');
subplot(2,2,3);plot(om,S3);grid on; hold on;title('\itSx_3(\omega)');xlabel('\omega (1/s)');
subplot(2,2,4);plot(om,S4);grid on; hold on;title('\itSx_4(\omega)');xlabel('\omega (1/s)');

% Typical covariance functions -> Rx1, Rx2, Rx3, Rx4
it=0;
for tau = -5:0.01:5   
    it = it + 1;
    Rx1(it,1) = D*exp(-A*abs(tau));
    Rx2(it,1) = D*cos(B*tau)*exp(-A*abs(tau));
    Rx3(it,1) = D*(1-A*abs(tau)/2)*exp(-A*abs(tau));
    Rx4(it,1) = (D*exp(-A*abs(tau)))*(cos(B*tau)+(A*sin(B*abs(tau)))/B);  
end
%plotting#2
figure(2)
subplot(2,2,1);plot(-5:0.01:5,Rx1);grid on; hold on;title('\itR_X_1(\omega)');xlabel('\tau (s)');
subplot(2,2,2);plot(-5:0.01:5,Rx2);grid on; hold on;title('\itR_X_2(\omega)');xlabel('\tau (s)');
subplot(2,2,3);plot(-5:0.01:5,Rx3);grid on; hold on;title('\itR_X_3(\omega)');xlabel('\tau (s)');
subplot(2,2,4);plot(-5:0.01:5,Rx4);grid on; hold on;title('\itR_X_4(\omega)');xlabel('\tau (s)');
