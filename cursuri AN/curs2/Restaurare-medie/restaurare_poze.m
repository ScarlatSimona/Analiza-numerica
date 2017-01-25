function [nume1] =restaurare_poze(nume,val, K)


% SIMULAREA UNEI SURSE DE PERTURBATIE CARE EMITE VARIANTE ALE ACELEIASI
% POZE DE K ORI

%preluarea unei imagini dintr-un fisier nume si obtinerea reprezentarii
%matriceale - o matrice pentru gray-scale, 3 matrice pentru RGB

%tip_z - tipul de zgomot

% daca imaginea este gray-scale, sunt disponibile K variante perturbate adtiv cu zgomot gaussian,
% necorelat: in fiecare imagine, valoarea fiecarui pixel (x,y) este modificata prin adunarea cu
% o valoare provenita din repartitia normala de medie 0 si varianta
% sigma^2(x,y); matricea sigma este generata aleator din distributia
% uniforma pe [0,val] 

%nu este nevoie sa se lucreze liniarizat

%nume1 - numele fisierului in care scriu imaginea restaurata

I=imread(nume);

%m-numar de linii, n-numar coloane  
%p=1 in varanta gray-scale si 3 in reprezentarea RGB

[m,n,p]=size(I);

%afisarea imaginii citite
figure
imshow(I);
title('IMAGINEA INITIALA');

if(p>1)
    nume1='';disp('Imaginea nu este gray-scale');
else
    %%Modulul de generare a imaginilor perturbate
    
    %generarea unei matrice mxn cu elemente din distributia uniforma [0,val]
    sigma=unifrnd(0,val,m,n);
    for i=1:K
       %generatea zgomotului normal pe baza matricei sigma, cu medie 0
        zgomot=normrnd(zeros(m,n),sigma,m,n);
        %nu se poate lucra cu tipul unit8 si se face transferul de tipla double 
        I1=double(I);
        J=I1+zgomot;
         %afisarea imaginii rezultate
         figure
         imshow(uint8(J));
         title(['IMAGINEA PERTURBATA' num2str(i)]);
         numeJ=['impert' num2str(i) '.bmp'];
         imwrite(uint8(J),numeJ,'bmp');
    end;
    
    %%Modulul de restaurare 
    IM_R=zeros(m,n);
     for i=1:K
       %citirea imaginii perturbate i 
       numeJ=['impert' num2str(i) '.bmp'];
       J=imread(numeJ);
       IM_R=IM_R+double(J);
    end;
    IM_R=IM_R/K;
     figure
     imshow(uint8(IM_R));
     title('IMAGINEA RESTAURATA');
     %salvarea imaginii rezultate intr-un fisier .jpg
      imwrite(uint8(IM_R),'poza_rezultata.jpg','jpg');
end;  


%exemple de apel: restaurare_poze('LENNAA.BMP',25,10);
% restaurare_poze('BADSCAN1.BMP',30,20);
end

