function th=arx_bat(y,u,q,d,uf)
% identify parameters of ARX model using least square in batch
% [th]=arx_bat(y,u,q,d,uf)
% y(k+1)=sum(a(i)y(k-i))+sum(b(i)u(k-i)),i=0,1,...,q
% q=order of arx model
% y=noxk of output data; u=nixk of input data;
% N=number of data points; no=nimber of outputs; ni=number of inputs
% th=[b(0) a(0) b(1) a(1) ... b(q) a(q)]
[no,N]=size(y);[ni,N]=size(u);p=no+ni;
if d==1
  phi=zeros(p*q+ni,N);phi(1:ni,:)=u;n=ni;
else
  phi=zeros(p*q,N);n=0;
end;
for i=1:q
  np=n+p;
  phi(n+1:np,i+1:N)=[u(:,1:N-i);y(:,1:N-i)];
  n=np;
end;
if exist('uf')==1
  yuf=[y;uf];
else
  yuf=y;
end;  
th=yuf(:,q:N)/phi(:,q:N);
[m,n]=size(th);
if d==1
  th=[th(:,1:ni) zeros(m,no) th(:,ni+1:n)];
else  
  th=[zeros(m,p) th];
end;
