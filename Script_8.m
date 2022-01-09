%==========================================================================
% Tutorial Stochastic Dynamics with Aerospace Applications
% Topic #8: Monte-Carlo simulation
% Authors: V.Bobronnikov & M.Trifonov 
% Email: trifonov.m@yahoo.com
% Date(dd-mm-yyyy): 22-08-2021
%==========================================================================
clc; clear; close all;  
% Description of dynamic system
u=3; % input value (control)
A=2.5; % lower/upper limit of saturation
% Mathematical model of the dynamic system
W1=tf([0 2 1.5158],[1 1.02 0.575]);
W2=tf([ 0.5 1],[0.1 1]);
W3=tf([0 0.7 1],[0.75 0.35 1]);
% State-space model
[A1,B1,C1,D1]=ssdata(W1);
[A2,B2,C2,D2]=ssdata(W2);
[A3,B3,C3,D3]=ssdata(W3);
% Input data
T=10; dt=0.01; 
N=fix(T/dt);
B=sqrt(1/dt);
m=0; D=0; 
NR=300; % number of iterations
for k=1:NR
    f1=zeros(2,1); f2=0; f3=zeros(2,1);
    X1=zeros(2,1); X2=0; X3=zeros(2,1);
    y1=0; y2=0; y3=0;
    for i=1:N 
        u1=B*randn(1); 
        u2=u+y1-0.5*y3; 
        if  abs(y2)<A 
            u3=y2; 
        else 
            u3=A*sign(y2);
        end 
        %the right-hand-side of a dynamic system
        f1=A1*X1+B1*u1;
        f2=A2*X2+B2*u2;
        f3=A3*X3+B3*u3;
        % Integration of equations using Euler's method
        X1=X1+f1*dt;
        X2=X2+f2*dt;
        X3=X3+f3*dt;
        % Output vectors
        y1=C1*X1+D1*u1;
        y2=C2*X2+D2*u2;
        y3=C3*X3+D3*u3;
        om(i)=y3; l(i)=i; 
        data_u3(i)=u3;
    end
%     figure(1);plot(l*dt,om),grid 
%     figure(4);plot(l*dt,data_u3,'r'),grid on,hold on
    %Mean
    m=((k-1)*m+y3)/k;
    %Variance
    D=(D*(k-1)+(y3-m)^2)/k; 
    q(k)=k; M(k)=m; DD(k)=D; 
end
%plotting
figure(1)  %subplot for last iteration
subplot(2,1,1);plot(l*dt,om,'b',LineWidth=1);grid on;
legend('\omega');
xlabel('Time (s)');ylabel('Rate of angular motion (grad/s)');
subplot(2,1,2);plot(l*dt,data_u3,'r',LineWidth=1);grid on;
legend('\delta');
xlabel('Time (s)');ylabel('Control surface angle (grad)');
figure(2);
plot(q,M,'b',q,DD,'g',LineWidth=1);grid on; 
legend('m_\omega, (grad/s)','D_\omega, (grad/s)^2');
xlabel('Number of iterations'); ylabel('Rate of angular motion (grad/s), (grad/s)^2');
