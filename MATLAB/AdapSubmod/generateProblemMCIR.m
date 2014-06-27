function problem = generateProblemMCIR(nrGrids,nrPpl,nCamChoose)

%test_onePersonObsProb()
%pause;
%nCamChoose = 2;
stateVec = zeros(1,length(nrPpl));
nrStates = nrGrids^nrPpl;
nrActionsN = nrGrids^nCamChoose;
nrActionsP = nrStates;
nrObservation = (nrGrids+1)^nrPpl;
encodedStates = encodeStates(nrGrids,nrPpl);
encodedActionP = getActionEncodingP(nrGrids,nrPpl);
encodedActionN = getActionEncodingN(nrGrids,nrPpl,nCamChoose);
nrActionsN = size(encodedActionN,1);
encodedObs = getEncodedObs(nrGrids,nrPpl);
problem.gamma = 1;
problem.nrGrids = nrGrids;
problem.nrPpl = nrPpl;
problem.nrStates = nrStates; 
problem.nrActionsN = nrActionsN;
problem.nrActionsP = nrActionsP;
problem.nrObservations = nrObservation;
problem.start = (1/nrStates)*(ones(1,nrStates));
problem.encodedStates = encodedStates;
problem.encodedObs = encodedObs;
problem.encodedActionN = encodedActionN;
problem.encodedActionP = encodedActionP;
problem.transition = getSampleTrans(nrStates,nrObservation,nrActionsN,encodedStates,nrGrids);
problem.observation = getSampleObs(nrStates,nrObservation,nrActionsN,encodedStates,encodedActionN,encodedObs,nrGrids,nCamChoose);
problem.reward = getSampleReward(nrStates,nrObservation,nrActionsP,encodedStates,encodedActionP,encodedObs,nrGrids);

end

%function actionVec = getNActions()

%    actionVec = npermutek([1:nrGrids],2);

%end


function stateVec = encodeStates(nrGrids,nrPpl)

    stateVec = npermutek([1:nrGrids],nrPpl);
    
end

function obsVec = getEncodedObs(nrGrid,nrPpl)

     obsVec = npermutek([1:(nrGrid+1)],nrPpl);

end

function actionVec = getActionEncodingP(nrGrids,nrPpl)
    
    actionVec = npermutek([1:nrGrids],nrPpl);
    
end

function actionVec = getActionEncodingN(nrGrids,nrPpl,nCamChoose)
    
    j = 0;
    actionVec = npermutek([1:nrGrids],nCamChoose);
    for i = 1:size(actionVec,1)
        t = actionVec(i,:);
        if length(unique(t)) == length(t)
            j = j+1;
            na(j,:) = t;
        end
    end
    actionVec = na;
    
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


function test_onePersonObsProb()
    s = [1];
    fAction = [1,4];
    o = [1];
    nrobs = 5;
    p = onePersonObsProb(s,fAction,o,nrobs)

end

function p = onePersonObsProb(s,fAction,o,nrobs)

    %a1=fAction(1); a2 = fAction(2);
    detP = 0.9;
    %falseNP = 0.05;
    remP = 0.1;
    p = 0;t = 0;g=0;
    for jj = 1:length(fAction)
        if (fAction(jj) == s)
            t = 1;
        end
        if (fAction(jj) == o)
            g = 1;
        end
    end
    
    if t == 1
        if s==o
            p = detP;
        elseif o==nrobs
            p = remP;
        end
        if g==1 && o~=s
            p = remP;
        end
    else
        if g == 1
            p = remP;
        elseif o==nrobs
            p = detP;
        end
    end

end


function obsProb = getObsProb(fState,fAction,fObs,nrobs,nCamChoose)

    obsProb = 1;
    for i = 1:length(fState)
        st = fState(i);
        obs = fObs(i);
        realAction = fAction(1:nCamChoose);
        onePProb = onePersonObsProb(st,realAction,obs,nrobs);
        obsProb = obsProb*onePProb;
    end
end



function O = getSampleObs(nrstates,nrobs,nraction,encodedStates,encodedAction,encodedObs,nrGrids,nCamChoose)

    O = zeros(nrstates,nraction,nrobs);
    
    nrg = nrGrids + 1;
    for s=1:nrstates
        for a = 1:nraction
            for o = 1:nrobs
                factoredState = encodedStates(s,:);
                factoredAction = encodedAction(a,:);
                factoredObs = encodedObs(o,:);
                %for p = 1:length(factoredAction)
                %    factoredAction1 = factoredAction(p);
                O(s,a,o) = getObsProb(factoredState,factoredAction,factoredObs,nrg,nCamChoose);
                %end
            end
        end
    end
    
    for s = 1:nrstates
        for a = 1:nraction
            t = O(s,a,:)
            O(s,a,:) = O(s,a,:)/sum(t);
        end
    end
end



function r = getIndividualReward(fState,fAction)

    r = 0;
    for i = 1:length(fState)
        is = fState(i);
        ia = fAction(i);
        if is==ia
            r = r+1;
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


