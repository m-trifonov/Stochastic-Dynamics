%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #12: Formation of a normalized vector of the estimation errors
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 10-03-2021
%==========================================================================
function dY=T12_Script_02(Xs0)
% function "Program_est"
global  phi Y_izm N  w 
Xs=Xs0; % initial state
for j=1:N % cycle on the measurements
    Xs=phi*Xs; % the state in one step
    ys=Program_cal(Xs); % the measurement in one syep
    if j==1 % first measurement
        Ys=ys;
        W=w;
    else % other measurements
        Ys=[Ys;ys];
        W=[W;w];
    end
end
ddY=Y_izm-Ys;
dY=ddY.*W;
end

% Calculation of the estimation vector
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