%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #4: Power spectral density estimate using the Fourier transformation
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 14-01-2020
%==========================================================================
clc; clear; close all;
% Input data
T=1000;df=1/T; % Length of sample, frequency interval
dt=0.2;Fmax=1/dt; % Step time, maximum spectrum frequency
f=-Fmax:df:Fmax; % Frequency range of spectrum plotting

% Start simulink model
sim('SimModel_3');

% Fourier transformation for positive frequencies
s=fft(X1(:,2)); 
S=fftshift(s);  
a=abs(S);
a=[a',1]; % transform to column vector
% plotting
figure(1); grid on; hold on
plot(f*6.28,a(1:10001)*df)
title('Spectral density of the process realization');
xlabel('Frequence (rad/s)');ylabel('Spectrum');