function [] = filtre_zgomot(originala,perturbata,sectiune,d)
    % exemplificare comparativa a utilizarii filtrului median (functia
    % matlab) si a filtrului adaptiv MMSE
    % I: originala - fisierul cu imaginea originala neperturbata; e
    %                utillizata numai pentru studiul calitatii restaurarii 
    %                folosind indicatorul SNR        
    %    perturbata - fisierul cu imaginea perturbata cu zgomot gaussian
    %    sectiune - sectiune din imaginea perturbata, relativ uniforma, pentru estimarea
    %            parametrilor zgomotului
    %    d - dimensiunea filtrului
    % E: -
    % exemple de apel
    %    filtre_zgomot('im1.tif','im1g.tif','sg1.tif',3);
    %    filtre_zgomot('im3.tif','im3g.tif','sg3.tif',3);
    %    filtre_zgomot('car_gray.png','car_zgomot_GN.png','car_sectiune_zgomot.png',3);

    % SNR petnru imaginea perturbata
    er=SNR(perturbata,originala);
    disp(['SNR pentru imaginea perturbata: ' num2str(er)]);

    %filtrare MMSE
    B=filtru_MMSE(perturbata,sectiune,d);
    figure
        imshow(B);
        title('Imaginea filtrata MMSE');
    filtrata=[perturbata '-MMSE.png'];
    imwrite(B,filtrata);
    er=SNR(filtrata,originala);
    disp(['SNR pentru imaginea filtrata MMSE: ' num2str(er)]);

    %filtrare mediana
    B=filtru_median(perturbata,d);
    figure
        imshow(B);
        title('Imaginea filtrata cu filtrul median');
    filtrata=[perturbata '-median.png'];
    imwrite(B,filtrata);
    er=SNR(filtrata,originala);
    disp(['SNR pentru imaginea filtrata median: ' num2str(er)]);
end

