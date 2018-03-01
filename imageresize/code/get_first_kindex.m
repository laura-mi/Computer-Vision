function k_index = get_first_kindex(array, k)

    k_index = zeros(1, k);
    s_array = sort(array);
	
    for i=1:k
        for j=1:length(array)
            if(s_array(i) == array(j))
                k_index(i) = j;
                array(j) = max(array) + 1;
                break;
            end
        end
    end
	
end