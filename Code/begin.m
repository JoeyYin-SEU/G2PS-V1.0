function [I1,I2,O_train]=begin(q,z)
Am=0.6999;
ar=0.5;f=1/20;
w=2*pi*f;
xx=1:512;
yy=1:512;
[xx,yy]=meshgrid(xx,yy); 
Rr=0.1-(xx.*xx+yy.*yy)/512/512*0.1;
L=80;d=30;
img=rand(512,512)*0.2+0.8;
if q==-1
    I1=((1+Am*cos(w*(xx+z*d./(L-z))))+randn(512,512)/256*0+Rr);
    I1=ar*(img).*I1;
    I2=(1+Am*cos(pi+w*(xx+z*d./(L-z))))+randn(512,512)/256*0+Rr;
    I2=ar*(img).*I2;
else
    I1=((1+Am*cos(w*(xx+z*d./(L-z))))+randn(512,512)/256*q+Rr);
    I1=ar*(img).*I1;
    I1=fix(I1*255+0.5);
    I2=(1+Am*cos(pi+w*(xx+z*d./(L-z))))+randn(512,512)/256*q+Rr;
    I2=ar*(img).*I2;
    I2=fix(I2*255+0.5);
end
tsr=2;
flag=1;
T_train=zeros((512-2*tsr)*(512-2*tsr),2);
O_train=zeros((512-2*tsr)*(512-2*tsr),1);
for ii=(1+tsr):(512-tsr)
    for jj=(1+tsr):(512-tsr)
        T_train(flag,1)=sin(w*(xx(ii,jj)+z(ii,jj)*d/(L-z(ii,jj))));
        T_train(flag,2)=cos(w*(xx(ii,jj)+z(ii,jj)*d/(L-z(ii,jj))));
        O_train(flag)=atan2(T_train(flag,1),T_train(flag,2))-pi;
        if O_train(flag)<-pi
            O_train(flag)=O_train(flag)+2*pi;
        end
        flag=flag+1;
    end
end