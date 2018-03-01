%====================================
function img = maresteInaltime(img,numarPixeliInaltime,ploteazaDrum,culoareDrum)

	%Will simply use the transposed of the initial image
    imgT = get_transposed(img);
    imgT = maresteLatime(imgTransposed, numarPixeliInaltime, ploteazaDrum, culoareDrum);
    %re-copy the transposed image in the initial image.
	img = get_transposed(imgT);
	
end
%====================================