function [phi,F_n]=Twostep_AT2S(I1,I2,step_phase,tsr,ini_T,iter_num)

    if nargin==2
        step_phase=pi;
        tsr=2;
        ini_T=30;
        iter_num=20;
    end
    if nargin==3
        tsr=2;
        ini_T=30;
        iter_num=20;
    end
    if nargin==4
        ini_T=30;
        iter_num=20;
    end
    if nargin==5
        iter_num=20;
    end
    if length(ini_T)==1
        [hei,wid]=size(I1);
        P_train=zeros((hei-2*tsr)*(wid-2*tsr),2*(tsr*2+1));
        flag=1;
        for ii=(1+tsr):(hei-tsr)
            for jj=(1+tsr):(wid-tsr)
                for ss=1:(2*tsr+1)
                    P_train(flag,2*ss-1)=I1(ii,jj+ss-tsr-1);
                    P_train(flag,2*ss)=I2(ii,jj+ss-tsr-1);
                end
                flag=flag+1;
            end
        end
        [phi]=get_phi_quick(P_train,1/ini_T*2*pi,step_phase,tsr);
        px_s2=sum((-tsr:1:tsr).*(-tsr:1:tsr));
        for iter=1:(iter_num-1)
            Es=reshape(phi,(wid-2*tsr),(hei-2*tsr));
            Es=unwrap(Es);%Unwrapping
            Es=Es';
            flag=1;
            F_n=zeros((hei-2*tsr),(wid-4*tsr));
            for ii=-tsr:1:tsr
                F_n=F_n+ii*Es(:,(tsr+ii+1):(ii+wid-3*tsr));
            end
            F_n=F_n./px_s2;
            for ii=1:tsr
                F_n=[F_n(:,1),F_n,F_n(:,end)];
            end
            F_n=reshape(F_n',1,(hei-2*tsr)*(wid-2*tsr));
            F_n=F_n';
            [phi]=get_phi_quick(P_train,F_n,step_phase,tsr);
        end
    else
        [hei,wid]=size(I1);
        P_train=zeros((hei-2*tsr)*(wid-2*tsr),tsr*2+1);
        flag=1;
        for ii=(1+tsr):(hei-tsr)
            for jj=(1+tsr):(wid-tsr)
                for ss=1:(2*tsr+1)
                    P_train(flag,2*ss-1)=I1(ii,jj+ss-tsr-1);
                    P_train(flag,2*ss)=I2(ii,jj+ss-tsr-1);
                end
                flag=flag+1;
            end
        end
        [phi]=get_phi_quick(P_train,1/ini_T(1)*2*pi,step_phase,tsr);
        F_n=zeros((hei-2*tsr)*(wid-2*tsr),1);
        px_s4=sum((-tsr:1:tsr).*(-tsr:1:tsr).*(-tsr:1:tsr).*(-tsr:1:tsr));
        px_s2=sum((-tsr:1:tsr).*(-tsr:1:tsr));
        for iter=1:(10)
            Es=reshape(phi,(wid-2*tsr),(hei-2*tsr));
            Es=unwrap(Es);%Unwrapping
            Es=Es';
            flag=1;
            F_n=zeros((hei-2*tsr),(wid-4*tsr));
            for ii=-tsr:1:tsr
                F_n=F_n+ii*Es(:,(tsr+ii+1):(ii+wid-3*tsr));
            end
            F_n=F_n./px_s2;
            for ii=1:tsr
                F_n=[F_n(:,1),F_n,F_n(:,end)];
            end
            F_n=reshape(F_n',1,(hei-2*tsr)*(wid-2*tsr));
            F_n=F_n';
            [phi]=get_phi_quick(P_train,F_n,step_phase,tsr);
        end
        for iter=(11):(iter_num-1)
            Es=reshape(phi,(wid-2*tsr),(hei-2*tsr));
            Es=unwrap(Es);%Unwrapping
            Es=Es';
            flag=1;
            F_n=zeros((hei-2*tsr),(wid-4*tsr));
            for ii=-tsr:1:tsr
                F_n=F_n+ii*Es(:,(tsr+ii+1):(ii+wid-3*tsr));
            end
            F_n=F_n./px_s2;
            for ii=1:tsr
                F_n=[F_n(:,1),F_n,F_n(:,end)];
            end
            F_n=reshape(F_n',1,(hei-2*tsr)*(wid-2*tsr));
            F_1=F_n';
            F_n=zeros((hei-2*tsr),(wid-4*tsr));
            for ii=-tsr:1:tsr
                F_n=F_n+px_s2*Es(:,(tsr+ii+1):(ii+wid-3*tsr))-(2*tsr+1)*ii*ii*Es(:,(tsr+ii+1):(ii+wid-3*tsr));
            end
            F_n=F_n./(px_s2*px_s2-px_s4);
            for ii=1:tsr
                F_n=[F_n(:,1),F_n,F_n(:,end)];
            end
            F_n=reshape(F_n',1,(hei-2*tsr)*(wid-2*tsr));
            F_2=F_n';
            F_2(abs(F_2)<0.01)=0;
            F_n=[F_1,F_2];
            [phi]=get_phi_quick(P_train,F_n,step_phase,tsr);
        end
    end
