function []=egalizare_hist(nume,tip)
    % egalizarea histogramei pentru o imagine
    % I: nume - numele fisierului cu imaginea initiala, 
    %    tip - tipul fisierului pentru imaginea modificata
    % E: -
    
    poza=imread(nume);
    [~,~,p]=size(poza);
    rez=poza;
    for k=1:p
        rez(:,:,k)=egalizare_plan(poza(:,:,k));
    end;
    figure
        title('Imaginea initiala si imaginea transformata');
        subplot(1,2,1), subimage(poza);
        subplot(1,2,2), subimage(uint8(rez));
    imwrite(uint8(rez),[nume '-eh.' tip],tip);
end

function [r]=egalizare_plan(plan)
    % egalizarea histogramei pentru un plan
    % I: plan - planul pe care se lucreaza
    % E: r - planul modificat
    
    [m,n]=size(plan);
    L=255;
    h=zeros(1,L+1);
    for i=1:m
        for j=1:n
            h(plan(i,j)+1)=h(plan(i,j)+1)+1;
        end;
    end;
    h=h/(m*n);
    r=zeros(m,n);
    for i=1:m
        for j=1:n
            r(i,j)=L*sum(h(1:plan(i,j)));
        end;
    end;
end

