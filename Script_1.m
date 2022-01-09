%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #1: Simulation of a three-dimensional Gaussian vector
% Authors: V.Bobronnikov & M.Trifonov
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 22-08-2021
%==========================================================================
clc; clear; close all;
% Initial data (mean My & covariance Ky)
My = [1;2;3]; Ky = [6 2 3;2 3 1;3 1 9]; 
A = zeros(3); % formation of the matrix A
% Calculation of the matrix A
A(1,1) = sqrt(Ky(1,1)); 
A(2,1) = Ky(1,2)/A(1,1);
A(2,2) = sqrt(Ky(2,2)-A(2,1)^2);
A(3,1) = Ky(1,3)/A(1,1);
A(3,2) = (Ky(2,3)-A(2,1)*A(3,1))/A(2,2);
A(3,3) = sqrt(Ky(3,3)-A(3,1)^2-A(3,2)^2);
X = normrnd(0,1,3,1) % simulation of the random process X 
Y = My+A*X  % linear transformation of the X-realization
