function[y,r,TS,pn,mn,x]=generate(L)
% 			         	  generate.m
% 			      	Dr. Marco P. Schoen
%						    July 4, 2001
% _______________________________________________________
% 
% Generate input/output data for IDSI of a SISO system
% system is the human respiratory system
% 
% _______________________________________________________

% System:
Ac=[0 11;-1.8861 -11.826145];Bc=[0;760];C=[1 0];D=[0];
input('Sampling time TS: ');
TS=ans;
[A,B]=c2d(Ac,Bc,TS);
% Additive measurement and process noise
[n2,ni]=size(B);[no,n2]=size(C);
X=dlyap(A,B*B');M=sqrt(diag(C*X*C'+D*D'));X=sqrt(diag(X));
disp('Eigenvalues of true system:'),eig(Ac)
nd=L;
input('noise yes <0>, no <1> :');Noise=ans;
x=zeros(n2,1);u=zeros(ni,nd);y=zeros(no,nd);
nd2=nd/2;zero=zeros(ni,1);

if Noise ==0
  input('standard deviation ratio of process noise [.01] =');pn=ans*X;
  input('standard deviation ratio of measurement noise [.01] =');mn=ans*M;
    for i=1:nd
    u(:,i)=randn(ni,1);
    y(:,i)=C*x+D*u(:,i)+randn(no,1).*mn;
    x=A*x+B*u(:,i)+randn(n2,1).*pn;
  end;
  mar=1:1:nd;
  figure(1)
  subplot(2,2,1);plot(mar,y,'.');grid;xlabel('k');ylabel('y');
  subplot(2,2,2);plot(mar,u,'.');grid;xlabel('k');ylabel('u');
  r=u;
else
   pn=0;mn=0;
  for i=1:nd
    u(:,i)=randn(ni,1);
    y(:,i)=C*x+D*u(:,i);
    x=A*x+B*u(:,i);
  end;
  mar=1:1:nd;
  figure(1)
  subplot(2,2,1);plot(mar,y,'.');grid;xlabel('k');ylabel('y');
  subplot(2,2,2);plot(mar,u,'.');grid;xlabel('k');ylabel('u');
  r=u;
end;
input('save data file? yes <1>, no <0> :');sa=ans;
if sa==1
   save data.mat y u TS pn mn x A B C D L
end;
