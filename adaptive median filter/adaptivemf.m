function [] = adaptivemf(numeimg,smax)
%  adaptivemf('lennaa.bmp',10);
I = imread(numeimg);
[x,y,p] = size(I);
if(p>1)
    I = rgb2gray(I);
end
    figure; 
    subplot(1,4,1); imshow(I); title('Imaginea initiala');
%img perturbata
    IZGM = imnoise(I,'salt & pepper',0.25);
    subplot(1,4,2); imshow(uint8(IZGM)); title('Imaginea perturbata cu zgomot');
    IMED = medfilt2(IZGM, [3,3]);
    subplot(1,4,3); imshow(uint8(IMED)); title('Imaginea cu zgomot nivelata w=[5,5]');
    IMGADDPADD = im2uint8(zeros(x+smax,y+smax));
    IMGADDPADD(6:x+5,6:y+5) = IMGADDPADD(6:x+5,6:y+5)+IMED;
    for i=6:x-5
         for j=6:y-5
             sx = 3;
             sy = 3;
          while((sx <= smax) && (sy<=smax))
              imgMin = IMGADDPADD(i,j);
              imgMax = IMGADDPADD(i,j);
              J = IMGADDPADD(((i-floor(sx/2)):(i+floor(sx/2))),((j-floor(sy/2)):(j+floor(sy/2))));
              imgMed = median(median(J));
              for k = (i-floor(sx/2)):(i+floor(sx/2))
                  for l = (j-floor(sy/2)):(j+floor(sy/2))
                      if (IMGADDPADD(k,l) < imgMin)
                          imgMin = IMGADDPADD(k,l);
                      end
                      if (IMGADDPADD(k,l) > imgMax)
                          imgMax = IMGADDPADD(k,l);
                      end
                  end 
              end
              A = imgMed - imgMin;
              B = imgMed - imgMax;
              if (A>0 && B<0)
                  C = IMGADDPADD(i,j) - imgMin;
                  D = IMGADDPADD(i) - imgMax;
                  if(C>0 && D<0)
                      temp(i,j) = IMGADDPADD(i,j);
                  break;
                  else
                      IMGADDPADD(i,j) = imgMed;
                      break;
                  end
              else
                  sx=sx+2;
                  sy=sy+2;
                  if(sx>smax && sy>smax)
                      IMGADDPADD(i,j)=IMGADDPADD(i,j);
                  end
              end
          end
         end
    end
    subplot(1,4,4); imshow(uint8(IMGADDPADD));title('Imaginea procesata');
end