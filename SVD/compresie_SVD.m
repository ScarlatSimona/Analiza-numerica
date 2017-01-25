function [imgrez]= compresie_SVD(numeimg,tip,nrvalpr)
%SVD = Singular Value Decomposition 
%algoritmul presupune comprimarea unei imagini (obtinerea unei imagini cu
%mai putin de MxN elemente
%   E: imagine rezultata prin compresie SVD
%   I: numeimg = nume imagine aleasa pentru compresie SVD
%       tip = tipul imaginii rezultate prin compresie
%       nrvalpr = cat de multe valori proprii sunt luate in considerare (cu catnr este mai mare cu atat imaginea 
%       comprimata va fi mai clara)
% Ex: compresie_SVD('LENNAA.BMP','bmp',40);
I=imread(numeimg);
[m,n,p] = size(I);
    figure
    subplot(1,2,1); imshow(I); title('Imaginea initiala');
   if(p == 1)
       subplot(1,2,2); imhist(I); title('Histograma imaginii initiale');
   end
if(p>1)
    T = zeros(m,n,p);
    for k=1:p
        [U,f,V]=svds(double(I(:,:,k),nrvalpr));
        %U - vectori proprii stanga (mxr)
        %f - valori proprii (matrice diagonala, aranjate descrescator) (rxr)
        %V - vectorii proprii dreapta (rxn)
        T(:,:,k) = uint8(U*f*transpose(V));
    end
else
    [U,f,V]=svds(double(I(:,:,1)),nrvalpr);
    % U f transpose(V) -> matrice diagonala
    T(:,:,1)=uint8(U*f*transpose(V));
end;
imgrez=[numeimg 'comprimata_SVD.' tip];
imwrite(uint8(T),imgrez,tip);
    figure
    subplot(1,2,1); imshow(uint8(T)); title('Imagine comprimata SVD');
    if(p==1)
        subplot(1,2,2); imhist(uint8(T)); title('Histograma imaginii procesate SVD');
    end 
end