function newSampleProblemIR = generateProblemIR(nrst)

%nrst = 4;
nrstates = nrst;
nractionsN = nrst;
nractionsP = nrst;
nrobs = nrst + 1;
newSampleProblemIR.gamma = 1;
newSampleProblemIR.nrStates = nrstates;
newSampleProblemIR.nrActionsN = nractionsN;
newSampleProblemIR.nrActionsP = nractionsP;
newSampleProblemIR.nrObservations = nrobs;
newSampleProblemIR.start = (1/nrst)*(ones(1,nrst));
%newSampleProblemIR.start = [0.9,0.1,0,0];
newSampleProblemIR.observation = getSampleObsIR(nrstates,nractionsN,nrobs);
newSampleProblemIR.transition = getSampleTransIR(nrstates,nractionsN);
newSampleProblemIR.reward = getSampleRewardIR(nrstates,nractionsP);

end

function O = getSampleObsIR(nrstates,nractions,nrobs)

    O = zeros(nrstates,nractions,nrobs);
    for s = 1:nrstates
        for a = 1:nractions
            for o = 1:nrobs
                
%                 if a==o
%                     if s==a
%                         O(s,a,o) = 0.91;
%                     else
%                         O(s,a,o) = 0.03;
%                     end
%                 elseif o==nrobs
%                     if s==a
%                         O(s,a,o) = 0.1;
%                     else
%                         O(s,a,o) = 0.3;
%                     end
%                 end
%                 
                
                
                
                
                if s==a
                    if s==o
                        O(s,a,o) = 0.9;
                    elseif o==nrobs
                        O(s,a,o) = 0.1;
                    end
                else
                    if a==o
                        O(s,a,o) = 0.1;
                    else
                        O(s,a,nrobs) = 0.9;
                    end
                    
                end
            end
        end
    end
end


function T = getSampleTransIR(nrstates,nractions)

    sameStateTxn = 0.7;
    defTxn = (1-sameStateTxn)/(nrstates-1);

    T = zeros(nrstates,nrstates,nractions);
    for i = 1:nrstates
        for j = 1:nrstates
            for k = 1:nractions
                if i==j
                    T(i,j,k) = sameStateTxn;
                else
                    T(i,j,k) = defTxn;
                end
            end
        end
    end
    
end

function R = getSampleRewardIR(nrstates,nractions)

    R = zeros(nrstates,nractions);
    for s = 1:nrstates
        for a = 1:nractions
            if s==a
                R(s,a) = 1;
            else
                R(s,a) = 0;
            end
        end
    end
end