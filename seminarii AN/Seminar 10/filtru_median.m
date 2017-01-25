function [B] = filtru_median(nume,d)
    % filtru median pentru eliminarea zgomotului, aplicind functia matlab 
    % medfilt2
    % I: nume - fisierul cu imaginea perturbata, monocroma sau color: se
    %           utilizaza doar primul plan, rezultatul va fi monocrom
    %    d - dimensiunea filtrului
    % E: B - imaginea filtrata (monocroma, un plan)
    
    I=imread(nume);
    B=medfilt2(I(:,:,1),[d d]);
end

