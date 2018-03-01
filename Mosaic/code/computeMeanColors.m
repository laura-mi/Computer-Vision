%============================================
function meanColors = computeMeanColors(image,nr_canale)

	if(nr_canale == 3)
		matContextR = zeros(size(image, 1), size(image, 2));
		matContextG = zeros(size(image, 1), size(image, 2));
		matContextB = zeros(size(image, 1), size(image, 2));

		matContextR(:,:) = double(image(:,:,1));
		matContextG(:,:) = double(image(:,:,2));
		matContextB(:,:) = double(image(:,:,3));
		
		meanR = mean(matContextR(:));
		meanG = mean(matContextG(:));
		meanB = mean(matContextB(:));
		
		meanColors = zeros(3,1);
		meanColors(1) = meanR;
		meanColors(2) = meanG;
		meanColors(3) = meanB;

	else
		matContext = zeros(size(image, 1), size(image, 2));
		matContext(:,:) = double(image(:,:,1));    
		meanColors = mean(matContext(:));
	end
end
%============================================