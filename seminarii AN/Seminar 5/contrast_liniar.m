function []= contrast_liniar(nume, r, s, tip)
    % cresterea contrastului in mod liniar, cu doua puncte
    % I: nume - numele fisierului cu imaginea originala
    %    r, s - cele 2 puncte (in r coordonata x, in s coordonata y),
    %    tip - tipului fisierului pentru salvare
    % E: -
    % Exemple de apel:
    % doua puncte de taietura
    % contrast_liniar('LENNAA.BMP',[0 84 170 255], [0 40 210 255], 'png');
    % contrast_liniar('MB.jpg',[0 84 170 255], [0 40 210 255], 'png');
    % contrast_liniar('LENNA.BMP',[0 84 170 255], [0 40 210 255], 'png');
    % patru puncte de taietura
    % contrast_liniar('LENNAA.BMP',[0 42 85 127 169 212 255], [0 30 65 127 189 232 255], 'png');
    % contrast_liniar('MB.jpg',[0 42 85 127 169 212 255], [0 30 65 127 189 232 255], 'png');
    % contrast_liniar('LENNA.BMP',[0 42 85 127 169 212 255], [0 30 65 127 189 232 255], 'png');
    
    poza=imread(nume);
    [~,~,p]=size(poza);
    pozad=double(poza);
    rez=pozad;
    for k=1:p
        rez(:,:,k)=contrast_plan(pozad(:,:,k),r,s);
    end;
    figure
        title('Imaginea initiala si imaginea transformata');
        subplot(1,2,1), subimage(poza);
        subplot(1,2,2), subimage(uint8(rez));
    imwrite(uint8(rez),[nume '-cl.' tip],tip);
end

function [rez]=contrast_plan(plan,r,s)
    % contrast liniar pentru un plan
    % I: plan - planul de prelucrat, r si s - punctele pentru contrast
    % E: rez - planul modificat
    
    [m,n]=size(plan);
    nr=length(r);
    rez=plan;
    for i=1:m
        for j=1:n
            for k=1:nr-1
                if r(k)<=plan(i,j) && plan(i,j)<=r(k+1)
                    rez(i,j)= plan(i,j)* ( (s(k+1)-s(k))/(r(k+1)-r(k))) + (r(k+1)*s(k)-r(k)*s(k+1))/(r(k+1)-r(k)) ;
                end;
            end;
        end;
    end;
end