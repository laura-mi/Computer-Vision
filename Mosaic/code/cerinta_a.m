%proiect 1 REALIZAREA DE MOZAICURI
% Laura Mitrache - grupa 332
% Cerinta a

params.numeDirector = '../data/colectie/'; %seteaza directorul cu imaginile folosite la realizarea mozaicului
params.tipImagine = 'png';
params.afiseazaPieseMozaic = 0; %seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din director

%seteaza modul de aranjare a pieselor mozaicului; optiuni: 'aleator','caroiaj'
params.modAranjare = 'caroiaj';

%seteaza criteriul dupa care realizeze mozaicul; optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

params.dimensiuneImagini = [28,40];

numarPieseMozaicOrizontala = [100,75,50,25];
for i=1:size(numarPieseMozaicOrizontala, 2)   
	
		params.culoare = 'color';
		params.nr_canale = 3;
		params.numarPieseMozaicOrizontala = numarPieseMozaicOrizontala(i);
		
	imgName = 'ferrari';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpeg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
		
	imgName = 'liberty';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
	
	imgName = 'romania';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpeg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
		
	imgName = 'tomJerry';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpeg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
	
	params.culoare = 'grey';
	params.nr_canale = 1;
	
	imgName = 'adams';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
		
	imgName = 'obama';	
		picture_name = char([imgName ' DistantaCuloareMedie ' num2str(numarPieseMozaicOrizontala(i)) '.jpg']);
		params.imgReferinta = imread(['../data/imaginiTest/' imgName '.jpeg']);
		%apeleaza functia principala
		imgMozaic = construiesteMozaic(params);	
		imwrite(imgMozaic,picture_name);
end