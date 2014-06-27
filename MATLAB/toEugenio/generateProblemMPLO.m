function problem = generateProblemMPLO(nrGrids,nrPpl)

stateVec = zeros(1,length(nrPpl));
nrStates = nrGrids^nrPpl;
nrActions = nrGrids;
nrObservation = (nrGrids+1)^nrPpl;
encodedStates = encodeStates(nrGrids,nrPpl);
encodedAction = getActionEncoding(nrGrids,nrPpl);
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
 

end

function stateVec = encodeStates(nrGrids,nrPpl)

    stateVec = npermutek([1:nrGrids],nrPpl);
    
end

function actionVec = getActionEncoding(nrGrids,nrPpl)
    
    actionVec = npermutek([1:nrGrids],1);
    
end

function obsVec = getEncodedObs(nrGrid,nrPpl)

     obsVec = npermutek([1:(nrGrid+1)],nrPpl);

end

%%%%% TRANSITION %%%%% 

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

%%%%% TRANSITION ENDS %%%%

%%%%% OBSERVATION %%%%%%

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

%%%%% OBSERVATION END %%%%%

%%%%% REWARD %%%%%

function r = getIndividualReward(fState,fAction)

    r = 0;
    for i = 1:length(fState)
        is = fState(i);
        ia = fAction(1);
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

%%%%% REWARD END %%%% 