function b = signstar(a,param)

[m,n]=size(a);
b=zeros(m,n);
l=(a-param)>0;
b(l)=1;