function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

maxH=params.numarPieseMozaicVerticala;
maxW=params.numarPieseMozaicOrizontala;

borders = zeros(maxH,maxW);

nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
nrPieseAdaugate = 0;
nrVariantePiese = size(params.pieseMozaic, 4);

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic        
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
				i_up = i-1; j_up=j-1;
				if(i_up<1)i_up=i; end				
				if(j_up<1)j_up=1; end
				
				while(borders(i_up,j) == indice || borders(i,j_up)==indice)
					indice = randi(N);
				end
				
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
				borders(i,j) = indice; %imaginea aleasa la pozitiile i,j
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'       
		%===========================================
		meanPieces = zeros(params.nr_canale, nrVariantePiese);		
        for idxImg=1:nrVariantePiese
           meanPieces(:,idxImg) = computeMeanColors(params.pieseMozaic(:,:,:,idxImg),params.nr_canale);            
        end

        for i=1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
				
				%seteaza indici
				ih1 = (i-1)*H+1;
				ih2 = i*H;
				jw1 = (j-1)*W+1;
				jw2 = j*W;
				
				i_up = i-1; j_up=j-1;
				if(i_up<1)i_up=i; end				
				if(j_up<1)j_up=1; end	
				
				%distanta cea mai mica
				pickedPiece = 0;
                distance = 0.0;
				
				%imagini alaturate existente
				pieceBeforeOne = borders(i,j_up);
				pieceBeforeTwo = borders(i_up,j);
			
				meanColors = computeMeanColors(params.imgReferintaRedimensionata(ih1:ih2,jw1:jw2,:),params.nr_canale);     				
                
                
                for k=1:nrVariantePiese
				%	if(k ~= pieceBeforeOne && k~= pieceBeforeTwo)
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
				%	end   
                end
							
                imgMozaic(ih1:ih2,jw1:jw2,:) = params.pieseMozaic(:,:,:,pickedPiece);
				borders(i,j)=pickedPiece;
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100.0*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
        %===========================================    
    otherwise
        printf('EROARE, optiune necunoscuta \n');    
end
    