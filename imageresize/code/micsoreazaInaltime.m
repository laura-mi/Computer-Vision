%=========================================
function img = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)
	
	%Will simply use the transposed of the initial image
    imgT = get_transposed(img);
    imgT = micsoreazaLatime(imgT,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum);
    %re-copy the transposed image in the initial image.
	img = get_transposed(imgT);
	
end
%=========================================