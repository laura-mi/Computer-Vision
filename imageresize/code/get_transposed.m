function imgT = get_transposed(img)

	x = size(img, 2);
	y =  size(img, 1);
	z =  size(img, 3);
    imgT = uint8(zeros(x,y,z));    
	
	%copy the image on colors
    for k=1:3
        imgT(:,:,k) = transpose(img(:,:,k));
    end
	
end