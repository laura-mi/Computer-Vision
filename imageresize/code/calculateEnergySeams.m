function ret = calculateEnergySeams(img,E,dp,pred,linieSus,linieJos,coloanaStanga,coloanaDreapta,flags)

    for i=linieSus:linieJos
        for j=coloanaStanga:coloanaDreapta
            currentColumn = j;
            canComeFromLeft = 0;
            canComeFromRight = 0;
            canComeFromAbove = 0;

            if currentColumn ~= coloanaStanga && flags(i-1, currentColumn-1) == 0
                canComeFromLeft = 1;
            end
            
            if currentColumn ~= coloanaDreapta && flags(i-1, currentColumn+1) == 0
                canComeFromRight = 1;
            end
            
            if flags(i-1, currentColumn) == 0
                canComeFromAbove = 1;
            end
            
            if canComeFromAbove == 1 || canComeFromLeft == 1 || canComeFromRight == 1
                
                directionFromAbove = 0; % 0 = above, -1 = left, 1 = right
                minValueFromAbove = sum(sum(dp)) + 1;
                
                if canComeFromAbove == 1 && dp(i-1, j) < minValueFromAbove
                    minValueFromAbove = dp(i-1, j);
                    directionFromAbove = 0;
                end

                if canComeFromLeft == 1 && dp(i-1, j-1) < minValueFromAbove
                    minValueFromAbove = dp(i-1, j-1);
                    directionFromAbove = -1;
                end

                if canComeFromRight == 1 && dp(i-1, j+1) < minValueFromAbove
                    minValueFromAbove = dp(i-1, j+1);
                    directionFromAbove = 1;
                end

                flags(i, j) = 0;
                pred(i, j) = directionFromAbove;
                dp(i, j) = minValueFromAbove + E(i, j); 
                %img(i,j,:) = 0; %debug     
            end
        end
        %imshow(img); %debug
    end
    ret.dp = dp;
    ret.flags = flags;
    ret.pred = pred;
end