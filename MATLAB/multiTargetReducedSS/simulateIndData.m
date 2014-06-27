function [rTrackMatrix,obsTrackMatrixLook] = simulateIndData(nPpl,nSteps,nGrids,pomdp)

    trackMatrix = zeros(nPpl,nSteps);
    for i = 1:nPpl
        
        rTrackMatrix(i,:) = simulateData(nSteps,nGrids);
    end
    obsTrackMatrixLook = simulateObs(nPpl,pomdp,rTrackMatrix);
end

function [obsTrackMatrixLook]= simulateObs(nPpl,pomdp,rTrackMatrix)

    %nrPpl = pomdp.nrPpl
    O = pomdp.observation;
    nrObs = pomdp.nrObservations;
    obsTrackMatrixLook = rTrackMatrix;
    [nrPpl,nrSteps] = size(obsTrackMatrixLook);
    for i =1:nrPpl
        rTr = rTrackMatrix(i,:);
        for j = 1:nrSteps
            s = rTr(j);  
            thres = max(O(s,:,s)); 
            pRightObs = rand(1);
            if pRightObs < thres
                obsTrackMatrixLook(i,j) = rTrackMatrix(i,j);
            else
                obsTrackMatrixLook(i,j) = nrObs;
            end            
        end
    end
end
