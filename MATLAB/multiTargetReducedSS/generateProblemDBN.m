function [] = generateProblemDBN(nrGrids, nrPpl)

    nrStateVar = nrPpl;
    domStateVar = nrGrids;
    nrActionNVar = 1;
    domActionNVar = nrGrids;
    nrObsVar = nrPpl;
    domObsVar = nrGrids + 1;
    nrActionPVar = nrPpl;
    domActionPVar = nrGrids;
    problem.gamma = 1;    
    
end

function T = dbnTrans(nrGrids)

    nrAdjstt = 2;
    sameSttTxn = 0.7;
    adjSttTxn = (1-sameSttTxn)/nrAdjStt;
    for i = 1:nrGrids
        for j = 1:nrGrids
            if (i==j)
                T(i,j) = sameSttTxn;
            elseif (abs(i-j)==1) || (abs(i-j)==(nrGrids-1))
                T(i,j) = adjSttTxn;
            else
                T(i,j) = 0;
            end
        end
    end
end


function O = dbnObs(nrGrids)

    


end
