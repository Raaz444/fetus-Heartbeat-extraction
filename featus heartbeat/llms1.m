function [W,W1,W2,E,y] = llms1(X,X1,X2,d,mu,gammax,nord,a0)
[M,N] = size(X);
[M1,N1] = size(X1);
[M2,N2] = size(X2);
if nargin < 8, a0 = zeros(1,N);
end
a0 = a0(:).';
y1= zeros(1,M);
y2= zeros(1,M1);
y3= zeros(1,M2);
E=zeros(1,M);
E1=zeros(1,M1);
E2=zeros(1,M2);
W=zeros(size(X));
W1=zeros(size(X1));
W2=zeros(size(X2));
y1(1)= a0*X(1,:).';
y2(1)= a0*X1(1,:).';
y3(1)= a0*X2(1,:).';
E(1) = d(1) - a0*X(1,:).';

W(1,:) = (1-mu*gammax)*a0 + mu*E(1)*conj(X(1,:));
W1(1,:) = (1-mu*gammax)*a0 + mu*E(1)*conj(X1(1,:));
W2(1,:) = (1-mu*gammax)*a0 + mu*E(1)*conj(X2(1,:));
if M>1
for k=2:M-nord+1;
y1(k) = W(k-1,:)*X(k,:).';
y2(k) = W1(k-1,:)*X1(k,:).';
y3(k) = W2(k-1,:)*X2(k,:).';
y(k)=(y1(k)+y2(k)+y3(k))/3;
E(k) = d(k) - y(k);
W(k,:) = (1-mu*gammax)*W(k-1,:) + mu*E(k)*conj(X(k,:));
W1(k,:) = (1-mu*gammax)*W1(k-1,:) + mu*E(k)*conj(X1(k,:));
W2(k,:) = (1-mu*gammax)*W2(k-1,:) + mu*E(k)*conj(X2(k,:));
end;
end;
