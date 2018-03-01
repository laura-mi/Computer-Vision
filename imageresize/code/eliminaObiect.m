%====================================
function img = eliminaObiect(img,rect,plot,color)

	pixels = rect(3);
    x_up = rect(2);
	x_dn = x_up + rect(4)-1;
    y_left = rect(1);
    y_right = y_left + rect(3)-1;     
       
    for i = 1:pixels 
        disp(['Remove vertical path nr ' num2str(i) ...
            ' from ' num2str(pixels)]);
        E = calculeazaEnergie(img);

        path = selectVerticalPathAndRemoveObject(1,E,int32(x_up),int32(x_dn),int32(y_left),int32(y_right));
        y_right = y_right - 1;
        
        %show path
        if plot
            plotVertical(img,E,path,color);
            pause(1);
            close(gcf);
        end

        %remove path
        img = eliminaDrumVertical(img,path);
    end    
end
%====================================