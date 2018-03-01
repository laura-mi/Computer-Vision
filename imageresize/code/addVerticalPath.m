function new_image = addVerticalPath(img,path)

x = size(img,1);
y = size(img,2)+1;
z = size(img,3);
new_image = zeros(x,y,z,'uint8');
n = size(new_image,1);
m = size(img,2);
n_old = size(img,1);
positions = [2,5,2];

%move data to left of the path
for i=1:n_old
	line = i; column = path(i, 2);       
	new_image(line,1:column,:) = img(line,1:column,:); new_image(line,(column+1):end,:) = img(line,column:end,:);
end

img = double(img);    
for i=1:n
	column = path(i,2);
	line = i;
	aux_pos = positions;
	
	if column == 1
		aux_pos(1) = 0;
	end
	
	if column == m
		aux_pos(3) = 0;
	end
	
	for j=1:3
		colors = aux_pos(2) * img(line, column, j);
		if aux_pos(1) ~= 0
			colors = colors + aux_pos(1) * img(line, column-1, j);
		end
		
		if aux_pos(3) ~= 0
			colors = colors + aux_pos(3) * img(line, column+1, j);
		end
		
		sum_colors = (aux_pos(1) +aux_pos(2)+ aux_pos(3))
		colors = colors/sum_colors;
		new_image(line, column+1, j) = uint8(colors);
	end
end

end