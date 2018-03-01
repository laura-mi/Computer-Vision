function params = incarcaPieseMozaic(params)
%citeste toate cele N piese folosite la mozaic din directorul corespunzator
%toate cele N imagini au aceeasi dimensiune H x W x C, unde:
%H = inaltime, W = latime, C = nr canale (C=1  gri, C=3 color)
%functia intoarce pieseMozaic = matrice H x W x C x N in params
%pieseMoziac(:,:,:,i) reprezinta piese numarul i 

fprintf('Incarcam piesele pentru mozaic din director \n');

%==================================================
allPictures = dir([params.numeDirector '*.' params.tipImagine]);

dimensiuneImagini = params.dimensiuneImagini;
h = dimensiuneImagini(1);
w = dimensiuneImagini(2);
n = length(allPictures);

pieseMozaic = uint8(zeros(h,w,params.nr_canale,n)); % trei canale de culoare pentru imagini color

for i = 1:n
    picture_name = [params.numeDirector allPictures(i).name];
    picture_def = imresize(imread(picture_name), dimensiuneImagini);
    if (params.nr_canale == 1)
        picture_def = rgb2gray(picture_def);
    end
    pieseMozaic(:,:,:,i) = picture_def;
end
%==================================================

%afiseaza primele 100 de piese ale mozaicului
if params.afiseazaPieseMozaic
    figure,title('Primele 100 de piese ale mozaicului sunt:');
    idxImg = 0;
    for i = 1:10
        for j = 1:10
            idxImg = idxImg + 1;
            subplot(10,10,idxImg);
            imshow(pieseMozaic(:,:,:,idxImg));
        end
    end
    drawnow;
    pause(2);
end

params.pieseMozaic = pieseMozaic;