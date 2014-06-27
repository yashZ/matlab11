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
%O = sampleProb.observationOld;
sampleProb.transition = getSampleTrans(nrstates,nrobs,nractions);
sampleProb.reward = getSampleReward(nrstates,nrobs,nractions);

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
    
%     for s=1:nrstates
%         for a = 1:nractions
%             for o = 1:nrobs
%                 if a>0 && a<11
%                     if s==1
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>30 && a<41    
%                     if s==4
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>60 && a<71     
%                     if s==7
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                elseif a>80 && a<91
%                     if s==9
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>40 && a<51
%                     if s==5
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>90 && a<101
%                     if s==10
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>10 && a<21
%                     if s==2
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>20 && a<31
%                     if s==3
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                 elseif a>50 && a<61
%                     if s==6
%                         if o==s
%                             O(s,a,o) = 0.75;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.25;
%                         end
%                     else
%                         t = rem(a,nrstates);
%                         if t==0
%                             comp = floor(a/nrstates);
%                         else
%                             comp = floor(a/nrstates) + 1;  
%                         end 
%                         if o==comp
%                             O(s,a,o) = 0.25;
%                         elseif o==nrobs
%                             O(s,a,o) = 0.75;
%                         end
%                     end
%                  end
%             end
%         end
%     end
    
    
end

function O = getSampleObs1(nrstates,nrobs,nractions)

    numtoadd = nrstates;    
    O = zeros(nrstates,nractions,nrobs);
    
    for s = 1:nrstates
        minActionBrac = (s-1)*nrstates;
        maxActionBrac = minActionBrac + numtoadd + 1;
        for a = 1:nractions
            for o = 1:nrobs
               
                if s==1
                    if a>minActionBrac && a<maxActionBrac
                        
                        
                    end
                    
                else
                    
                end
                
                
                
            end
        end
    end
end







% function O = getSampleObs(nrstates,nrobs,nractions)
% 
% % a1 = pred 1 + obs 1; a2 = pred 2 + obs 1 ....
% 
% 
%     numtoadd = nrstates;    
%     O = zeros(nrstates,nractions,nrobs);
% 
%     for s = 1:nrstates
%         minActionBrac = (s-1)*nrstates;
%         maxActionBrac = minActionBrac + numtoadd + 1;
%         for a = 1:nractions
%             for o = 1:nrobs
%             
%                 if a<maxActionBrac && a>minActionBrac
%                     if s==o
%                         O(s,a,o) = 0.95;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.05;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 else
%                     t = rem(a,nrstates);
%                     if t==0
%                         comp = floor(a/nrstates);
%                     else
%                         comp = floor(a/nrstates) + 1;  
%                     end 
%                     if o==comp
%                         O(s,a,o) = 0.05;
%                     elseif o==nrobs
%                         O(s,a,o) = 0.95;
%                     else 
%                         O(s,a,o) = 0;
%                     end
%                 end
%             end
%         end
%     end
% end







function defTxn = getTxn(i,j,sameStateTxn,nrstates)
    
if i==1 || i==nrstates
    defTxn = (1-sameStateTxn);
else
    defTxn = (1-sameStateTxn)/2;
end


end


function T = getSampleTrans(nrstates,nrobs,nractions)

sameStateTxn = 0.7;
defTxn1 = 0.3;
defTxn2 = 0.0;

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

