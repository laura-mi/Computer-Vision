%Implementarea a proiectului Redimensionare imagini
%dupa articolul "Seam Carving for Content-Aware Image Resizing", autori S.
%Avidan si A. Shamir 
%%
%aceasta functie ruleaza intregul proiect 
%setati parametri si imaginile de redimensionat aici

%citeste o imagine
img = imread('..\data\lac.jpg');

%reducem imaginea in latime cu 50 de pixeli
%seteaza parametri
parametri.optiuneRedimensionare = 'eliminaObiect';
parametri.numarPixeliLatime = 50;
parametri.numarPixeliInaltime = 50;
parametri.ploteazaDrum = 0;
parametri.culoareDrum = [255 0 0]';%culoarea rosie
parametri.metodaSelectareDrum = 'greedy';%optiuni posibile: 'aleator','greedy','programareDinamica'
figure;
imshow(img);
rect = getrect;
parametri.dreptunghi = rect;

imgRedimensionata_proiect = redimensioneazaImagine(img,parametri); 

%foloseste functia imresize pentru redimensionare traditionala
imgRedimensionata_traditional = imresize(img,[ size(imgRedimensionata_proiect,1) size(imgRedimensionata_proiect,2)]);

%ploteaza imaginile obtinute
figure, hold on;

%1. imaginea initiala
h1 = subplot(1,3,1);
imshow(img);
xsize = get(h1,'XLim');
ysize = get(h1,'YLim');
xlabel('imaginea initiala');
imwrite(img, char(['1.4 Imaginea initiala lac.jpg']));

%2. imaginea redimensionata cu pastrarea continutului
h2 = subplot(1,3,2);
imshow(imgRedimensionata_proiect);
set(h2, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul nostru');
imwrite(imgRedimensionata_proiect, char(['1.4 Imaginea ObiectEliminat lac.jpg']));

%3. imaginea obtinuta prin redimensionare traditionala
h3 = subplot(1,3,3);
imshow(imgRedimensionata_traditional);
set(h3, 'xlim', xsize, 'ylim', ysize);
xlabel('rezultatul imresize');
imwrite(imgRedimensionata_traditional, char(['1.4 imaginea imresize lac.jpg']));