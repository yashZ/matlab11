function pomdp = formPOMDPLO(txnObs)

   O = txnObs.O; T = txnObs.T;
   nStates = size(O,1);
   sO = sum(O,2);
   for t = 1:length(sO)
       O(t,:) = O(t,:)./sO(t);
   end
    
   nrActions = nStates;
   nrObs = nStates + 1;
   pO = getSampleObs(nStates,nrActions,nrObs);
   pT = getSampleTxn(T);
   pomdp.gamma = 1;
   pomdp.nrStates = nStates;
   pomdp.nrActions = nractions;
   pomdp.nrObservatons = nrobs;
   pomdp.start = (1/nStates)*(ones(1,nStates));
   pomdp.observation = pO;
   pomdp.transition = pT;
   pomdp.reward = getSampleReward(nrstates,nractions,nrobs);
   
end


function O = getSampleObs(nrstates,nrobs,nractions)

    O = zeros(nrstates,nractions,nrosb);
    for s = 1:nrstates
        for a = 1:nractions
            for o = 1:nrobs
                if s==a
                    if a==o
                        O(s,a,o) = O(s,o);
                    elseif o==nrobs
                        O(s,a,o) = 1 - O(s,o);
                    end
                else
                    if a==o
                        O(s,a,o) = O(s,a);
                    elseif o == nrobs
                        O(s,a,o) = 1 - O(s,a);
                    end
                end
                
            end
        end
    end
end

function pT = getSampleTxn(T)

    pT = zeros(size(T,1));
    nstates = size(T,1);
    sT = sum(T,2);
    for t = 1:length(sT)
        pT(t,:) = T(t,:)./sT(t);
        
    end

end

function R = getSampleReward(nrstates,nractions,nrobs)

    R = zeros(nrstates,nractions);
    for i = 1:nrstates
        for j = 1:nractions
            if i==j
            R(i,j) = 1;
            end
        end
    end
            
      


end
