function problem = generateProblemMPDiffRew(nrGrids, nrPpl) 

stateVec = zeros(1,length(nrPpl));
nrStates = nrGrids^nrPpl;
nrActions = nrGrids^(nrPpl+1);
nrObservation = (nrGrids+1)^nrPpl;
encodedStates = encodeStates(nrGrids,nrPpl);
encodedAction = getActionEncoding(nrGrids,nrPpl);
nrActions = size(encodedAction,1);
encodedObs = getEncodedObs(nrGrids,nrPpl);
problem.gamma = 1;
problem.nrGrids = nrGrids;
problem.nrPpl = nrPpl;
problem.nrStates = nrStates; 
problem.nrActions = nrActions;
problem.nrObservations = nrObservation;
problem.start = (1/nrStates)*(ones(1,nrStates));
problem.encodedStates = encodedStates;
problem.encodedObs = encodedObs;
problem.encodedAction = encodedAction;
problem.transition = getSampleTrans(nrStates,nrObservation,nrActions,encodedStates,nrGrids);
problem.observation = getSampleObs(nrStates,nrObservation,nrActions,encodedStates,encodedAction,encodedObs,nrGrids);
problem.reward = getSampleReward(nrStates,nrObservation,nrActions,encodedStates,encodedAction,encodedObs,nrGrids);


%passed
%test_getIndividualReward()
%test_stateVec
%test_obsProb()
%unit_test
%test_onePersonProb()


end

function test_getIndividualReward()
    
    r = getIndividualReward([1,1],[2,2,1])

end

function test_onePersonProb()

    prob = onePersonObsProb(1,1,5,5)

end

function test_obsProb()
    s = [1,1];
    a = 1;
    o = [1,5];
    n = 5;
    prob = getObsProb(s,a,o,n)

end

function unit_test
    prob1 = getOnePTxnProb(1,1,4)
    prob2 = getOnePTxnProb(4,1,4)
    prob3 = getOnePTxnProb(4,2,4)
end

function test_stateVec

    stateVec = encodeStates(4,4)

end

function test_encodedObs()
    
    obsVec = getEncodedObs(4,4)

end

function stateVec = encodeStates(nrGrids,nrPpl)

    stateVec = npermutek([1:nrGrids],nrPpl);
    
end

function obsVec = getEncodedObs(nrGrid,nrPpl)

     obsVec = npermutek([1:(nrGrid+1)],nrPpl);

end


function actionVec = getActionEncoding(nrGrid,nrPpl)
    
    %nrActions = nrGrids^(nrPpl + 1);
    % action encoding - there are only two prediction action
    % 1st one predicts that the person is in the cell 1 or 2 or 3
    % 2nd one predicts that the person is not in the cell 1 or 2 or 3.
    % Right prediction - +1
    % Wrong prediction - 0;
    %actionVec = npermutek([1:nrGrids],(nrPpl+1));
    pAct = 2;
    nAct = nrGrid;
    actionVec = npermutek([1:nrGrid],(nrPpl + 1));
    finActionVec = actionVec;
    l = size(actionVec,1);
    for i = l:-1:1
        actV = actionVec(i,:);
        flag = 0;
        for j = 2:length(actV)
            if actV(j) > 2 
                flag = 1;
            end
        end
        if flag == 1
            finActionVec(i,:) = [];
        end
        
    end
    actionVec = finActionVec
    
    
end

function prob = getOnePTxnProb(psr,nsr,nrGrids)
    
    nrAdjStt = 2;
    sameSttTxn = 0.7;
    adjSttTxn = (1 - sameSttTxn)/nrAdjStt;
    if (psr==nsr)
        prob = sameSttTxn;
    elseif ((abs(psr-nsr)==1) || (abs(psr-nsr)==(nrGrids-1)))
        prob = adjSttTxn;
    else
        prob = 0;
    end
    
end

function txnProb = getSttTxnProb(ps,ns,nrGrids)

    txnProb = 1;
    nrPpl = length(ps);
    for n=1:nrPpl
        onePps = ps(n);
        onePns = ns(n);
        tProb = getOnePTxnProb(onePps,onePns,nrGrids);
        txnProb = txnProb.*tProb;
    end
end

function T = getSampleTrans(nrstates,nrobs,nractions,encodedStates,nrGrids)

    for s = 1:nrstates
        for sd = 1:nrstates
            for a = 1:nractions
                ps = encodedStates(s,:);
                ns = encodedStates(sd,:);
                prob = getSttTxnProb(ps,ns,nrGrids);
                T(s,sd,a) = prob;
            end
        end
    end
end

function p = onePersonObsProb(s,a,o,nrobs)

    detP = 0.85;
    remP = 1 - detP;
    p = 0;
    if s==a
        if s==o
            p = detP;
        elseif o==nrobs
            p = remP;
        end
    else
        if a==o
            p = remP;
        elseif o==nrobs
            p = detP;
        end
    end

end


function obsProb = getObsProb(fState,fAction,fObs,nrobs)

    obsProb = 1;
    for i = 1:length(fState)
        st = fState(i);
        obs = fObs(i);
        realAction = fAction(1);
        onePProb = onePersonObsProb(st,realAction,obs,nrobs);
        obsProb = obsProb*onePProb;
    end
end



function O = getSampleObs(nrstates,nrobs,nraction,encodedStates,encodedAction,encodedObs,nrGrids)

    nrg = nrGrids + 1;
    for s=1:nrstates
        for a = 1:nraction
            for o = 1:nrobs
                factoredState = encodedStates(s,:);
                factoredAction = encodedAction(a,:);
                factoredObs = encodedObs(o,:);
                O(s,a,o) = getObsProb(factoredState,factoredAction,factoredObs,nrg);
            end
        end
    end
end

function r = getIndividualReward(fState,fAction)

    r = 0;
    for i = 1:length(fState)
        is = fState(i);
        ia = fAction(i+1);
        %if is==ia
        %    r = r+1;
        %end
        if ia==1 && is < 4
            r = r + 1;
        elseif ia==2 && (is > 3)
            r = r + 1;
        end
        
    end

end

function R = getSampleReward(nrstates,nrobs,nraction,encodedStates,encodedAction,encodedObs,nrGrids)

    for s = 1:nrstates
        for a = 1:nraction
            factoredState = encodedStates(s,:);
            factoredAction = encodedAction(a,:);
            r = getIndividualReward(factoredState,factoredAction);
            R(s,a) = r;
        end
    end
end