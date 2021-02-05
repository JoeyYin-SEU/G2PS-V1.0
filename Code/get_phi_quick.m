function [phi]=get_phi_quick(In,f,ps,r)
if size(f,2)==1
    [m n]=size(In);
    I_add=zeros(m,n/2);
    I_sub=zeros(m,n/2);
    for i=1:(n/2)
        I_add(:,i)=In(:,(i*2-1))+In(:,(i*2));
        I_sub(:,i)=In(:,(i*2-1))-In(:,(i*2));
    end
    I_r=sqrt(I_sub.*I_sub.*cos(ps/2).*cos(ps/2)+I_add.*I_add.*sin(ps/2).*sin(ps/2));
    phi_r=ps/2-atan((I_sub.*cos(ps/2))./(I_add.*sin(ps/2)));
    B_c=I_r.*cos(phi_r+f.*(-r:1:r));
    B_s=-I_r.*sin(phi_r+f*(-r:1:r));
    I_c2=sum(B_c'.*B_c');
    I_s2=sum(B_s'.*B_s');
    I_cp=sum(B_c'.*I_sub');
    I_sp=sum(B_s'.*I_sub');
    I_cs=sum(B_c'.*B_s');
    phi=atan2(-(I_s2.*I_cp-I_cs.*I_sp),(I_c2.*I_sp-I_cs.*I_cp));
    phi=phi';
else
    [m n]=size(In);
    I_add=zeros(m,n/2);
    I_sub=zeros(m,n/2);
    for i=1:(n/2)
        I_add(:,i)=In(:,(i*2-1))+In(:,(i*2));
        I_sub(:,i)=In(:,(i*2-1))-In(:,(i*2));
    end
    I_r=sqrt(I_sub.*I_sub.*cos(ps/2).*cos(ps/2)+I_add.*I_add.*sin(ps/2).*sin(ps/2));
    phi_r=ps/2-atan((I_sub.*cos(ps/2))./(I_add.*sin(ps/2)));
    B_c=I_r.*cos(phi_r+f(:,1).*(-r:1:r)+f(:,2).*(-r:1:r).*(-r:1:r));
    B_s=-I_r.*sin(phi_r+f(:,1)*(-r:1:r)+f(:,2).*(-r:1:r).*(-r:1:r));
    I_c2=sum(B_c'.*B_c');
    I_s2=sum(B_s'.*B_s');
    I_cp=sum(B_c'.*I_sub');
    I_sp=sum(B_s'.*I_sub');
    I_cs=sum(B_c'.*B_s');
    phi=atan2(-(I_s2.*I_cp-I_cs.*I_sp),(I_c2.*I_sp-I_cs.*I_cp));
    phi=phi';
end
end