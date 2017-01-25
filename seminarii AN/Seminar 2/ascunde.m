function [ok]=ascunde(poza_o, mesaj, poza_m, tip)
    % ascunde un mesaj in poza (color sau nuante de gri)
    % prin modificarea cite unui pixel pentru fiecare litera,
    % litere mici, fara spatii si diacritice, in pozitii aleatoare
    % I: poza_o (nume fisier poza originala), mesaj (text)
    %    poza_m (nume fisier poza modificata), tip (tip fisier imagine
    %    rezultat: (bmp, png, gif numai pentru nuante de gri))
    % E: ok (1 in caz de succes, 0 daca imaginea are un numar de plane
    %    diferit de 1 sau 3)
    
    IO=imread(poza_o);
    [~,~,p]=size(IO);
    sir=mesaj-double(uint8('a'))+1;
    
    ok=1;
    
    if p==1
        IM=codificare(IO,sir);
    elseif p==3
        nr=length(mesaj);
        puncte=unidrnd(nr,1,2);
        puncte=sort(puncte);
        puncte=[0 puncte nr];
        
        for i=1:p
            IM(:,:,i)=codificare(IO(:,:,i),sir(puncte(i)+1:puncte(i+1)));
        end;
    else
        ok=0;
    end;
    
    fi=[poza_o '.' tip];
    fo=[poza_m '.' tip];
    imwrite(IO,fi,tip);
    imwrite(IM,fo,tip);
    
%     figure
%         imshow(IO);
%         title('poza originala');
%     figure 
%         imshow(IM);
%         title('poza modificata');
end



function [poza_m]=codificare(poza, mesaj)
    % codificare mesaj dat in 1 plan al pozei (primit)
    % I - mesaj (coduri numerice ale literelor), poza (1 plan=o matrice)
    % E - poza_m (poza modificata, 1 plan=o matrice)
    
    vmax=255-max(mesaj);
        
    [m,n]=size(poza);
    nr=length(mesaj);
    [l,c]=pozitii(poza,m,n,nr,vmax);
    
    poza_m=poza;
    for i=1:nr
        poza_m(l(i),c(i)) = poza_m(l(i),c(i)) + mesaj(i);
    end;
end



function [l,c]=pozitii(poza,m,n,nr,vmax)
    % generare pozitii aleatoare intr-o poza, sortate, sa nu depaseasca o
    % valoare maxima data
    % I: poza(imaginea), m,n (dim. poza), nr (nr. pozitii), vmax (val. maxima admisa)
    % l,c (vectori cu coordonatele pozitiilor alese)
    
    l=zeros(1,nr);
    c=zeros(1,nr);
    p=0;
    while p<nr
        i=unidrnd(m);
        j=unidrnd(n);
        if poza(i,j)<vmax && ~(ismember(i,l) && ismember(j,c))
            p=p+1;
            l(p)=i;
            c(p)=j;
        end;
    end;
    
    for i=1:nr-1
        for j=i+1:nr
            if (l(i)-1)*n+c(i) > (l(j)-1)*n+c(j)
                aux=l(i); l(i)=l(j); l(j)=aux;
                aux=c(i); c(i)=c(j); c(j)=aux;
            end;
        end;
    end;
end