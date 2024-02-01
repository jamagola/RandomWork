% *********              okid.m               ***********
% __________________________________________________________
% ****     Version July 31. 2004, Marco Schoen       ****
% __________________________________________________________
% Using okid.m to identify system using random white,
% gaussian input to the system. 
% Identified state space matrices Ai Bi Ci Di (descrete time),  
% spampling time TS Markov parameters H(no,ni*n);
% N=number of data points
% output data y(no,N); no=number of outputs
% input data u(ni,N); ni=number of inputs
% ___________________________________________________________
input('generate new data <1> or analyze data <2>: ');mode=ans;
if mode~=2
   input('How many data points ');L=ans;
   [y,u,TS,pn,mn,x]=generate(L);
else
   disp('Data files: none');
   file=input('input name of .mat data file(Default=data): ', 's');
   if file=='d' 
      file='data'; 
   end;
   load(file);
end;

[ni,N]=size(u);[no,N]=size(y);p=no+ni;p1=p-1;
input('order of ARX model(0=skip)Suggested value=15 ');
if ans~=0,
  q=ans;input('identify D?(1=yes,0=no) Suggested value=1 ');
  th=arx_bat(y,u,q,ans);
end;
input('number of Markov parameters for ERA=(0=skip) Suggested value=45 ');
if ans~=0
  n=ans;
  np1=n+1;ni1=ni-1;nni=np1*ni;nom1=no-1;nno=np1*no;
  Y11=zeros(no,nni);Y12=zeros(no,nno);
  for i=1:q+1
    i1=i-1;n1=i1*ni+1;n2=n1+ni1;  n3=i1*no+1;n4=n3+nom1;
           n11=i1*p+1;n12=n11+ni1;n21=n11+ni;n22=n21+nom1;
    Y11(:,n1:n2)=th(1:no,n11:n12);
    Y12(:,n3:n4)=th(1:no,n21:n22);
  end;
  Y11=markov(Y11,Y12,0,n);Y12=markov(Y12,Y12,1,n);
end;
[Ai,Bi,Ci,Di]=era(Y11,ni,q);
mo=log(eig(Ai))/TS;Ki=kalman(Ai,Ci,Y12,n);
disp('Identified open-loop poles');mo