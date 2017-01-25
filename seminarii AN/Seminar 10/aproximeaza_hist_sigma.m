function [miu,sigma] = aproximeaza_hist_sigma(sectiune)
	% aproximarea histogramei mediei si variantei dintr-o imagine relativ uniforma
    % imaginea este o sectiune a unei imagini ce urmeaza a fi filtrata
	% I: sectiune - fisierul care contine sectiunea de imagine
	% E: miu - media, 
    %    sigma - varianta
    %
	% exemple de apel
	%    [miu,sig]=aproximeaza_hist_sigma('sg1.tif');
    %    [miu,sig]=aproximeaza_hist_sigma('sg3.tif');
    %    [miu,sig]=aproximeaza_hist_sigma('car_sectiune_zgomot.png');
    
	J=imread(sectiune);
	[m,n,~]=size(J);
	f=double(J(:,:,1));
    
    % calcul si vizualizare histograma
	L=255;
	h=zeros(1,L+1);
	for i=1:m
		for j=1:n
			h(f(i,j)+1)=h(f(i,j)+1)+1;
		end;
	end;
	h=h/(m*n);
	figure
        i=1:L+1;
        p=plot(i,h(i));
        set(p,'Color','black','LineWidth',1.5);
	
    % calcul medie    
    miu=0;
	for i=1:L
		miu=miu+i*h(i);
	end;
    
    % calcul varianta
	sigma=0;
	for i=1:L
		sigma=sigma+((i-miu)^2)*h(i);
	end;
end

