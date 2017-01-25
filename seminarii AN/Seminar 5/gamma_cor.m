function []=gamma_cor(nume, c, g, tip)
    % transformarea gamma pentru modificarea luminozitatii si contrastului
    % I: nume - numele fisierului care contine imaginea
    %    c, g - constantele transformarii (s=c * r^g )
    %    tip - tipul fisierului pentru salvarea imaginii prelucrate
    % E: -
    % Exemple de apel:
    % gamma_cor('BADSCANS.BMP',1,1.15, 'png');
    % gamma_cor('2.tif',0.5,1.15)
    % gamma_cor('LENNA.BMP',0.5,1.15, 'png');
    % gamma_cor('MB.jpg',0.4,1.2, 'png');
    
    poza=imread(nume);
    [~,~,p]=size(poza);
    rez=poza;
    for k=1:p
        rez(:,:,k)=gamma_plan(poza(:,:,k),c,g);
    end;
    figure
        title('Imaginea initiala si imaginea transformata');
        subplot(1,2,1), subimage(poza);
        subplot(1,2,2), subimage(rez);
    imwrite(uint8(rez),[nume '-gamma.' tip],tip);
end

function [r]=gamma_plan(plan,c,g)
    % aplica transformarea gamma asupra unui plan al imaginii
    % I: plan - planul care trebuie prelucrat
    %    c, g - constantele transformarii (s=c * r^g )
    % E: r - rezultatul prelucrarii (planul modificat)
    
    [m,n]=size(plan);
    r=double(plan);
    for i=1:m
        for j=1:n
            r(i,j)=c*r(i,j)^g;
        end;
    end;
end
    