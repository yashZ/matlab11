function rew = runAdaptSims(VFAllP)

   start = pomdp.start;
    belief = start';
    for t = 1:size(realTrack,2)
        
        posOfPpl = realTrack(:,t);
        obsPosOfPpl = obsTrack(:,t);
        s = find(ismember(pomdp.encodedStates,posOfPpl','rows')==1);
        if strcmp(policy,'Normal')
            a = getBestActionNorm(belief,h,VF,pomdp);
            aVec(t)  = a;
            rew(t) = pomdp.reward(s,a);
        elseif strcmp(policy,'LO')
            a = getBestActionLO(belief,h,VF,pomdp);
            aVec(t) = a;
            rew(t) = getCoverageReward(belief,a,pomdp,posOfPpl);
            %rew(t) = pomdp.reward(s,a);
        elseif strcmp(policy,'IR')
            [an,ap] = getBestActionIR(belief,h,VF,pomdp);
            a = an;pomdp.encodedAction = pomdp.encodedActionN;
            pomdp.encodedActionP(ap,:);
            an = pomdp.encodedActionN(a,:);
            ap = pomdp.encodedActionP(ap,:);
            rew(t) = pomdp.reward(s,ap);
        elseif strcmp(policy,'Random')
            a = getBestActionRand(belief,h,VF,pomdp);
            rew(t) = pomdp.reward(s,a);
        %elseif strcmp(policy,'Rotate')
            %a = getBestActionRotate(belief,h,VF,pomdp);
        end
        o = getObs(pomdp,a,posOfPpl,obsPosOfPpl);
        
        newBelief = updateBelief(pomdp,belief,a,o);
        belief = newBelief;
        %pause
    end
end

function test_getCoverageReward()

    belief = zeros(pomdp.nrStates,1);
    belief(1) = 0.4; belief(5) = 0.3; belief(6) = 0.3;
    pomdp = generateProblemMPLO(4,2);
    a = 3;
    posOfPpl = [1,4];
    rCov = getCoverageReward(belief,a,pomdp,posOfPpl);
    
end

function rCov = getCoverageReward(belief,a,pomdp,posOfPpl)

    [v,i] = max(belief);
    PPos = pomdp.encodedStates(i,:);
    rCov = length(find((PPos - posOfPpl')==0));
    
end

function fo = getObs(pomdp,a,posOfPpl,obsTrack)
    
    nrobs = pomdp.nrGrids + 1;
    %action = pomdp.encodedAction(a,:);
    
    atn = pomdp.encodedAction(a,:);
    
    
    %cam = action(1);
    for i =1:length(posOfPpl)
        perInCam = 0;
        for jj = 1:length(atn)
            if atn(jj) == posOfPpl(i)
                perInCam = 1;
            end
        end
        if perInCam==1;
            o(i) = obsTrack(i);
        elseif obsTrack(i) == posOfPpl(i)
            o(i) = nrobs;
        else
            o(i) = atn(jj);
        end
    end
    fo = find(ismember(pomdp.encodedObs,o,'rows')==1);
end

function a = getBestActionNorm(belief,h,VF,pomdp)

    alphas = VF{h}.Vtable{1}.alphaList;
    alphaAction = VF{h}.Vtable{1}.alphaAction;
    [v,i] = max(belief'*alphas,[],2);
    a = alphaAction(i);

end

function a = getBestActionLO(belief,h,VF,pomdp)
    
    alphas = VF{h}.Vtable{1}.alphaList;
    alphaAction = VF{h}.Vtable{1}.alphaAction;
    [v,i] = max(belief'*alphas,[],2);
    a = alphaAction(i);

end

function a = getBestActionRand(belief,h,VF,pomdp)

    a = floor(rand(1)*pomdp.nrActions) + 1;
     
end

function [an,ap] = getBestActionIR(belief,h,VF,pomdp)
    
    alphas = VF{h}.Vtable{1}.alphaList;
    alphaActions = VF{h}.Vtable{1}.alphaAction; 
    [v,i] = max(belief'*alphas,[],2);
    avec = alphaActions(i,:);
    an = avec(1)
    ap = avec(2)
    
end 

function [an] = getBestActionSubmod(belief, h, VFAllP, pomdp)

    for i = 1:nCamChoose
        
        tempVF = VFAll{i};
        alphas = tempVF{h}.Vtable{1}.alphaList;
        alphaAction = tempVF{h}.Vtable{1}.alphaAction;
        
        
    end


end

