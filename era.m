function [A,B,C,D,H]=era(H,p,q)
%
% ***************           era.m           ********************
% ______________________________________________________________
% ****    Version March 7. 1995, Marco Schoen       ************
%
% realize A,B,C,D matrices from markov parameters using ERA
% [A,B,C,D]=era(Y,p,q)
% q=order of ARX model
% Y=mx(pxn) markov parameters matrix
% m=number of outputs; p=number of inputs; n=number of Markov parameters
Y=H;
[m,n]=size(Y);
D=Y(:,1:p);
Y=Y(:,p+1:n);
n=n/p-1;
%r=fix(n/2);
r=fix(n/(m/p+1));
%r=q;
s=n-r;
mr=m*r;ps=p*s;
H1=zeros(mr,ps);H2=H1;
for i=1:r
  for j=1:s
    mi=m*(i-1);
    pj=p*(j-1);
    pij=p*(i+j-2);
    H1(mi+1:mi+m,pj+1:pj+p)=Y(:,pij+1:pij+p);
    H2(mi+1:mi+m,pj+1:pj+p)=Y(:,pij+p+1:pij+2*p);
  end;
end;
[U,S,V]=svd(H1);
%figure(4)
subplot(2,2,4)
semilogy(diag(S),'*')
grid;
%keyboard;
title(' singular values ')
%disp(S(10,10)/S(11,11));
input('number of states of realized system (Suggested value=15): ');n=ans;
S=S(1:n,1:n);
S=sqrt(S);
SI=inv(S);
U=U(:,1:n);
V=V(:,1:n);
A=SI*U'*H2*V*SI;
B=S*V'*[eye(p);zeros(ps-p,p)];
C=[eye(m),zeros(m,mr-m)]*U*S;
%input('now it should be at the end ');quatsch=ans;


