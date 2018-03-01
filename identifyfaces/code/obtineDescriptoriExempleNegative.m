function descriptoriExempleNegative = obtineDescriptoriExempleNegative(parametri)
% descriptoriExempleNegative = matrice MxD, unde:
%   M = numarul de exemple negative de antrenare (NU sunt fete de oameni),
%   M = parametri.numarExempleNegative
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExempleNegative , '*.jpg' ));
numarImagini = length(imgFiles);

numarExempleNegative_pe_imagine = round(parametri.numarExempleNegative/numarImagini);
dimension = (parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula;
descriptoriExempleNegative = zeros(parametri.numarExempleNegative,dimension);
disp(['Exista un numar de imagini = ' num2str(numarImagini) ' ce contine numai exemple negative']);
for idx = 1:numarImagini
    disp(['Procesam imaginea numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExempleNegative '/' imgFiles(idx).name]);
    if size(img,3) == 3
        img = rgb2gray(img);
    end 
    %completati codul functiei in continuare
    image = single(img);
	[h,w]=size(image);
	
	for ind2 = 1:numarExempleNegative_pe_imagine
			disp(['Procesam sub-imaginea numarul ' num2str(ind2) ' pentru imaginea ' num2str(idx)]);
	        x = ceil(rand() * (w - parametri.dimensiuneFereastra));
	        y = ceil(rand() * (h - parametri.dimensiuneFereastra));
	        i = (idx - 1) .* numarExempleNegative_pe_imagine + ind2;
	        selected_area = image(y : y + parametri.dimensiuneFereastra - 1, x : x + parametri.dimensiuneFereastra - 1);
	        descriptoriExempleNegative(i, :) = reshape(vl_hog(selected_area, parametri.dimensiuneCelulaHOG), 1, dimension);
	 end
	
end