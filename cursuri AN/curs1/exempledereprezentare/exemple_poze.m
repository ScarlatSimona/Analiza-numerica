function [] = exemple_poze(nume)

%% EXEMPLE DE TEST
%exemple_poze('BADSCAN1.BMP');
% exemple_poze('LENNA.BMP');


%% CORPUL FUNCTIEI

%preluarea unei imagini dintr-un fisier nume si obtinerea reprezentarii
%matriceale - o matrice pentru grey-scale, 3 matrice pentru RGB


I=imread(nume);

[m,n,p]=size(I);

if(p==1)
    %afisarea imaginii citite
    figure
    imshow(I);
    title('IMAGINEA MONOCROMA');
else
     %afisarea imaginii citite si a fiecarei componente
    figure
    imshow(I);
    title('IMAGINEA COLOR - RGB');
    for i=1:3
        figure
        imshow(I(:,:,i));
        switch i
            case 1
                L='R';
            case 2 
                L='G';
            case 3 
                L='B';
        end;
        title(['COMPONENTA ' L ' A IMAGINII IN REPREZENTARE MONOCROMA']);
    end;
    T=zeros(m,n,p);
     for i=1:3
         J=zeros(m,n,p);
         J(:,:,i)=I(:,:,i);
         T(:,:,i)=I(:,:,i);
        figure
        imshow(uint8(J));
        switch i
            case 1
                L='R';
            case 2 
                L='G';
            case 3 
                L='B';
        end;
        title(['COMPONENTA ' L ' A IMAGINII IN REPREZENTAREA COLOR']);
    end;
    figure
    imshow(uint8(T));
    title('IMAGINEA COLOR REFACUTA DIN COMPONENTE ');
end;
end

