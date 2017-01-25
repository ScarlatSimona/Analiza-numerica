function [rez,vp,R,medie,er]=c_d(nrp,baza_nume,tip,nrc)
    % comprimarea unui set de imagini prin retinerea unui numar mic de
    % componente principale. imaginile sint in nuante de gri (1 singur
    % plan) si au toate aceeasi dimensiune
    % I: nrp - numarul de imagini, baza_nume - numele fisierelor e format
    %    pornind de la aceasta baza, tip - tipul fisierelor imagine, nrc -
    %    numarul de componente pastrate (<<m*n)
    % E: rez - cod de terminare a operatiei (0=succes, 1=imagini cu
    %    dimensiuni diferite, 2=imagini cu mai mult de un plan)
    %    er - eroarea medie pe pixel
    %    date reprezentind imaginile comprimate: vp - componentele
    %    principale (nrc*(m*n)), R - reprezentarea comprimata (nrc*nrp),
    %    medie - vectorul (imaginea) medie ((m*n)*1) 
    
    % exemplu de apel: [rez,~,~,~,er]=c_d(15,'ex','bmp',20);
    
    % incarcare imagini cu verificarea dimensiunilor si numarului de plane
    k=0;
    rez=0;
    while k<nrp && ~rez
        k=k+1;
        fi=[baza_nume num2str(k) '.' tip];
        poza=imread(fi);
        [m,n,p]=size(poza);
        if p>1
            rez=2;
        else
            if ~exist('imagini','var');
                imagini=uint8(zeros(m,n,nrp));
                m1=m;n1=n;
            end;
            if m~=m1 || n~=n1
                rez=1;
            else
                imagini(:,:,k)=poza;
                figure
                    imshow(imagini(:,:,k));
                    title(['Imaginea initiala ' num2str(k)]);
            end;
        end;
    end;
    
    if rez
        disp(['Imaginea ' num2str(k) 'nu corespunde']);
        if rez==1 
            disp('Dimensiuni diferite');
        else
            disp('Mai mult de un plan');
        end;
    else
        p=m*n;
        % liniarizarea imaginilor initiale pe linii
        im_lin=zeros(p,nrp);
        for k=1:nrp
            for i=1:m
                for j=1:n
                    im_lin(n*(i-1)+j, k)=double(imagini(i,j,k));
                end;
            end;
        end;
        
        % calcul medie si centrare date
        medie=mean(im_lin,2);
        for k=1:nrp
            im_lin(:,k)=im_lin(:,k)-medie;
        end;
        
        % matricea de covarianta de selectie
        ss=zeros(p,p);
        for k=1:nrp
            ss = ss + im_lin(:,k) * (im_lin(:,k).');
        end;
        ss=ss/(nrp-1);
        
        % disp(['Dimensiune initiala: ' num2str(p)]);
        % disp(['Dimensiune redusa  : ' num2str(nrc)]);
        
        % determinarea componentelor principale si retinerea primelor nrc
        [V,L]=eig(ss);
        vp=V(:, p : -1 : p-nrc+1);
		valp=diag(L);
		er=sum(valp(1:p-nrc))/(m*n*nrp);
        
        % reprezentarea folosind doar componentele retinute
        R=zeros(nrc,nrp);
        for k=1:nrp
            R(:,k)=vp' * im_lin(:,k);
        end;
        
        % reconstructia imaginilor din reprezentarea cu componentele princ.
        im_noi_l=zeros(p,nrp);
        for k=1:nrp
            im_noi_l(:,k)=vp * R(:,k);
        end;
        
        % adaugare medie si revenire la forma matriceala
        im_noi=uint8(zeros(m,n,nrp));
        for k=1:nrp
            for i=1:m
                for j=1:n
                    im_noi(i,j,k)=uint8( im_noi_l((i-1)*n+j,k) + medie((i-1)*n+j) );
                end;
            end;
            figure
                imshow( im_noi(:,:,k) );
                title(['Imaginea ' num2str(k) ' reconstruita']);
			fo=[baza_nume num2str(k) '_r.' tip];
            imwrite(im_noi(:,:,k),fo,tip);
        end;
    end;
end
                
        