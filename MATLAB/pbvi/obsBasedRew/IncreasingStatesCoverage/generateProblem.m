function sampleProb = generateProblem(nrst)

nrstates = nrst;
nrobs = nrst + 1;
nractions = nrst^2;
sampleProb.gamma = 1;
sampleProb.nrStates = nrstates;
sampleProb.nrActions = nractions;
sampleProb.nrObservations = nrobs;
sampleProb.start = 1/nrst*(ones(1,nrst));
sampleProb.observation = getSampleObs(nrstates,nrobs,nractions);
sampleProb.transition = getSampleTrans(nrstates,nrobs,nractions);
sampleProb.reward = getSampleReward(nrstates,nrobs,nractions);

end

function O = getSampleObs(nrstates,nrobs,nractions)

% a1 = pred 1 + obs 1; a2 = pred 2 + obs 1 ....


    numtoadd = nrstates;    
    O = zeros(nrstates,nractions,nrobs);

    for s = 1:nrstates
        minActionBrac = (s-1)*nrstates;
        maxActionBrac = minActionBrac + numtoadd + 1;
        for a = 1:nractions
            for o = 1:nrobs
            
                if a<maxActionBrac && a>minActionBrac
                    if s==o
                        O(s,a,o) = 0.95;
                    elseif o==nrobs
                        O(s,a,o) = 0.05;
                    else
                        O(s,a,o) = 0;
                    end
                else
                    t = rem(a,nrstates);
                    if t==0
                        comp = floor(a/nrstates);
                    else
                        comp = floor(a/nrstates) + 1;  
                    end 
                    if o==comp
                        O(s,a,o) = 0.05;
                    elseif o==nrobs
                        O(s,a,o) = 0.95;
                    else 
                        O(s,a,o) = 0;
                    end
                end
            end
        end
    end
end


function defTxn = getTxn(i,j,sameStateTxn,nrstates)
    
if i==1 || i==nrstates
    defTxn = (1-sameStateTxn);
else
    defTxn = (1-sameStateTxn)/2;
end


end


function T = getSampleTrans(nrstates,nrobs,nractions)

sameStateTxn = 0.7;
%defTxn = (1 - sameStateTxn)/(1);
defTxn = 0.3;

numtoadd = nrstates;

    for i = 1:nrstates
        for j=1:nrstates
            for k = 1:nractions
                if i==j
                    T(i,j,k) = sameStateTxn;
                elseif (j-i)==1 || (i-j)==(nrstates-1)
                    %T(i,j,k) = getTxn(i,j,sameStateTxn,nrstates);
                    T(i,j,k) = defTxn;
                else
                    T(i,j,k) = 0;
                end
            end
        end
    end
    
end



function R = getSampleReward(nrstates,nrobs,nractions)


    function remm = get_remm(j,nrstates)
        if rem(j,nrstates) == 0 
            remm=nrstates;
        else
            remm = rem(j,nrstates);
        end
    end


R = zeros(nrstates,nractions);

for i=1:nrstates
    for j=1:nractions
        remm = get_remm(j,nrstates);
        if remm==i
            R(i,j) = 1;
        else
            R(i,j) = 0;
        end
    end
end

end

