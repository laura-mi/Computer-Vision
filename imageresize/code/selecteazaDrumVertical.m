function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

	d = zeros(size(E,1),2);

	switch metodaSelectareDrum
		case 'aleator'
		   d = selecteazaDrumVerticalAleator(d,E);   
		case 'greedy'
			d = selecteazaDrumVerticalGreedy(d,E);        
			
		case 'programareDinamica'
			d = selecteazaDrumVerticalPD(d,E);      
			
		otherwise
			error('Optiune pentru metodaSelectareDrum invalida');
	end

end