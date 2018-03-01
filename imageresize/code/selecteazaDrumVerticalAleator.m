function d = selecteazaDrumVerticalAleator(d,E)

	%pentru linia 1 alegem primul pixel in mod aleator
	linia = 1;
	%coloana o alegem intre 1 si size(E,2)
	coloana = randi(size(E,2));
	%punem in d linia si coloana coresponzatoare pixelului
	d(1,:) = [linia coloana];
	for i = 2:size(d,1)
		%alege urmatorul pixel pe baza vecinilor
		%linia este i
		linia = i;
		%coloana depinde de coloana pixelului anterior
		if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
			%doua optiuni
			optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
		elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
			%doua optiuni
			optiune = randi(2) - 2; %genereaza -1 sau 0
		else
			optiune = randi(3)-2; % genereaza -1, 0 sau 1
		end
		coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
									 % merg la stanga, dreapta sau stau pe loc
		d(i,:) = [linia coloana];
	end

end