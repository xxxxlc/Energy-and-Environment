kn=1000;%计算时间间隔数
%a=1.0e-4;%热扩散系数
%L=0.2;%长度
n=50;%节点数
%dx=L/(n-1);%节点间距
%dtao=0.1;%时间步长
%Fo=a*dtao/(dx)^2;%傅里叶数
%Fo=0.905;
Fo=0.495;
t0=zeros(n,1);
t1=zeros(n,1);
tkn=zeros(n,kn)
t0(n)=100;%边界条件
t1(n)=100;
for j=1:n
    tkn(j,1)=t0(j);
end
for k=2:kn
  for i=2:n-1
    t1(i)=(1-2*Fo)*t0(i)+Fo*(t0(i+1)+t0(i-1));
  end
  for j=1:n
    tkn(j,k)=t1(j);
    t0(j)=t1(j);
  end
  t1
  plot(t1);
  pause;
end
plot(tkn);
%plot(t1);