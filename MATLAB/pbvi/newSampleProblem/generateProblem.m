function sampleProb = generateProblem(nrst)

nrstates = nrst;
nrobs = nrst + 1;
nractions = nrst^2;
sampleProb.gamma = 0.9;
sampleProb.nrStates = nrstates;
sampleProb.nrActions = nractions;
sampleProb.nrObservations = nrobs;
sampleProb.start = 1/nrst*(ones(1,nrst));
sampleProb.observation = getSampleObs(nrstates,nrobs,nractions);
sampleProb.transition = getSampleTrans(nrstates,nrobs,nractions);
sampleProb.reward = getSampleReward(nrstates,nrobs,nractions);

end

% 
% function O = getSampleObs(nrstates,nrobs,nractions)
%     
%     O = zeros(nrstates,nractions,nrobs);
%     nractions = sqrt(nractions);
%     Otemp = getSampleObsIR(nrstates,nractions,nrobs);
%     size(Otemp)
%     size(O)
%     nractions = nractions^2;
%     for a=1:nractions
%         if rem(a,nrstates) == 0
%             ta = floor(a/nrstates);
%         else
%             ta = floor(a/nrstates) + 1;
%         end
%         O(:,a,:) = Otemp(:,ta,:);
%     end
%     
% 
% end
% 
% 
% function O = getSampleObsIR(nrstates,nractions,nrobs)
% 
%     O = zeros(nrstates,nractions,nrobs);
%     for s = 1:nrstates
%         for a = 1:nractions
%             for o = 1:nrobs
%                 
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
%                 
%                 
%                 
%                 
% %                 if s==a
% %                     if s==o
% %                         O(s,a,o) = 0.9;
% %                     elseif o==nrobs
% %                         O(s,a,o) = 0.1;
% %                     end
% %                 else
% %                     if a==o
% %                         O(s,a,o) = 0.1;
% %                     else
% %                         O(s,a,nrobs) = 0.9;
% %                     end
% %                     
% %                 end
%             end
%         end
%     end
% end


function O = getSampleObs(nrstates,nrobs,nractions)

% a1 = pred 1 + obs 1; a2 = pred 2 + obs 1 ....

    %nrstates = 4;
    %nrobs = 5;
    %nractions = 16;
    numtoadd = nrstates;    
    O = zeros(nrstates,nractions,nrobs);

    for s = 1:nrstates
        minActionBrac = (s-1)*nrstates;
        maxActionBrac = minActionBrac + numtoadd + 1;
        for a = 1:nractions
            for o = 1:nrobs
            
                if a<maxActionBrac && a>minActionBrac
                    if s==o
                        O(s,a,o) = 0.9;
                    elseif o==nrobs
                        O(s,a,o) = 0.1;
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
                        O(s,a,o) = 0.1;
                    elseif o==nrobs
                        O(s,a,o) = 0.9;
                    else 
                        O(s,a,o) = 0;
                    end
                end

%                   if a<maxActionBrac && a>maxActionBrac
%                       if s==o
%                           O(s,a,o) = 0.91;
%                       else 
%                           O(s,a,o) = 0.03;
%                       end
%                   elseif o==nrobs
%                       if s
%                           O(s,a,o) = 0.1
%                       else
%                           O(s,a,o) = 0.3;
%                       end
%                   end

            end
        end
    end
end





function T = getSampleTrans(nrstates,nrobs,nractions)
%nrstates = 4;
%nrobs = 5;
%nractions = 16;
sameStateTxn = 0.7;
defTxn = (1 - sameStateTxn)/(nrstates-1);
numtoadd = nrstates;

    for i = 1:nrstates
        for j=1:nrstates
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


function R = getSampleReward(nrstates,nrobs,nractions)
%nrstates = 4;
%nrobs = 5;
%nractions = 16;

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
            R(i,j) = -1;
        end
    end
end

end


% numtoadd = nrstates;
% R = zeros(nrstates,nractions);
% 
%     for s = 1:nrstates
%         for a = 1:nractions
%             if s==1
%                 if a==1 || a==5 || a==9 || a==13
%                     R(s,a) = 1;
%                 else
%                     R(s,a) = 0;
%                 end
%             elseif s==2 
%                 if a==2 || a==6 || a==10 || a==14
%                     R(s,a) = 1;
%                 else
%                     R(s,a) = 0;
%                 end
%             elseif s==3
%                 if a==3 || a==7 || a==11 || a==15
%                     R(s,a) = 1;
%                 else
%                     R(s,a) = 0;
%                 end
%             elseif s==4
%                 if a==4 || a==8 || a==12 || a==16
%                     R(s,a) = 1;
%                 else
%                     R(s,a) = 0;
%                 end
%             end
%         end
%     end           
            
            
            
%             
%             if s==1
%                 if a<5 && a>0
%                     if o==1
%                         O(s,a,o) = 0.9;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.1;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 else
%                     if o==nrobs
%                         O(s,a,o) = 0.9;
%                     elseif o== 
%                     end
%                 end
%             end
%             if s==2 
%                 if a<9 && a>4 
%                     if o==2
%                         O(s,a,o) = 0.9;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.1;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 end
%             end
%             if s==3
%                 if a<13 && a>8
%                     if o==3
%                         O(s,a,o) = 0.9;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.1;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 end
%             end
%             if s==4 
%                 if a<17 && a>12
%                     if o==4
%                         O(s,a,o) = 0.9;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.1;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 end
%             end
%         end

