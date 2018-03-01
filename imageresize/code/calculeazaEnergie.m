function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru coordinates pentru a calcula gradientul in directia x si y
%calculati magnitudiena gradientului
%E - energia = gradientul imaginii

%====================================
gray = double(rgb2gray(img));

coordinates_x = [-1 0 1; -2 0 2; -1 0 1];
coordinates_y = [-1 -2 -1; 0 0 0; 1 2 1];
grad_x = imfilter(gray, coordinates_x);
grad_y = imfilter(gray, coordinates_y);

%Calculate energy
E = double(abs(grad_x)) + double(abs(grad_y));
%====================================