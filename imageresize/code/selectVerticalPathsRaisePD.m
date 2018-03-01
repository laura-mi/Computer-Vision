function path = selectVerticalPathsRaisePD(E,k)

    path = zeros(size(E,1),2,k);
    paths_values = zeros(size(E));
    directions = zeros(size(E));
	n = size(E, 1);
    m = size(E, 2);
	
	%pd initializing
    for(j=1:size(E, 2))
        paths_values(1, j) = E(1, j);
    end

	%pd computing
    for(i=2:size(E, 1))
        for(j=1:size(E, 2))
            column = j;
            is_left_available = 0;
            is_right_available = 0;
			direction = 0; 
            minimal = paths_values(i-1, j);

            if(column ~= 1)
                is_left_available = 1;
            end
			
            if(column ~= size(E, 2))
                is_right_available = 1;
            end            

            if(is_left_available == 1 && paths_values(i-1, j-1) < minimal)
                minimal = paths_values(i-1, j-1);
                direction = -1;
            end

            if(is_right_available == 1 && paths_values(i-1, j+1) < minimal)
                minimal = paths_values(i-1, j+1);
                direction = 1;
            end

            directions(i, j) = direction;
            paths_values(i, j) = minimal + E(i, j); 
        end
    end   
    
    k_index = get_first_kindex(paths_values(n,:), k);    
    
    for i=1:k
        path(n,:,i) = [n k_index(i)];
        
        for i=n-1:-1:1
            column = path(i+1, 2, i);
            path(i,:,i) = [i, column + directions(i+1, column)];
        end 
        
    end
end