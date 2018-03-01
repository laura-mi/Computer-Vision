%proiect 1 REALIZAREA DE MOZAICURI
% Laura Mitrache - grupa 332

params.imgReferinta = imread('../data/imaginiTest/ferrari.jpeg'); %citeste imaginea care va fi transformata in mozaic
params.numeDirector = '../data/colectie/'; %seteaza directorul cu imaginile folosite la realizarea mozaicului
params.tipImagine = 'png';
params.afiseazaPieseMozaic = 0; %seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din director

%seteaza numarul de piese ale mozaicului pe orizontala, numarul de piese ale mozaicului pe verticala va fi dedus automat
params.numarPieseMozaicOrizontala = 100; 

%seteaza modul de aranjare a pieselor mozaicului; optiuni: 'aleator','caroiaj'
params.modAranjare = 'caroiaj';

%seteaza criteriul dupa care realizeze mozaicul; optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

params.dimensiuneImagini = [28,40];
params.culoare = 'color';
params.nr_canale = 3;
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);

imwrite(imgMozaic,'mozaic.jpg');
figure, imshow(imgMozaic)