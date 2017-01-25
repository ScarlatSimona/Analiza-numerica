function [g,g1] = filtrare_Wiener_MDiscret(poza,originala,gam,iT,eps)
    % filtrare Wiener pentru imagini perturbate cu zgomot normal efect de
    % miscare in caz discret pe a doua axa
    % I: poza - numele fisierului imaginea perturbata
    %    originala - numele fisierului cu imaginea originala neperturbata,
    %                exclusiv pentru calcularea SNR 
    %    gam - parametrul filtrului Wiener
    %    iT - "viteza" miscarii
    %    eps - defineste vecinatatea lui zero
    % E: g1 - imaginea rezultata in urma filtrarii
    %    g - g1 cu nivelurile de gri aduse pe intervalul 0..255
    % Exemple de apel
    % filtrare_Wiener_MDiscret('LENNAA_MD_y_iT_5.bmp','LENNAA.BMP',0.4,5,0.001);
    % filtrare_Wiener_MDiscret('LENNAA_MD_y_iT_9.bmp','LENNAA.BMP',0.1,9,0.001);
    % filtrare_Wiener_MDiscret('LENNAA_MD_y_iT_11.bmp','LENNAA.BMP',0.03,11,0.001);
    % filtrare_Wiener_MDiscret('BADSCAN1_MD_y_iT_9.bmp','BADSCAN1.BMP',0.1,9,0.001);
    % filtrare_Wiener_MDiscret('BADSCAN1_MD_y_iT_13.bmp','BADSCAN1.BMP',0.02,13,0.0001);

    % preluare imagine de filtrat
    I=imread(poza);
    J=I(:,:,1);
    [l,c]=size(J);
    g=double(J);

    %calculul filtrului Laplace in frecvente
    numefiltru='laplace.txt';
    w=load(numefiltru);
    TFDl=construieste_filtru_fr(l,c,w);

    % calculul TFD a imaginii 
    TFDg=fft2(g);

    % calculul filtrului motion blur
    TFDh=motion_blur_d(l,c,iT);

    % filtrarea in domeniul frecventelor cu Wienner
    TFDf=zeros(l,c);
    for x=1:l
        for y=1:c
            if((abs(TFDh(x,y)))^2+gam*(abs(TFDl(x,y)))>eps)
                  val=(TFDh(x,y))'/((abs(TFDh(x,y)))^2+gam*(abs(TFDl(x,y))));
            else
                val=1;
            end;
            TFDf(x,y)=TFDg(x,y)*val;
        end;
    end;

    % calculul imaginii filtrate
    g1=real(ifft2(TFDf)); % cu varianta  g1=abs(ifft2(TFDf));
    
    % aducerea nivelurilor de gri pe 0..255
    valmax=max(max(g1));
    valmin=min(min(g1));
    g=255*(g1-ones(l,c)*valmin)/(valmax-valmin);

    % matricea rezultat
    rez=uint8(g);

    % afisarea si salvarea imaginii restaurate
    figure
        imshow(I);
        title('Imaginea cu motion blur si zgomot');
    figure
        imshow(rez);
        title('Filtrare Wiener');
    [nume,ext]=strtok(poza,'.');
    fo=[nume '_W_' ext];
    imwrite(rez,fo);

    er=SNR(poza,originala);
    disp(['SNR pentru imaginea perturbata ' num2str(er)]);
    er=SNR(fo,originala);
    disp(['SNR pentru imaginea filtrata ' num2str(er)]);
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


