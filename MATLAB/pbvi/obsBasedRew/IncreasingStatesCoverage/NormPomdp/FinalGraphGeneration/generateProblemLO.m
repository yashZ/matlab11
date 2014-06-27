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
%     
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
                            O(s,a,o) = 0.25;
                        elseif o==nrobs
                            O(s,a,o) = 0.75;
                        end
                    end    
                end
                
                
                if a==2
                    if s==2
                        if s==o
                            O(s,a,o) = 0.75;
                        elseif o==nrobs
                            O(s,a,o) = 0.25;
                        end
                    else
                        if a==o
                            O(s,a,o) = 0.25;
                        elseif o==nrobs
                            O(s,a,o) = 0.75;
                        end
                    end    
                end
                
%                  
%                 if a==7
%                     if s==7
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 
%                 if a==5
%                     if s==5
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 
%                 if a==9
%                     if s==9
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 
%                 if a==10
%                     if s==10
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 
%                 if a==2
%                     if s==2
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 if a==3
%                     if s==3
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
%                 if a==6
%                     if s==6
%                         if s==o
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         if a==o
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end    
%                 end
             end
         end
     end
    
end

 
function T = getSampleTrans(nrstates,nrobs,nractions)

sameStateTxn = 0.7;
defTxn1 = 0.15;
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


function R = getSampleReward(nrstates,nrobs,nractions)

    for i = 1:nrstates
        for j = 1:nractions
            if i==j
                R(i,j) = 1;
            end
        end
    end

end



