function [fo] = zgomot_g_n_rgb(fi,s_max,tip)
  % adaugarea de zgomot gaussian necorelat la o imagine RGB
  % I: fis_poza - numele fisierului care contine imaginea initiala
  %    s_max - sigma maxim pentru zgomotul adaugat fiecarei 
  %            componente de culoare a fiecarui pixel
  %    tip - tip fisier rezultat ('png' / 'jpg' etc.)
  % E: fis2 - fisierul cu poza perturbata

  I=imread(fi);
  [m,n,p]=size(I);

  figure
    imshow(I);
    title('Imaginea initiala');
  
  R=I;  
  for k=1:p  
    K(m,n,k)=zeros(m,n,k);
    sigma=unifrnd(0,s_max,m,n);
    zgomot=normrnd(zeros(m,n),sigma,m,n);
    I1=double(I(:,:,k));
    J=I1+zgomot;
    R(:,:,k)=uint8(J);
    K(:,:,p)=R(:,:,k);
    figure
      imshow(R(:,:,k));
      imshow(uint8(k));
      title(['Planul ' k]);
  end;
     
  fo=[fi '_g_n_rgb.' tip];
  imwrite(R,fo,tip);
  figure
    imshow(R);
    title('Imaginea perturbata');
end
