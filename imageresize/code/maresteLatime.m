%====================================
function img = maresteLatime(img,numarPixeliLatime,ploteazaDrum,culoareDrum)

%pick vertical path
paths = selectVerticalPathsRaise(img, numarPixeliLatime);

	fo(i = 1:numarPixeliLatime)
		
		disp(['Adding the vertical path nr.' num2str(i) ...
			' from ' num2str(numarPixeliLatime)]);
		
		%show paths
		if ploteazaDrum
			ploteazaDrumVertical(img,-1,paths(:,:,i),culoareDrum);			
		end
		
		%add path in imagine
		img = addVerticalPath(img,paths(:,:,i));
		
		index = i;
		%edit the path
		for i_aux=(index+1):size(paths,3)
			for j=1:size(paths,1)
				if paths(j,2,i_aux) > paths(j,2,index)
					paths(j, 2, i_aux) = paths(j, 2, i_aux) + 1;
				end
			end       
		end
		
	end
end
%====================================