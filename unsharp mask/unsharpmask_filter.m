function [imgrez] = unsharpmask_filter(numeimg,tip,masca)
%E: imaginea rezultata dupa aplicarea filtrului unsharp mask
%I: numeimg = numele imaginii ce se doreste procesata
%   tip = tipul imaginii rezultate dupa procesare
%   Ex: unsharpmask_filter('lenna.bmp','bmp','m3.txt');
%   unsharpmask_filter('lenna.bmp','bmp','m5.txt');
I = imread(numeimg);
[m,n,p] = size(I);
    figure; 
    subplot(1,3,1); imshow(I); 
    title('Imaginea initiala');
T=zeros(m,n,p);
%perturbare imagine cu zgomot
J = imnoise(I,'salt & pepper',0.20);
subplot(1,3,2); imshow(uint8(J)); title('Imaginea initiala perturbata cu zgomot');
for k = 1:p
    %aplicare filtru median pentru nivelarea imaginii folosind masca 3x3
    MED = filtrare_medie(J,masca);
    T(:,:,k)= MED;
end
REZ = I + (I - uint8(T));
imgrez=[numeimg 'unsharpmask.',tip];
    subplot(1,3,3); imshow(uint8(REZ));
    title('Imaginea procesata');
    imwrite(uint8(REZ),imgrez,tip);
end