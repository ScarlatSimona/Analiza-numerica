function [] = bhp_filter(numeimg,D,k)
% filtru butterworth high-pass -> atenueaza frecventele joase
% I: numeimg - numele imaginii ce se doreste a fi prelucrata
% k - ordin
% D - raza
% bhp_filter('lennaa.bmp',40,2);
I = imread(numeimg);
[m,n,p]=size(I);

if(p==1)
        figure;
        subplot(1,2,1); imshow(I);
        title('Imaginea initiala');
 % x, y - matrici mxn
 %[x,y] = dftuv(m,n);
  [x,y] = meshgrid(-floor(n/2):floor((n-1)/2),-floor(m/2):floor((m-1)/2)); 
  %functia de filtrare
  G = 1./(1+(D./(x.^2 + y.^2).^0.5).^(2*k));
  % Fourier filter
  GF = fftshift(fft2(I));
  GFF = GF.*G;
  imgrez = ifft2(GFF);
  %afisare imagine
    I1 = abs(imgrez);
    I1maxval = max(I1(:));
    subplot(1,2,2); 
    imshow(I1/I1maxval);
    title('Imaginea procesata cu filtrul BHP');
end
end


