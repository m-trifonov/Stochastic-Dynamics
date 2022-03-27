%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #12: Estimation problem on a full sample in a non-linear system 
% using the least square method
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 10-03-2021
%==========================================================================
clc;clear;close all
%  Input data
global phi Y_izm  N  w
X0=[3000;500;10;-10]; % actual initial state
% Variations of the measurements errors of the r, phi, Vr
Delta(1)=1600; Delta(2)=0.002; Delta(3)=1; 
w(1,1)=1/sqrt(Delta(1)); w(2,1)=1/sqrt(Delta(2)); w(3,1)=1/sqrt(Delta(3)); % weight parameters
dt=5; % step of measurements
phi=eye(4,4); phi(1,3)=dt; phi(2,4)=dt; % transfer matrix
N=8; % number of measurements
% Cycle of the realizations
% for k=1:10
%  simulation of the full vector measurements
X=X0; % initial state in the realization
% Cycle on the measurements
for i=1:N
X=phi*X; % re-calculation of the state
X_data(i,1)=X(1);X_data(i,2)=X(2);
y=Program_cal(X); % calculation of the estimate vector (without noise)
% Formation of the vector  of the mesurements errors
deltar=sqrt(Delta(1))*randn(1); % delta r
deltafi=sqrt(Delta(2))*randn(1); % delta fi, rad
deltaVd=sqrt(Delta(3))*randn(1); % delta Vdop
eta=[deltar;deltafi;deltaVd]; % errors vector

y_izm=y+eta; % Measurements wirh erreor (noise)
X_izm(1)=y_izm(1)*cos(y_izm(2));
X_izm(2)=-y_izm(1)*sin(y_izm(2));
Y_data(i,1)=X_izm(1);Y_data(i,2)=X_izm(2);
% Measurements assembly in the vector Y
if i == 1
    Y_izm = y_izm;
else
    Y_izm = [Y_izm;y_izm]; % Full measurements vector
end % if
end % for i
%  Formation of the initial state - Xs0 for optimization
Xs_1(1,1)= Y_izm(1)*cos(Y_izm(2));  % x0
Xs_1(2,1)=-Y_izm(1)*sin(Y_izm(2)); % z0
Xs_1(3,1)= Y_izm(3)*cos(Y_izm(2)); % Vx0
Xs_1(4,1)=-Y_izm(3)*sin(Y_izm(2)); % Vz0
Xs0=inv(phi)*Xs_1; % initial state for estimation
%  Optimization of the initial state - Xs_est 
[Xs_est,resnorm]=lsqnonlin('T12_Script_02',Xs0);
options=optimset('lsqnonlin');
optnew = optimset(options,'MaxIter',1000,'MaxFunEval',1000);
X_e=Xs_est;
% for plotting of the estimated trajectory
for i=1:N
X_e=phi*X_e; % re-calculation of srate estimation
Xe_data(i,1)=X_e(1);Xe_data(i,2)=X_e(2);
end
%plotting
figure(1);hold on
plot(X0(1),X0(2),'*r'),grid on  % actual initial position
axis ij, axis([2900 3500 -500 800])
plot(X_data(:,1),X_data(:,2),'oR') % actual current position
plot(Y_data(:,1),Y_data(:,2),'xB'); % measurement points
plot(Xs_est(1),Xs_est(2),'DK') % estimation of the initial state
plot(Xe_data(:,1),Xe_data(:,2),'k^') % trajectory estimation
legend('actual initial state','actual trajectory','trajectory from measurements','initial state estimation','trajectory estimation');
xlabel('\itx \rmposition (m)');ylabel('\itz \rmposition (m)');

% Calculation of the estimate vector
function y=Program_cal(X)
% X(1,1)=x; X(2,1)=z; X(3,1)=Vx; X(4,1)=Vz;
% y(1,1)=r; y(2,1)=fi; y(3,1)=Vr;
r=sqrt(X(1,1)^2+X(2,1)^2); % r
Sphi=-X(2,1)/r; % sin phi
Cphi=X(1,1)/r; % cos phi
if Cphi>=0
    phi=asin(Sphi);
else
    phi=pi*sign(asin(Sphi))-asin(Sphi);
end 
V=sqrt(X(3,1)^2+X(4,1)^2);
Spsi=-X(4,1)/V;
Cpsi=X(3,1)/V;
if Cpsi>=0
    psi=asin(Spsi);
else
    psi=pi*sign(asin(Spsi))-asin(Spsi);
end % psi
Vr = V*cos(phi-psi);
y(1,1)=r;
y(2,1)=phi;
y(3,1)=Vr;
end

