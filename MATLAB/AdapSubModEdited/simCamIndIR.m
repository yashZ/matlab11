function [rew] = simCamIndIR(realTrack,obsTrack,pomdp,VF,h,policy,VF1,pomdp1,nC)%,sVF,sh)

    initB = pomdp.start';
    belief = initB;
    for i = 1:length(realTrack);
        realState = realTrack(i);
        %sbelief = belief;
        pomdp.encodedStates(realState,:);
        
        %if strcmp(policy,'CamInd')
            ttogo = length(realTrack) - i + 1;
            if (ttogo < h)
                ttogo = ttogo;
            else
                ttogo = h;
            end
            
            %optimal
            if strcmp(policy, 'optimal')
            avec = getBestAction(VF,belief,ttogo);
            an = avec(1);
            ap = avec(2);
            elseif strcmp(policy, 'factorized')
            %factorized
            encact = getActValueIR(VF1,pomdp1,belief',nC,h,VF);
            [dads,an] = ismember(encact(1:nC),pomdp.encodedActionN,'rows');
            ap = encact(length(encact));
            elseif strcmp(policy,'random')
            %random - 
            encact = getRandAction(pomdp1,belief',nC);
            [dads,an] = ismember(encact(1:nC),pomdp.encodedActionN,'rows');
            ap = encact(length(encact));
            end
            an;
            ap;
            obsState = obsTrack(an,i);
            pomdp.encodedStates(realState,:);
            pomdp.encodedObs(obsState,:);
            pomdp.encodedActionN(an,:);
            rew(i) = pomdp.reward(realState,ap);
            newBelief = updateBelief(pomdp,belief,an,obsState);
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
            
        %elseif strcmp(policy,'Random')
%             a = getRandomAction(pomdp.nrActions);
%             obsState = obsTrack(a,i);
%             rew(i) = pomdp.reward(realState,a);
%             newBelief = updateBelief(pomdp,belief,a,obsState);
%             belief = newBelief;
        %end 
    end
end

function a = getBestAction(VF,belief,h)
    
    alphas = VF.Vtable{1}.alphaList;
    alphaAction = VF.Vtable{1}.alphaAction;
    [v,i] = max(belief'*alphas,[],2);
    a = alphaAction(i,:);

end

function a = getRandAction(pomdp,belief,nC)
    
    [v,ap] = max(belief);
    an = [];
    ncell = pomdp.nCell;
    %for i = 1:nC
    %    pr
    %end
    probdist = (1/ncell)*ones(1,ncell);
    probdist;
    while (length(unique(an)) ~= nC)
        an = sampleDist(probdist',nC);
    end
    a = [an',ap];
end

function a = getRandomAction(nrAction)

    a = floor(rand(1)*nrAction) + 1;

end