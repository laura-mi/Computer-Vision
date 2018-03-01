function path = selectVerticalPathAndRemoveObject(img,E,x_up,x_dn,y_left,y_right)

	sizeOf = size(E);
    path = zeros(size(E,1), 2);    
    path_values = zeros(sizeOf);
    directions = zeros(sizeOf);
	indices = zeros(sizeOf);
	n = size(E, 1);
    m = size(E, 2);
	
    for i=1:m
        path_values(1, i) = E(1, i);
    end
      
    [path_values,indices,directions] = calculateSeamEnergy(img,E,path_values,directions,2,x_up,1,m,indices);   
    [path_values,indices,directions] = calculateSeamEnergy(img,E,path_values,directions,x_up+1,x_dn,y_left,y_right,indices);
    indices(x_dn:n, 1:m) = 1;
    indices(x_dn,y_left:y_right) = 0;    
    [path_values,indices,directions] = calculateSeamEnergy(img,E,path_values,directions,x_dn+1,n,1,m,indices);

    minimal = 0;
    minimal_index = -1;    
	
    for(i = 1:m)
        if(path_values(n,i) ~= 0)
            if(minimal_index == -1)
                minimal_index = i;
                minimal = path_values(n , i);
            else if path_values(n , i) < minimal
                    minimal_index = i;
                    minimal = path_values(n, i);
                end
            end
        end
    end
	
    path(n, :) = [n minimal_index];

    for i=n-1:-1:1
        column = path(i+1, 2);
        path(i,:) = [i, column + directions(i+1, column)];
    end
    
end