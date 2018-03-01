function d = selecteazaDrumVerticalPD(d,E)

paths = zeros(size(E)); %matrix used to compute the right path using dynamic programming
paths_direction = zeros(size(E));

%Initialize dynamic programming matrix
for i=1:size(E, 2)
	paths(1, i) = E(1, i);
end

for i=2:size(E, 1)
	for j=1:size(E, 2)
	
		column = j;
		is_left_available = 0;
		is_right_available = 0;
		direction = 0; % 0 = above, -1 = left, 1 = right
		minimal = paths(i-1, j);
		
		if column ~= 1
			is_left_available = 1;
		end
		if column ~= size(E, 2)
			is_right_available = 1;
		end	
		
		if is_left_available == 1 && paths(i-1, j-1) < minimal
			minimal = paths(i-1, j-1);
			direction = -1;
		end
		
		if is_right_available == 1 && paths(i-1, j+1) < minimal
			minimal = paths(i-1, j+1);
			direction = 1;
		end
		
		paths_direction(i, j) = direction;
		paths(i, j) = minimal + E(i, j); 
	end
end

minimal = 0;
minimal_index = -1;
n = size(E, 1);
m = size(E, 2);
for i = 1:m
	if minimal_index == -1
		minimal_index = i;
		minimal = paths(n, i);
	else if paths(n, i) < minimal
			minimal_index = i;
			minimal = paths(n, i);
		end
	end
end
d(n, :) = [n minimal_index];

for i=n-1:-1:1
	column = d(i+1, 2);
	d(i,:) = [i, column + paths_direction(i+1, column)];
end

end
