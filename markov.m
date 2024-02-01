function Y=markov(y1,y2,eq,n,y3)
% Y=markov(y1,y2,eq,q,n,no,ni,y3)=y1(k)+sum{y2(i)Y(k-i),1,...,k-eq},k=1,...,n;
%            or if y3 exists,   Y=y1(k)+sum{y2(i)y3(k-i),1,...,k-eq},k=1,...,n;
% extract Markov parameters from arx model parameters
% Y=nox(nixn) Markov parameters matrix
% no=number of outputs; ni=number of inputs
% n=number of Markov parameters
[no,ni]=size(y1);Y=zeros(no,ni);n1=n+1;ni=ni/n1;
if exist('y3')==0
  Y(:,1:ni)=y1(:,1:ni);
  for k=1:n
    kk=k*ni;h=y1(:,kk+1:kk+ni);k1=k-eq;
    for i=1:k1
      ii=i*no;ki=(k-i)*ni;
      h=h+y2(:,ii+1:ii+no)*Y(:,ki+1:ki+ni);
    end;Y(:,kk+1:kk+ni)=h;
  end;
%CLY=Y;
else
  [no,ni]=size(y3);ni=ni/n1;
  for k=1:n
    kk=k*ni;h=y1(:,kk+1:kk+ni);k1=k-eq;
    for i=1:k1
      ii=i*no;ki=(k-i)*ni;
      h=h+y2(:,ii+1:ii+no)*y3(:,ki+1:ki+ni);
    end;Y(:,kk+1:kk+ni)=h;
  end;
end;