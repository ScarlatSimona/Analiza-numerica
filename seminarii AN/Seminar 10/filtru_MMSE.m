function [rez] = filtru_MMSE(perturbata,sectiune,d)
    % filtru median adaptiv (MMSE); foloseste o sectiune de imagine pentru
    % estimarea caracteristicilor zgomotului
    % I: perturbata - imagine perturbata, monocroma sau color (foloseste
    %                 doar primul plan)
    %    sectiune - sectiune din imagine (monocrom) folosita pentru estimarea 
    %               zgomotului
    %    d - dimensiune filtru
    % E: rez - imagine filtrata
    % exemple de apel
    %    [rez]=filtru_MMSE('im1g.tif','sg1.tif',3);
    %    [rez]=filtru_MMSE('car_zgomot_GN.png','car_sectiune_zgomot.png',3);
    
    I=imread(perturbata);
    [m,n,~]=size(I);
    l=m+d-1;
    c=n+d-1;
    t=(d+1)/2;
    fc=zeros(l,c);
    fc(t:m+t-1,t:n+t-1)=double(I(:,:,1));
    g=zeros(l,c);
    
    % estimare parametri zgomot
    [~,sigma]=aproximeaza_hist_sigma(sectiune);
    
    % filtrare MMSE
    for x=1:m
        for y=1:n
            r=fc(x:x+d-1,y:y+d-1);
            xx=reshape(r,[d*d,1]);
            miuloc=mean(xx);
            sigmaloc=var(xx);
            % daca sigma local < sigma estimat (global) raportul ia
            % valoarea 1
            if(sigmaloc<sigma)
                val=1;
            else
                val=sigma/sigmaloc;
            end;
            g(x+t-1,y+t-1)=fc(x+t-1,y+t-1)-val*(fc(x+t-1,y+t-1)-miuloc);
        end;
    end;
    rez=uint8(g(t:m+t-1,t:n+t-1));
end

