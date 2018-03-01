%proiect 1 REALIZAREA DE MOZAICURI
% Laura Mitrache - grupa 332
% Cerinta a


params.tipImagine = 'jpg';
params.afiseazaPieseMozaic = 0; %seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din director
%seteaza modul de aranjare a pieselor mozaicului; optiuni: 'aleator','caroiaj'
params.modAranjare = 'caroiaj';
%seteaza criteriul dupa care realizeze mozaicul; optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';
params.culoare = 'color';
params.nr_canale = 3;		
params.dimensiuneImagini = [35,35];
params.numarPieseMozaicOrizontala = 100;

params.numeDirector = '../data/cifarImages/bird/';

imgName = 'bird';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(100) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);
		
imgName = 'bird2';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(100) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);

params.numeDirector = '../data/cifarImages/cat/';
imgName = 'cat';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(100) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);


params.numeDirector = '../data/cifarImages/stefanPopescu/';
imgName = 'pug2';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(300) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);


params.numeDirector = '../data/cifarImages/deer/';
imgName = 'deer';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(100) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);


params.numeDirector = '../data/cifarImages/automobile/';
imgName = 'automobile';	
picture_name = char([imgName ' Criteriul D.Euclidiene ' num2str(100) '.jpg']);
params.imgReferinta = imread(['../data/tematice/' imgName '.jpg']);
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);	
imwrite(imgMozaic,picture_name);
	