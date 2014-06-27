function sampleProb = generateProblemLO(nrst)

nrstates = nrst;
nrobs = nrstates + 1;
nractions = nrst;
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

    O = zeros(nrstates,nractions,nrobs);
    for s = 1:nrstates
        for a = 1:nractions
            for o = 1:nrobs
                
                if s==a
                    if a==o
                        O(s,a,o) = 0.95;
                    elseif o==nrobs
                        O(s,a,o) = 0.05;
                    end
                else
                    if a==o
                        O(s,a,o) = 0.05;
                    elseif o==nrobs
                        O(s,a,nrobs) = 0.95;
                    end 
                end
            end
        end
    end
    
    for s = 1:nrstates
        for a = 1:nractions
            for o = 1:nrobs
                if a==1
                    if s==1
                        if s==o
                            O(s,a,o) = 0.75;
                        elseif o==nrobs
                            O(s,a,o) = 0.25;
                        end
                    else
                        if a==o
                            O(s,a,o) = 0.15;
                        elseif o==nrobs
                            O(s,a,o) = 0.85;
                        end
                    end    
                end
            end
        end
    end
    
end

 
function T = getSampleTrans(nrstates,nrobs,nractions)

sameStateTxn = 0.3;
defTxn1 = 0.35;
defTxn2 = 0;

numtoadd = nrstates;

    for i = 1:nrstates
        for j=1:nrstates
            for k = 1:nractions
                if i==j
                    T(i,j,k) = sameStateTxn;
                elseif abs(i-j)==1 || abs(i-j)==(nrstates-1)
                    %T(i,j,k) = getTxn(i,j,sameStateTxn,nrstates);
                    T(i,j,k) = defTxn1;
                elseif abs(i-j)==2 || abs(i-j)==(nrstates-2)
                    T(i,j,k) = defTxn2;
                else
                    T(i,j,k) = 0;
                end
            end
        end
    end

end


function Onew = getNewSampleObs(T,O)

    [nrstates,nractions,nrobs] = size(O);
    Onew = zeros(nrstates,nractions,nrobs);
    for sd = 1:nrstates
        for a = 1:nractions
            for o = 1:nrobs
                Onew(nrstates,nractions,nrobs);
                
                for s = 1:nrstates
                    
                    probTsds = T(s,sd,a);
                    probOGs = O(s,a,o);
                    Onew(sd,a,o) = Onew(sd,a,o) + probTsds*probOGs;
                    
                    %pause
                    
                end
                
            end
        end 
    end
end



% function T = getSampleTrans(nrstates,nrobs,nractions)
% 
% sameStateTxn = 0.7;
% defTxn = (1 - sameStateTxn)/(nrstates-1);
% numtoadd = nrstates;
% 
%     for i = 1:nrstates
%         for j=1:nrstates
%             for k = 1:nractions
%                 if i==j
%                     T(i,j,k) = sameStateTxn;
%                 else
%                     T(i,j,k) = defTxn;
%                 end
%             end
%         end
%     end
%     
% end

function R = getSampleReward(nrstates,nrobs,nractions)

    for i = 1:nrstates
        for j = 1:nractions
            if i==j
                R(i,j) = 1;
            end
        end
    end

end


% function R = getSampleReward(nrstates,nrobs,nractions)
% 
%     function remm = get_remm(j,nrstates)
%         if rem(j,nrstates) == 0 
%             remm=nrstates;
%         else
%             remm = rem(j,nrstates);
%         end
%     end
% 
% 
% R = zeros(nrstates,nractions);
% 
% for i=1:nrstates
%     for j=1:nractions
%         remm = get_remm(j,nrstates);
%         if remm==i
%             R(i,j) = 1;
%         else
%             R(i,j) = -1;
%         end
%     end
% end
% 
% end

