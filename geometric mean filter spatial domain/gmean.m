function [] = gmean(numeimg)
% numeimg - numele imaginii ce se doreste a fi prelucrata
% gmean('lennaa.bmp');
I = imread(numeimg);
    figure; subplot(1,3,1); imshow(I); title('Imaginea initiala');
f = perturba_motion_noise_MDiscret(numeimg,5,20);
    subplot(1,3,2); imshow(f); title('Imaginea perturbata cu zgomot');
f = im2double(f);
[m,n]=size(f);
si=1;
    for i = 1:m
        for j = 1:n 
            con=0; s1=1;
                for k1 = i-si:i+si
                     for p1 = j-si:j+si
                        if ((k1 > 0 && p1 > 0) && (k1 < m && p1 < n ))
                            con = con+1;
                            s1=s1*f(k1,p1);
                        end
                     end
                end
            b1(i,j)=s1^(1/con);
        end 
    end
    subplot(1,3,3); imshow(b1); 
    title('Filtru medie geometrica');
end