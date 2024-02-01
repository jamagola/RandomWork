function K=kalman(A,C,Y,n)
% [K]=kalman(A,C,Y,n) Calculate Kalman filter gain 
% th=[b(0) a(1) b(1) ... a(q) b(q)];
% q=order of ARX model
% n=number of Kalman Markov parameters
% K=Kalman filter gain matrix
% C=output matrix
% A=system matrix
[no,n2]=size(Y);[m,m]=size(A);n2no=n2-no;O=zeros(n2no,m);N=zeros(n2no,no);
Ak=eye(m);
for i=1:n
  ii=(i-1)*no;ii1=ii+1;iino=ii+no;
  O(ii1:iino,:)=C*Ak;
  Ak=A*Ak;
  N(ii1:iino,:)=Y(:,iino+1:iino+no);
end;
K=O\N