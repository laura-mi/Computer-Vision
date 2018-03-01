function path = selectVerticalPathsRaise(img, k)

    lines = size(img, 1);
    path = zeros(lines, 2, k);
	aux = zeros(k, lines);
    
    for i=1:k
        E = calculeazaEnergie(img);
        minimal_path = selectVerticalPathsRaisePD(E, 1);
        path(:,:,i) = minimal_path;        
        minimal_path = zeros(lines, 2);
        minimal_path(:,:) = path(:,:,i);        
        img = eliminaDrumVertical(img, minimal_path);       
    end 
        
    for i=2:k
        for j=1:(i-1)
            for line=1:lines
                if path(line, 2, i) >= path(line, 2, j)
                    aux(i,line) = aux(i,line) + 1;
                end
            end
        end
    end
    
    for i=1:k
		path(:,2,i) = path(:,2,i) + aux(i, :)';
    end
    
end