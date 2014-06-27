function rew = runSubmodSims()
    
    initB = pomdp.start';
    belief = initB;
    sbelief = belief;
    for i = 1:length(realTrack);
        realState = realTrack(i);
        %sbelief = belief;
        pomdp.encodedStates(realState,:);
        
        if strcmp(policy,'CamInd')
            ttogo = length(realTrack) - i + 1;
            if (ttogo < h)
                ttogo = ttogo;
            else
                ttogo = h;
            end
            belief;
            a = getBestAction(VF,belief,ttogo);
            pomdp.encodedAction(a,:);
            obsState = obsTrack(a,i);
            ppppp = pomdp.encodedObs(obsState,:);
            rew(i) = pomdp.reward(realState,a);
            newBelief = updateBelief(pomdp,belief,a,obsState);
            belief = newBelief;
            %pause
%             a = getBestAction(sVF,sbelief,sh)
%             pomdp.encodedAction(a,:)
%             obsState = obsTrack(a,i);
%             rew(i) = pomdp.reward(realState,a);
%             snewBelief = updateBelief(pomdp,sbelief,a,obsState);
%             sbelief = snewBelief
%             
%             pause
            
        elseif strcmp(policy,'Random')
            a = getRandomAction(pomdp.nrActions);
            obsState = obsTrack(a,i);
            rew(i) = pomdp.reward(realState,a);
            newBelief = updateBelief(pomdp,belief,a,obsState);
            belief = newBelief;
        end 
    end
end

function a = getBestAction(VF,belief,h)
    
    alphas = VF{h}.Vtable{1}.alphaList;
    alphaAction = VF{h}.Vtable{1}.alphaAction;
    %[v,i] = max(belief'*alphas,[],2);
    %a = alphaAction(i);
    for ta = 1:pomdp.nrActions
        avec = pomdp.encodedAction(ta,:);
        a1 = avec(1);
        a2 = avec(2);
        ap = avec(3:length(avec));
        for pa = 1:length(alphaAction)
            
        end
    end
    

end

function a = formAction()

    a1 = max(b,[],alphas);
    

end


function a = getRandomAction(nrAction)

    a = floor(rand(1)*nrAction) + 1;

end
    
