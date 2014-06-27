function rew = runSimsIndpP(oneManProb,nGrid,nPpl,h,tVF,policy)

    nSteps = 100;
    belief = (1/nGrid)*ones(nPpl,nGrid);
    newBelief = belief;
    %oneManIR = generateProblemIR(nGrid,1);
    
    [realPos,obsPos] = simulateIndData(nPpl,nSteps,nGrid,oneManProb);
    for t = 1:size(realPos,2)
        r = 0;
        posOfPpl = realPos(:,t);
        obsPosPpl = obsPos(:,t);
        a = getBestAction(tVF,belief,oneManProb,h);
        for j = 1:nPpl
            posofp = posOfPpl(j);
            obsPosofp = obsPosPpl(j);
            onePBelief = belief(j,:);
            o = getObs(oneManProb,a,posofp,obsPosofp);
            %r = oneManProb.reward(posofp,a) + r;
            r = getReward(onePBelief,posofp) + r;
            newOnePBelief = updateBeliefoneP(onePBelief,a,o,oneManProb);
            %pause;
            newBelief(j,:) = newOnePBelief;
            %newBelief = updateBelief(belief,a,pomdp,o);
            %belief = newBelief;
        end
        belief = newBelief;
        %rew(t) = r;
        if strcmp(policy,'Diff')
            rew(t) = getRewardDiff(realPos,belief,tVF,oneManProb,h);
        else 
            rew(t) = getReward3(realPos,belief);
        end
    end
    
    
    
%test_getBestAction()

end

function r = getRewardDiff(realPos,belief,VF,pomdp,h)

    r = 0;
    nppl = size(realPos,1);
    for ppl =1:nppl
        s = realPos(ppl);
        belief1 = belief(ppl,:);
        alphas = VF{h}.Vtable{1}.alphaList;
        alphaAction = VF{h}.Vtable{1}.alphaAction;
        [v,i] = max(belief1*alphas,[],2);
        act = alphaAction(i,:)
        r = pomdp.reward(s,act) + r; 
    end

end

function r = getReward3(realPos,belief)

    % task is to predict how many ppl in state 1 or 2 or 3 or 4.
    r = 0;
    nppl = size(realPos,1);
    for ppl = 1:nppl
        s = realPos(ppl);
        belief1 = belief(ppl,:);
        [v,i] = max(belief1);
        %if i == 5 || i == 6 || s == 5 || s == 6
        %    r = r + 1;
        %elseif i ~= 5 || i ~= 6 || s ~= 5 || s ~= 6
        %    r = r + 1;
        %end
        
        if i < 4 && s < 4
            r = r + 1;
        elseif i > 4 && s > 4
            r = r + 1;
        end
        
        
    end

end


function r = getReward2(realPos,belief)

    r = 0;
    nppl = size(realPos,1);
    for ppl = 1:nppl
        s = realPos(ppl)
        belief1 = belief(ppl,:);
        [v,i] = max(belief1);
        if i>0 && i<4
            
            if s > 0 && s < 4
                r = r+1;
            end
        else
            if s > 3
                r = r + 1;
            end
            
        end
    end

end


function r = getReward(belief,s)
    
    [v,i] = max(belief);
    if i==s
        r = 1
    else
        r = 0;
    end
end

function onePBel = updateBeliefoneP(onePBelief,a,o,pomdp)
    
    onePBel = updateBelief(pomdp,onePBelief',a,o);

end


function o = getObs(pomdp,a,posOfPpl,obsPosOfPpl)

    nrobs = pomdp.nrObservations;
    cams = pomdp.encodedAction(a,:);
    cam = cams(1);
    if cam==posOfPpl
        o = obsPosOfPpl;
    elseif obsPosOfPpl == posOfPpl
        o = nrobs;
    else
        o = cam;
    end
    
end


function test_getBestAction()

    h = 2;nSteps = 10;
    nGrid = 100;nppl = 10;
    oneManProb = generateProblemMP(nGrid,1);
    VF = solvePOMDPMP(oneManProb,h);    
    b = [0.2,0.3,0.5,0;0.1,0.4,0.2,0.3;0.4,0.4,0.1,0.1];
    %b = [0.2,0.3,0.5,0];
    %b = [0.1,0.4,0.2,0.3]
    %b = [0.4,0.4,0.1,0.1];
    for j = 1:nppl
        b1 = b(j,:);
        Q(j,:) = getBestAction(VF,b1,oneManProb,h)
    end
    sum(Q,1)
    [t,it] = max(sum(Q,1))

end

function ba = getBestAction(VF,belief,pomdp,h)

    actionSet = pomdp.nrActions;
    Q = zeros(1,actionSet);
    for i = 1:(actionSet)
        a = i;
        v = getActionValue(belief,h,VF,pomdp,a);
        Q(i) = Q(i) + v;
    end
    [bv,ba] = max(sum(Q,1));
    

end

function v = getActionValue(belief,h,VF,pomdp,a)

    alphas = VF{h}.Vtable{1}.alphaList;
    alphaAction = VF{h}.Vtable{1}.alphaAction;
    allActions = alphaAction;
    ind = find(allActions==a);
    finV = 0;
    for p = 1:size(belief,1)
        b1 = belief(p,:);
        if (isempty(ind))
            v = 0;
        else
            allAssocVec = alphas(:,ind);
            b1*allAssocVec;
            v = max(b1*allAssocVec);
        end
        finV = v + finV;
    end
    
end