function [path_values,indices,directions] = calculateSeamEnergy(img,E,path_values,directions,x_up,x_dn,y_left,y_right,indices)

for i=x_up:x_dn
	for j=y_left:y_right
	
		is_left = 0;
		is_right = 0;
		is_above = 0;

		if(indices(i-1, j) == 0)
			is_above = 1;
		end
		
		if(j ~= y_left && indices(i-1, j-1) == 0)
			is_left = 1;
		end
		
		if(j ~= y_right && indices(i-1, j+1) == 0)
			is_right = 1;
		end
			
		if(is_above == 1 || is_left == 1 || is_right == 1)
			
			direction = 0; 
			minimal = sum(sum(path_values)) + 1;
			
			if(is_above == 1 && path_values(i-1, j) < minimal)
				minimal = path_values(i-1, j);
				direction = 0;
			end

			if(is_left == 1 && path_values(i-1, j-1) < minimal)
			minimal = path_values(i-1, j-1);
				direction = -1;
			end

			if(is_right == 1 && path_values(i-1, j+1) < minimal)
				minimal = path_values(i-1, j+1);
				direction = 1;
			end

			indices(i, j) = 0;
			directions(i, j) = direction;
			path_values(i, j) = minimal + E(i, j);                  
		end
	end
end

end