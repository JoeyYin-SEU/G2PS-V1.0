    Z=peaks(512)*5;
    tsr=2;
    [I1,I2,O_train]=begin(4,Z); 
    Iter=20;
    Ini_T=[20,0];
    tic
    [phi,F_n]=Twostep_AT2S(I1,I2,pi,tsr,Ini_T,Iter);
    %The Unwrapping algorithm in Twostep_AT2S is replaced by 
    %'unwrap' in Matlab because of the copyright problem
    %It is necessary to replace the unwrapping algorithm for complex objects
    toc
    subplot(121)
    imshow(mat2gray(reshape(O_train,512-4,512-4)'))
    title('Actual phase')
    subplot(122)
    imshow(mat2gray(reshape(phi,512-2*tsr,512-2*tsr)'))
    title('Our method')