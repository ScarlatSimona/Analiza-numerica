function [rez] = perturba_motion_noise_MDiscret(poza,iT,sigma)
    % Perturba imaginea 'poza' prin inducerea efectului de miscare in caz 
    % discret pe a doua axa si adaugarea de zgomot normal. Imaginea 
    % rezultata e salvata intr-un fisier cu numele compus din numele 
    % fisierului original si parametrii perturbarii.
    % I: poza - numele fisierului care contine imaginea de prelucrat
    %           (se foloseste un plan, format gray-scale)
    %    iT - "viteza" miscarii
    %    sigma - variantza N(0,sigma), pentru adaugarea zgomotului
    % E: rez - imaginea rezultata (un plan, gray-scale)

    % Exemple de apel 
    % perturba_motion_noise_MDiscret('LENNAA.bmp',5,20);  - efect de miscare slab si zgomot mare
    % perturba_motion_noise_MDiscret('LENNAA.bmp',9,10); 
    % perturba_motion_noise_MDiscret('LENNAA.bmp',11,5);  - efect de miscare puternic si zgomot slab
    % perturba_motion_noise_MDiscret('BADSCAN1.bmp',9,15); 
    % perturba_motion_noise_MDiscret('BADSCAN1.bmp',13,5);  - efect de miscare puternic si zgomot slab

    % preluare imagine din fisier
    I=imread(poza);
    J=I(:,:,1);
    [l,c]=size(J);
    f=double(J);

    % calculul TFD a imaginii 
    TFDfc=fft2(f);

    % calculul filtrului
    TFDh=motion_blur_d(l,c,iT);

    % filtrarea in domeniul frecventelor
    TFDg=zeros(l,c);
    for x=1:l
        for y=1:c
            TFDg(x,y)=TFDh(x,y)*TFDfc(x,y);
        end;
    end;

    % calculul imaginii filtrate
    g1=abs(ifft2(TFDg));
    
    % matricea rezultat
    rez1=double(uint8(g1));
    
    % adaugare zgomot
    % rez=imnoise(rez1,'gaussian',0,sigma);
    zg=normrnd(0,sigma,l,c);
    rez=uint8(rez1+zg);

    % afisarea si salvarea perturbarii
    figure
        imshow(I);
        title('Imaginea initiala');
    figure
        imshow(rez);
        title(['Imaginea peturbata motion blur+zgomot']);
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_MD_y_iT_' num2str(iT) ext];    
    imwrite(rez,fo);
end


function [TFDh]=motion_blur_d(l,c,iT)
    % calcul filtru discret in domeniul frecventelor pentru motion blur
    TFDh=zeros(l,c);
    for x=1:l
        for y=1:c
            TFDh(x,y)=(1/iT)*(sin(pi*(y*iT/c))/sin(pi*(y/c)))*exp(-1i*pi*y*(iT-1)/c);
        end;
    end;
end