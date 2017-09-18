% MATLAB code for MISO system
clc;
clear all;
close all;
load('foetal_ecg.dat');
x=foetal_ecg;
% time signal;
timesig=x(:,1);
% abdnomial signals
abdomin1=x(:,2);
abdomin2=x(:,3);
abdomin3=x(:,4);
abdomin4=x(:,5);
abdomin5=x(:,6);
%thoriad signals
thoirad1=x(:,7);
thoirad2=x(:,8);
thoirad3=x(:,9);
figure
subplot(5,1,1);
plot(timesig,abdomin1);
title('abdomin1');
xlabel('time[s]');
ylabel('amplitude mV');
subplot(5,1,2);
plot(timesig,abdomin2);
title('abdomin2');
ylabel('amplitude mV');
xlabel('time');
subplot(5,1,3);
plot(timesig,abdomin3);
title('abdomin3');
xlabel('time');
ylabel('amplitude mV');

subplot(5,1,4);
plot(timesig,abdomin4);
title('abdomin4');
xlabel('time');
ylabel('amplitude mV');
subplot(5,1,5);
plot(timesig,abdomin5);
title('abdomin5');
xlabel('time');
ylabel('amplitude mV');
figure
subplot(3,1,1);
plot(timesig,thoirad1,'r');
title('thoirad1');
xlabel('time');
ylabel('amplitude mV');
subplot(3,1,2);
plot(timesig,thoirad2,'r');
title('thoirad2');
xlabel('time');
ylabel('amplitude mV');
subplot(3,1,3);
plot(timesig,thoirad3,'r');
title('thoirad3');
xlabel('time');
ylabel('amplitude mV');
d=(abdomin1+abdomin2+abdomin3+abdomin4+abdomin5)/5;
a=thoirad1;
a1=thoirad2;
a2=thoirad3;
%% Applying for LMS Algorithm
mue= 0.00000002;
nord=12;
X=convm(a,nord);
X1=convm(a1,nord);
X2=convm(a2,nord);
%Applying LMS algorithm using lms basic function.
[A,A1,A2,E1,y1] = lms1(X,X1,X2,d,mue,nord);

%% Applying for NLMS Algorithm
beta=0.005;
nord=12;
X=convm(a,nord);
X1=convm(a1,nord);
X2=convm(a2,nord);
%Applying NLMS algorithm using lms basic function.
[A,A1,A2,E2,y2] = nlms1(X,X1,X2,d,beta,nord);
%% Applying for LLMS Algorithm
mu=0.0000002;
gammax=0.001;
nord=12;
X=convm(a,nord);
X1=convm(a1,nord);
X2=convm(a2,nord);
%Applying LMS algorithm using llms basic function.
[W,W1,W2,E3,y3] = llms1(X,X1,X2,d,mu,gammax,nord);
%% Plotting signals
% Fetus+mothers signal
figure
subplot(2,1,1)
plot(timesig,d(1:2500),'r-');
hold on;
plot(timesig,d(1:2500),'k--');
hold on;
plot(timesig,d(1:2500),'b:');
hold on;
title('Fetus + Mothers output');
xlabel('time[sec]');
ylabel('Amplitude [mV]');
legend('MISO-LMS','MISO-NLMS','MISO-LLMS')
%% Mothers signal
subplot(2,1,2)
plot(timesig,a(1:2500),'r-');
hold on;
plot(timesig,a(1:2500),'k--');
hold on;
plot(timesig,a(1:2500),'b:');

hold on;
title('Mothers ECG for MISO');
xlabel('time[sec]');
ylabel('Amplitude [mV]');
legend('MISO-LMS','MISO-NLMS','MISO-LLMS');
%% Filter output
figure
subplot(2,1,1)
plot(timesig,y1(1:2500),'r-');
hold on;
plot(timesig,y2(1:2500),'k--');
hold on;
plot(timesig,y3(1:2500),'b:');
hold on;
title('filter output');
xlabel('time[sec]');
ylabel('Amplitude [mV]');
%axis([0 1 -10 10])
legend('MISO-LMS','MISO-NLMS','MISO-LLMS')
%% Fetus signal
subplot(2,1,2)
plot(timesig,E1(1:2500),'r-');
hold on;
plot(timesig,E2(1:2500),'k--');
hold on;
plot(timesig,E3(1:2500),'b:');
hold on;
title('Fetus Output for MISO');
xlabel('time[sec]');
ylabel('Amplitude [mV]');
%axis([0 1 -10 10])
legend('MISO-LMS','MISO-NLMS','MISO-LLMS')
