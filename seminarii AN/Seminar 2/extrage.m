function [mesaj]=extrage(poza_o, poza_m)
    % extrage mesaj ascuns in poza, avind poza originala si cea modificata
    % poza color sau nuante de gri (bmp, png, gif numai pentru nuante de
    % gri)
    % I: poza (nume fisier poza originala), poza_m (nume fisier poza
    %          modificata)
    % E: mesaj (mesajul extras)
    
    IO=imread(poza_o);
    IM=imread(poza_m);
    
    mesaj='';
    [m,n,p]=size(IO);
    
    if p==1
        dif=IM-IO;
        for i=1:m
            for j=1:n
                if dif(i,j)
                    mesaj=[mesaj dif(i,j)+uint8('a')-1];
                    % disp([i j double(dif(i,j)+96)]);
                end;
            end;
        end;
    else
        for k=1:p
            dif=IM(:,:,k)-IO(:,:,k);
            for i=1:m
                for j=1:n
                    if dif(i,j)
                        mesaj=[mesaj dif(i,j)+uint8('a')-1];
                        % disp([i j double(dif(i,j)+96)]);
                    end;
                end;
            end;
        end;
    end;
end
    
