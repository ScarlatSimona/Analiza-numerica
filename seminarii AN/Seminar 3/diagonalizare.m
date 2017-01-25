function [] = diagonalizare(poza,procent)
    % Diagonalizarea unei imagini in nuante de gri cu compresie 
    %I: poza - numele fisierului cu imaginea de prelucrat
    %   procent - procent compresie
    %E: -
    
    % EXEMPLE DE TEST
    % diagonalizare('EX1.BMP',40);
    % diagonalizare('LENNAA.BMP',30);
    % diagonalizare('BADSCAN1.BMP',50);
    % diagonalizare('2.tif',50);

  I=imread(poza);
  [m,n,p1]=size(I);
  %disp(m);disp(n);
  if(p1>1)
    disp('Imaginea nu este gray-scale (mai mult de 1 plan)');
  else
    figure
      imshow(I);
    title('Imaginea initiala');
      
    f=double(I);
    A=f*(f');
    % valori proprii si vectori proprii ortogonali corespunzatori
    [U1,sigma1]=eig(A);
    sigma=sigma1;
    % inversare ordine valori proprii si vectori proprii (eig: min->max)
    for j=1:m
       sigma(j,j)=sigma1(m-j+1,m-j+1);
    end;
    U(:,1:m)=U1(:,m:-1:1);
    
    S=U';
    % determinare numar valori proprii pozitive (i)
    i=0;
    j=1;
    while (j<=m) && (sigma(j,j)>0) 
        i=i+1;
        j=j+1;
    end;
    % determinare numar de valori proprii pastrate (k)
    k=uint16(procent*i/100);
    % pastrarea a k valori si vectori proprii
    sigmar=sigma(1:k,1:k);
    S1=S(1:k,:);
    % calcul imagine diagonalizata
    g=(sigmar)^-0.5*S1*f;
    I_diag=S1'*(sigmar^0.5)*g;
      
    % salvare si vizualizare rezultat
    fo=[poza '-' num2str(procent) '.png'];
    imwrite(uint8(I_diag),fo,'png');
            
    figure
      imshow(uint8(I_diag));
      title(['Figura in reprezentarea diagonalizata cu compresie de ' num2str(100-procent) '%']);
      
    %% diferenta intre imaginea initiala si cea comprimata
    dif=I-uint8(I_diag);
    figure
      imshow(dif);
      imshow(255-dif);
    c=0;
    max=0;
    for i=1:m
        for j=1:n
          if dif(i,j)>0 
              c=c+1;
          end;
          if dif(i,j)>max
              max=dif(i,j);
          end;
        end;
    end;
    disp(['Total puncte in imagine: ' int2str(m*n)]);
    disp(['Total puncte diferite: ' int2str(c)]);
    disp(['diferenta maxima: ' int2str(max)]);
    dd=zeros(1,max);
    for i=1:m
        for j=1:n
            if dif(i,j)>0
                dd(dif(i,j))=dd(dif(i,j))+1;
            end;
        end;
    end;
    disp(['Puncte cu diferenta 1 - > ' int2str(max) ':']);
    tz=[uint16(1:max);dd];
    disp(tz);
      
  end;
end

