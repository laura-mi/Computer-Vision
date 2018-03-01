function imgMozaic = adaugaPieseMozaicModAleator(params)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

hg = params.numarPieseMozaicVerticala * H;
wd = params.numarPieseMozaicOrizontala * W;
visited = zeros([hg,wd]);

nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala * 4;
nrPieseAdaugate = 0;
nrVariantePiese = size(params.pieseMozaic, 4);


switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        for k=1:nrTotalPiese
			indice = randi(N);	
			i = randi(hg);
			j = randi(wd);	
			while(visited(i,j) == 1)
				i = randi(hg);
				j = randi(wd);
			end
			visited(i,j)=1;
			
			ih1=i;
			ih2=i+H-1;
			jw1=j;
			jw2=j+W-1;
			
			imgMozaic(ih1:ih2,jw1:jw2,:) = params.pieseMozaic(:,:,:,indice);
            nrPieseAdaugate = nrPieseAdaugate+1;
			fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
		end
        
    case 'distantaCuloareMedie'
		%===========================================
		meanPieces = zeros(params.nr_canale, nrVariantePiese);		
        for idxImg=1:nrVariantePiese
           meanPieces(:,idxImg) = computeMeanColors(params.pieseMozaic(:,:,:,idxImg),params.nr_canale);            
        end
		
        for iterator = 1:(nrTotalPiese)
			
			%seteaza indici
			i = randi(hg);
			j = randi(wd);	
			while(visited(i,j) == 1)
				i = randi(hg);
				j = randi(wd);
			end
			visited(i,j)=1;
			
			ih1=int32(i);
			ih2=int32(i+H-1);			
			jw1=int32(j);
			jw2=int32(j+W-1);
			
			if(ih2 > hg) ih2 = hg; end
			if(jw2 > wd) jw2 = wd; end
			
			%distanta cea mai mica
			pickedPiece = 0;
			distance = 0.0;
            
			meanColors = computeMeanColors(params.imgReferintaRedimensionata(ih1:ih2,jw1:jw2,:),params.nr_canale);     				
                			

			for k=1:nrVariantePiese
				currentDistance = sum((meanColors-meanPieces(:,k)).^2); %Distanta Euclidiana
				if pickedPiece == 0
					pickedPiece = k;
					distance = currentDistance;
				else
					if currentDistance < distance
						pickedPiece = k;
						distance = currentDistance;
					end
				end
				 
			end
			imgMozaic(ih1:ih2,jw1:jw2,:) = params.pieseMozaic(1:(ih2-ih1+1),1:(jw2-jw1+1),:,pickedPiece);               
			nrPieseAdaugate = nrPieseAdaugate+1;
			fprintf('Construim mozaic ... %2.2f%% \n',100.0*nrPieseAdaugate/nrTotalPiese);
            
        end
        
        %===========================================    
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end
    

