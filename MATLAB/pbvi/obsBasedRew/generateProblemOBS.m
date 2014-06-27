function sampleProb = generateProblemOBS()

sampleProb.gamma = 0.9;
sampleProb.nrStates = 4;
sampleProb.nrActions = 4;
sampleProb.nrObservations = 5;
sampleProb.start = (1/4)*(ones(1,4));
sampleProb.observation = getSampleObs(4,5,4);
sampleProb.transition = getSampleTrans(4,5,4);
sampleProb.reward = getSampleReward(4,5,4);

end


function O = getSampleObs(nrstates,nrobs,nractions)

% O(s,a,o)

    O = zeros(nrstates,nractions,nrobs);

    for s=1:nrstates
        for a=1:nractions
            for o=1:nrobs
                if s==a
                    if s==o
                        O(s,a,o) = 0.9;
                    elseif o==nrobs
                        O(s,a,o) = 0.1;
                    else
                        O(s,a,o) = 0;
                    end
                else
                    if a==o
                        O(s,a,o) = 0.1;
                    elseif o==nrobs
                        O(s,a,o) = 0.9;
                    else
                        O(s,a,o) = 0;
                end
                
            end
        end
    end
    end



% O(1,1,1) = 0.9;
% O(1,1,2) = 0;
% O(1,1,3) = 0;
% O(1,1,4) = 0;
% O(1,1,5) = 0.1;
% O(
% 
% O(2,1,1) = 0;
% O(2,2,2) = 0.9;
% O(2,2,3) = 0;
% O(2,2,4) = 0;
% O(2,2,5) = 0.1;
% 
% O(2,1,1) = 0;
% O(2,1,2) = 0;
% O(3,1,3) = 0.9;
% O(3,1,4) = 0;
% O(1,1,5) = 0.1;
% 
% O(1,1,1) = 0;
% O(1,1,2) = 0;
% O(1,1,3) = 0;
% O(1,1,4) = 0.9;
% O(1,1,5) = 0.1;

end

function T = getSampleTrans(nrstates,nrobs,nractions)

%T(s,s,a)

T = (0.1)*ones(nrstates,nrstates,nractions);

for s=1:nrstates
    for sp = 1:nrstates
        for a=1:nractions
            if s==sp
                T(s,sp,a) = 0.7;
            end
        end
    end
end

end

function R = getSampleReward(nrstates,nrobs,nractions)

R = zeros(nrstates,nractions);
R(1,1) = 1;
R(2,2) = 1;
R(3,3) = 1;
R(4,4) = 1;

end