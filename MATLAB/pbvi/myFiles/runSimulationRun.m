function rew = runSimulationRun(pomdp,realPos,policy, allVFN, allVFIR)
    
    start = pomdp.start;
    nrStates = pomdp.nrStates;
    nrobs = pomdp.nrObservations;
    belief = start'; 
    countRew = 0;
    global problem
    problem = pomdp;
    
    for pos=1:length(realPos)
        
        %h = length(realPos) - pos + 1;
        h = length(realPos)
        if strcmp(policy,'Normal')
            a = getActionNormPP(belief,h, allVFN);
            pr = pomdp.reward(:,a);
            r =  max(belief); 
            rew(pos) = r;
        elseif strcmp(policy,'IR')
            [s,a] = getActionPPIR(belief,h, allVFIR);
            pr = pomdp.reward(:,s);
            r1 = belief'*pr;
            r = max(belief);
            rew(pos) = r1;
        elseif strcmp(policy,'Random')
            a = getActionRandom(belief);
            rew(pos) = max(belief);
        elseif strcmp(policy,'Rotate')
            a = getActionRotate(belief,pos);
            rew(pos) = max(belief);
        end
         
        trueState = realPos(pos);
        minActionBracket = ((trueState)-1)*nrStates;
        maxActionBracket = ((trueState)-1)*nrStates + (nrStates+1);
        
        obsVol = pomdp.observation(1,1,1);
        
        if a>minActionBracket && a<maxActionBracket 
            
            obsrand = rand(1);
            if obsrand < obsVol
                o = realPos(pos);
                countRew = countRew + 1;
            else
                o = nrobs;
            end
        else
            o = nrobs;
        end
        
        if strcmp(policy,'IR')
            if rem(a,nrStates) == 0
                a = a/ntStates;
            else
                a = floor(a/nrStates) + 1;
            end
        end
        
        newBelief = updateBelief(pomdp,belief,a,o);
        belief = newBelief;
        
    end
end

function a = getActionNormPP(belief,h, allVFN)
   
    alphas = allVFN{h}.Vtable{1}.alphaList;
    alphaActions = allVFN{h}.Vtable{1}.alphaAction; 
    [v,i] = max(belief'*alphas,[],2);
    a = alphaActions(i);
end

function a = getActionRandom(belief)

    a = floor(rand(1)*nrActions) + 1;

end

function a = getActionRotate(belief,post)

    atoch = [1:(nrStates+1):pomdp.nrActions];
    ind = rem(post,nrStates);
    if ind==0
        ind=nrStates;
    else
        ind = ind;
    end
    a = atoch(ind);

end

function [s,a] = getActionPPIR(belief,h,allVFIR)
    
    alphas = allVFIR{h}.Vtable{1}.alphaList;
    alphaActions = allVFIR{h}.Vtable{1}.alphaAction; 
    [v,i] = max(belief'*alphas,[],2);
    avec = alphaActions(i,:);
    s = avec(2);f = avec(1);
    a = s + (f-1)*nrStats;
end
