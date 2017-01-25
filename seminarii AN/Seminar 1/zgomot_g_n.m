function [fo] = zgomot_g_n(fi,s_max,tip)
  % adaugarea de zgomot gaussian necorelat la o imagine alb-negru
  % I: fis_poza - numele fisierului care contine imaginea initiala
  %    s_max - sigma maxim pentru zgomotul adaugat fiecarui pixel
  %    tip - tip fisier rezultat ('png' / 'jpg' etc.)
  % E: fis2 - fisierul cu poza perturbata

  I=imread(fi);
  [m,n,p]=size(I);

  figure
    imshow(I);
    title('Imaginea initiala');
  
  if(p>1)
    fo='';
    disp('Imaginea este color, nu se prelucreaza');
  else
    sigma=unifrnd(0,s_max,m,n);
    zgomot=normrnd(zeros(m,n),sigma,m,n);
    I1=double(I);
    J=I1+zgomot;
    
    fo=[fi '_g_n.' tip];
    imwrite(uint8(J),fo,tip);
    figure
      imshow(uint8(J));
      title('Imaginea perturbata');
  end;
end
