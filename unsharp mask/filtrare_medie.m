function [rez] = filtrare_medie(I,filtru)
    % filtru medie pentru prelucrarea unei imagini grayscale (unele imagini
    % sint salvate in format RGB, dar cele trei plane sint identice, deci
    % se lucreaza numai cu primul
    % I: nume - fisierul cu imaginea de prelucrat, filtru - fisier text
    %    care contine matricea filtru, tip - tip fisier pentru rezultat
    % E: -
    
    % Exemple de apel:
    % filtrare_medie('filtrumedie.jpg','m5.txt','png')
    % pentru reducerea zgomotului:
    % filtrare_medie('zgomot1.jpg','mp3.txt','png')
    % filtrare_medie('zgomot2.jpg','mp3.txt','png')
    
    [m,n,~]=size(I);

    plan=I(:,:,1);

    w=load(filtru);
    [m1,n1]=size(w);
    
    l=m+2*m1-2;
    c=n+2*n1-2;
    f=zeros(l,c);
    
    f(m1:m+m1-1,n1:n+n1-1)=double(plan);
    g=zeros(l,c);
    suma=sum(sum(w)); % disp(suma);
    a=(m1-1)/2; b=(n1-1)/2;
    
    % filtrare cu masca w
    for x=1:m
        for y=1:n
            %g(x+m1-1,y+n1-1)=0;
            for s=1:m1
                for t=1:n1
                    g(x+m1-1,y+n1-1)=g(x+m1-1,y+n1-1)+w(s,t)*f(x+m1-1+s-a-1,y+n1-1+t-b-1);
                end;
            end;
            g(x+m1-1,y+n1-1)= g(x+m1-1,y+n1-1)/suma;
        end;
    end;
    rez=uint8( g(m1:m+m1-1,n1:n+n1-1));
%     figure
%         imshow(plan);
%         title('Imaginea initiala');
%     figure
%         imshow(rez);
%         title(['Imaginea filtrata cu filtrul ' filtru]);
end

