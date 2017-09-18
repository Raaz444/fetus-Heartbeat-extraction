%%%clearing commands%%%
clc;
clear all; 
close all;

% %%%loading the input signal%%%
load  foetal_ecg.dat
S= foetal_ecg; % source signal
Fs=500;       % sampling Frequency
t=S(:,1);     % Time samples
% 
% 
% %%%PLOTTING INPUT SIGNALS%%%%
 figure
 d1=S(:,2);  %%%Abdominal signal 1
subplot(3,1,1);
plot(t,d1);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Abdominal signal 1');
d2=S(:,3);  %%%Abdominal signal 2
subplot(3,1,2);
plot(t,d2);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Abdominal signal 2');
d3=S(:,4);  %%%Abdominal signal 3
subplot(3,1,3);
plot(t,d3);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Abdominal signal 3');
d4=S(:,5);  %%%Abdominal signal 4 
figure
subplot(2,1,1);
plot(t,d4);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Abdominal signal 4');
d5=S(:,6);  %%%Abdominal signal 5
subplot(2,1,2);
plot(t,d5);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Abdominal signal 5');

figure
x1=S(:,7);  %Thoracic signal 1
subplot(3,1,1);
plot(t,x1);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Thoracic signal 1');
x2=S(:,8);  %Thoracic signal 2
subplot(3,1,2);
plot(t,x2);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Thoracic signal 2');
x3=S(:,9);  %Thoracic signal 3
subplot(3,1,3);
plot(t,x3);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('Thoracic signal 3');

d=(d1+d2+d3+d4+d5)/5; %%% AVERAGE OF ABDOMINAL SIGNALS
x=(x1+x2+x3)/3;  %%% AVERAGE OF THORACIC SIGNALS

figure
subplot(2,1,1);
plot(t,d);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('average of abdominal signals(Mother+Fetus)');
subplot(2,1,2);
plot(t,x);
xlabel('time period(sec)');
ylabel('amplitude(mV)');
title('average of Thoracic signals(Mother)');
%%
% Generating ANC using LMS Algorithm
p=15;%order of filter
mu=0.0000007;   % Step size
[A1,L,yl]=lms(x,d,mu,p);%calling LMS function

%%
% Generating ANC using NLMS Algorithm
beta=0.04;%normalized step size
p=15;%order of filter
[A,LN,yn]=nlms(x,d,beta,p);%calling NLMS function

%%
% Generating ANC using LLMS Algorithm
gama= 0.001;%leakage coefficient
p=15;%order of filter
mu=0.0000007;   % Step size
[AL,LL,yll]= llms(x,d,mu,gama,p);%calling LLMS function

%%
%%%plotting of lms signal%%%%
figure
plot(t,L,'c-',t,LN,'b--',t,LL,'m--');
legend('SISO-LMS','SISO-NLMS','SISO-LLMS');
title('Plot of the LMS,NLMS,LLMS & RLS output(fetus signal) ');
ylabel('amplitude(mV)');
xlabel('time(SEC)');
axis([0 5 -30 30]);

%%
%%%plotting of filtered signal of lms in siso%%%
figure
plot(t,yl,'r-',t,yn,'b--',t,yll,'g--');
legend('SISO-LMS','SISO-NLMS','SISO-LLMS');
title('Plot of the filter output');
ylabel('amplitude(mV)');
xlabel('time(SEC)');
axis([0 5 -20 20]);