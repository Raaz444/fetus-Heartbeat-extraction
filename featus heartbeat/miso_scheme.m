%%%clearing commands%%%
clc;
clear all;
close all;
%%%loading the input signal%%%
load foetal_ecg.dat
S=foetal_ecg; % source signal
Fs=500;       % sampling Frequency
t=S(:,1);     % Time sample
d=(sum(S(:,2:6)'))/5;  %%%Abdominal signals Fetus
x=S(:,7:9);%Thoracic signals Mother sig
mu=0.0000001; %step size
gama=0.001;%leakge coefficient
beta=0.04;%normalized step size
p=15;%order of filter

%%
%%%%plotting the input signal%%%%%%
figure
 subplot(2,1,1)
 plot(t,d,'k');
 title('mother+fetus signal');
 xlabel('time(sec)')
 ylabel('amplitude(mV)');

 %%%plotting of reference signal%%%
subplot(2,1,2)
plot(t,x,'r');
title('mother signal signal');
xlabel('time(sec)')
ylabel('amplitude(mV)');


% %  LMS algorithm % % 
 for i=1:3
X(:,:,i)=convm(x(:,i),p);
end
[M,N,L]=size(X);
a0 = zeros(1,N);%zero padding
c1=X(:,:,1);%input
c2=X(:,:,2);%input
c3=X(:,:,3);%input
Yl=a0*c1(1,:)'+a0*c2(1,:)'+a0*c3(1,:)';
El(1)=d(1)-Yl(1); %error
Al(1,:) = a0 + mu*El(1)*(conj(c1(1,:)+conj(c2(1,:))+conj(c3(1,:))));

for k=2:M-p+1;
       
        ss=Al(k-1,:)*c1(k,:)'+Al(k-1,:)*c2(k,:)'+Al(k-1,:)*c3(k,:)';
        Yl(k)=ss;
        El(k) = d(k) - Yl(k);
        Al(k,:)=Al(k-1,:)+mu*El(k)*(conj(c1(k,:)+conj(c2(k,:))+conj(c3(k,:))));
     
end


 % % NLMS algorithm % % 
 for i=1:3
X(:,:,i)=convm(x(:,i),p);
end
[M,N,L]=size(X);
a0 = zeros(1,N);%zero padding
c1=X(:,:,1);%input
c2=X(:,:,2);%input
c3=X(:,:,3);%input
Yn(1)=a0*c1(1,:)'+a0*c2(1,:)'+a0*c3(1,:)'%output 
En(1)=d(1)-Yn(1); %error

DEN=(c1(1,:)*c1(1,:)'+c2(1,:)*c2(1,:)'+c3(1,:)*c3(1,:)')+0.0001;

An(1,:) = a0 + beta/DEN*En(1)*(conj(c1(1,:)+conj(c2(1,:))+conj(c3(1,:))));

for k=2:M-p+1;
        
        ss=An(k-1,:)*c1(k,:)'+An(k-1,:)*c2(k,:)'+An(k-1,:)*c3(k,:)';
        Yn(k)=ss;
        En(k) = d(k) - Yn(k);
        DEN=(c1(k,:)*c1(k,:)'+c2(k,:)*c2(k,:)'+c3(k,:)*c3(k,:)')+0.0001;
        An(k,:)=An(k-1,:)+beta/DEN*En(k)*(conj(c1(k,:)+conj(c2(k,:))+conj(c3(k,:))));
     
end

% %  LLMS algorithm % % %
 for i=1:3
X(:,:,i)=convm(x(:,i),p);
end
[M,N,L]=size(X);
a0 = zeros(1,N);%zero padding
c1=X(:,:,1);%input
c2=X(:,:,2);%input
c3=X(:,:,3);%input
Yll(1)=a0*c1(1,:)'+a0*c2(1,:)'+a0*c3(1,:)';%output
Ell(1)=d(1)-Yll(1); %error
All(1,:) = (1-mu*gama)*a0 + mu*Ell(1)*(conj(c1(1,:)+conj(c2(1,:))+conj(c3(1,:))));%update equation
for k=2:M-p+1;
        
        ss=All(k-1,:)*c1(k,:)'+All(k-1,:)*c2(k,:)'+All(k-1,:)*c3(k,:)';
        Yll(k)=ss;
        Ell(k) = d(k) - Yll(k);
        All(k,:)=(1-mu*gama)*All(k-1,:)+mu*Ell(k)*(conj(c1(k,:)+conj(c2(k,:))+conj(c3(k,:))));
     
end

%%
%plotting the lms,nlms & llms output for miso%
figure
plot(t,El,'r-',t,En,'b--',t,Ell,'g--')
title('plot of the LMS,NLMS&LLMS output(fetus signal)');
legend('MISO-LMS','MISO-NLMS','MISO-LLMS');
xlabel('time(sec)');
ylabel('amplitude(mV)');
axis([0 5 -30 30]);

%%
%plotting of filtered signal in miso lms,nlms & llms%
figure
plot(t,Yl,'r-',t,Yn,'b--',t,Yll,'g--');
legend('MISO-LMS','MISO-NLMS','MISO-LLMS');
title('Plot of the filter output');
ylabel('amplitude(mV)');
xlabel('time(sec)');
axis([0 5 -20 20]);