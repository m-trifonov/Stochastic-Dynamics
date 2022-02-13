%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #11: Estimation problem on a full sample in a linear system
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 11-03-2021
%==========================================================================
clc; clear; close all;
% Initial data
X0=[3000;500;10;-10]; % initial current state
Delta_1=2500; Delta_2=2500; % variance of measurement errors by coordinates X and Z
Sigma_1=sqrt(Delta_1); Sigma_2=sqrt(Delta_2); % standard deviation of measurement errors by coordinates X and Z
dt=5; % step time
Fi=eye(4,4); Fi(1,3)=dt; Fi(2,4)=dt; % transition matrix
c=zeros(2,4); c(1,1)=1; c(2,2)=1; % measurement matrix
for N = 2:10 % number of measurments
    X=X0;
    Cs=c*Fi;
    for i=1:N
        X=Fi*X;
        X_data(i,1) = X(1,1);
        X_data(i,2) = X(2,1);
        y = c*X; % formation of the ideal measurments
        % Simulation if measurment errors
        %randn('state',sum(100*clock)); % randomization of a random number generator
        Delta_z = Sigma_2*randn(1); % standard deviation of coordinate z
        Delta_x = Sigma_1*randn(1); % standard deviation of coordinate x
        eta = [Delta_x;Delta_z]; % error vector
        y_izm = y + eta; % current measurment
        Y_data(i,1) = y_izm(1);
        Y_data(i,2) = y_izm(2);
        % A full vector of measurments formation
        if i==1
            Eta = eta; Y = y; C = Cs;
        else
            Y = [Y;y]; Eta = [Eta;eta]; Y_izm = Y + Eta; C = [C;Cs];
        end
        Cs = Cs*Fi;
    end
    % Initial state estimation and covariance matrix calculation
    Xs_est = inv((C'*C))*C'*Y_izm;
    KXs_est = inv((C'*C))*Delta_1;
    Sigma_x(N) = sqrt(KXs_est(1,1));
    Sigma_Vx(N) = sqrt(KXs_est(3,3));
    % Simulation of the estimated trajectory
    X_est = Xs_est;
end

for j=1:N
    X_est=Fi*X_est;
    Xest_data(j,1)=X_est(1);
    Xest_data(j,2)=X_est(2);
end
% plotting
figure(1);hold on;
plot(X0(1),X0(2),'*R') % actual initial state
plot(X_data(:,1),X_data(:,2),'oR') % actual trajectory
plot(Y_data(:,1),Y_data(:,2),'xB') % trajectory from measurements
plot(Xs_est(1),Xs_est(2),'DK') % initial state estimation
plot(Xest_data(:,1),Xest_data(:,2),'K^') % trajectory estimation
axis ij, axis([2900 3600 0 600])%,axis equal
legend('actual initial state','actual trajectory','trajectory from measurements','initial state estimation','trajectory estimation');grid on;
xlabel('\itx \rmposition (m)');ylabel('\itz \rmposition (m)')
hold off
figure(2);
stem(Sigma_x,'k'); grid on
xlabel('Number of measurements \itN');
ylabel('Standard deviation of \itx \rmposition, \it\sigma_x \rm(m)');
figure(3);
stem(Sigma_Vx,'k'); grid on
xlabel('Number of measurements \itN');
ylabel('Standard deviation of speed \itV_x \rm, \it\sigma_V_x \rm(m/s)');

