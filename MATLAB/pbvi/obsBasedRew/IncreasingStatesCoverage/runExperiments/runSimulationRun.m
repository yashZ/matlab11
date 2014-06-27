function rew = runSimulationRun(pomdp,realPos,policy, allVFN)
    
    start = pomdp.start;
    nrStates = pomdp.nrStates;
    nrobs = pomdp.nrObservations;
    belief = start'; 
    countRew = 0;
    global problem
    problem = pomdp;
    
    for pos=1:length(realPos)
        
        %h = length(realPos) - pos + 1;
        h = 10;
        %h = length(realPos);
        %h = 2;
        if strcmp(policy,'Normal')
            realPos(pos)
            belief
            a = getActionNormPP(belief,h, allVFN,pomdp)
            pr = pomdp.reward(:,a);
            %r =  max(belief); 
            r = pomdp.reward(realPos(pos),a)
            rew(pos) = r;
        elseif strcmp(policy, 'LO')
            realPos(pos)
            belief
            a = getLONormAction(belief,h,allVFN,pomdp);
            %r = max(belief);wr
            a
            if a == 1
                pa = 1;
            else
                pa = (a-1)/11 + 1;
            end
            pa
            r = pomdp.reward(realPos(pos),pa)
            rew(pos) = r;
        elseif strcmp(policy,'IR')
            [s,a] = getActionPPIR(belief,h, allVFN,pomdp);
            pr = pomdp.reward(:,s);
            r1 = belief'*pr;
            r = max(belief);
            rew(pos) = r1;
        elseif strcmp(policy,'Random')
            realPos(pos);
            belief;
            a = getActionRandom(belief,pomdp);
            rew(pos) = max(belief);
        elseif strcmp(policy,'Rotate')
            realPos(pos);
            belief;
            a = getActionRotate(belief,pos,pomdp);
            rew(pos) = max(belief);
        end
         
        trueState = realPos(pos);
        minActionBracket = ((trueState)-1)*nrStates
        maxActionBracket = ((trueState)-1)*nrStates + (nrStates+1)
        
        obsVol = pomdp.observation(1,1,1)
        
        if a>minActionBracket && a<maxActionBracket 
            
            obsrand = rand(1)
            if obsrand < obsVol
                o = realPos(pos);
                countRew = countRew + 1;
            else
                o = nrobs;
            end
        else
            o = nrobs;
        end
        
        o
        
        if strcmp(policy, 'LO')
            
            if a == 1
                a = 1;
            else
                a = ((a-1)/11) + 1; 
            end
        end
        
        disp('----');
        %pause;
        
        if strcmp(policy,'IR')
            if rem(a,nrStates) == 0
                a = a/nrStates;
            else
                a = floor(a/nrStates) + 1;
            end
        end
        %rew(pos) = countRew;
        newBelief = updateBelief(pomdp,belief,a,o)
        belief = newBelief;
        pause
        
    end
end


function a = getLONormAction(belief,h,allVFN,pomdp)
    
    alphas = allVFN{h}.Vtable{1}.alphaList;
    alphaActions = allVFN{h}.Vtable{1}.alphaAction;
    [v,i] = max(belief'*alphas,[],2);
    a = alphaActions(i)
    a = (a-1)*11 + 1;
end


function a = getActionNormPP(belief,h, allVFN,pomdp)
   
    alphas = allVFN{h}.Vtable{1}.alphaList;
    alphaActions = allVFN{h}.Vtable{1}.alphaAction; 
    [v,i] = max(belief'*alphas,[],2);
    a = alphaActions(i);
end

function a = getActionRandom(belief,pomdp)

    a = floor(rand(1)*pomdp.nrActions) + 1;

end

function a = getActionRotate(belief,post,pomdp)

    atoch = [1:(pomdp.nrStates+1):pomdp.nrActions];
    ind = rem(post,pomdp.nrStates);
    if ind==0
        ind=pomdp.nrStates;
    else
        ind = ind;
    end
    a = atoch(ind);

end

function [s,a] = getActionPPIR(belief,h,allVFN,pomdp)
    
    alphas = allVFN{h}.Vtable{1}.alphaList;
    alphaActions = allVFN{h}.Vtable{1}.alphaAction; 
    [v,i] = max(belief'*alphas,[],2);
    avec = alphaActions(i,:);
    s = avec(2);f = avec(1);
    a = s + (f-1)*pomdp.nrStates;
end
