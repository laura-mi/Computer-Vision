function d = selecteazaDrumVerticalGreedy(d,E)

%Initialize data
line = 1;
minimal = 0;
minimal_index = -1;

for i=1:size(E, 2)
	if minimal_index == -1
		minimal_index = i;
		minimal = E(1, i);
	else if E(1,i) < minimal
		minimal = E(1, i);
		minimal_index = i;
		end
	end
end
	
column = minimal_index;
d(1,:) = [line column];
	
for (i=2:size(E,1))
%initializing step
	line = i;
	line_before = d(i-1, 1);
	column_before = d(i-1, 2);
	column = column_before;
	minimal = E(line, column);
	is_left_available = 0;
	is_right_available = 0;
	
%check points. decisional step
	if (column_before ~= 1)
		is_left_available = 1;
	end
	
	if (column_before ~= size(E, 2))
		is_right_available = 1;
	end
	
	if (is_left_available == 1 && E(i, column_before - 1) < minimal)
		minimal = E(i, column_before - 1);
		column = column_before - 1;
	end
	
	if (is_right_available == 1 && E(i, column_before + 1) < minimal)
		minimal = E(i, column_before + 1);
		column = column_before + 1;
	end

%greedy final step
	d(i,:) = [line column];
end

end