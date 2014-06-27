function problem = generateProblemFBOverlap(nrGrids, nrPpl,txn,obsMat) 

stateVec = zeros(1,length(nrPpl));
nrStates = nrGrids^nrPpl;
nrActions = nrGrids^(nrPpl+1);
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
problem.transition = getSampleTrans(nrStates,nrObservation,nrActions,encodedStates,nrGrids,txn);
problem.observation = getSampleObs(nrStates,nrObservation,nrActions,encodedStates,encodedAction,encodedObs,nrGrids,obsMat);
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


function actionVec = getActionEncoding(nrGrids,nrPpl)
    
    %nrActions = nrGrids^(nrPpl + 1);
    actionVec = npermutek([1:nrGrids],(nrPpl + 1));
    
end

function prob = getOnePTxnProb(psr,nsr,nrGrids,txn)
    
    nrAdjStt = 3;
    sameSttTxn = txn;
    adjSttTxn = (1 - sameSttTxn)/nrAdjStt;
    if (psr==nsr)
        prob = sameSttTxn;
    %elseif ((abs(psr-nsr)==1) || (abs(psr-nsr)==(nrGrids-1)))
    else
        prob = adjSttTxn;
    %else
    %    prob = 0;
    end
    
end

function txnProb = getSttTxnProb(ps,ns,nrGrids,txn)

    txnProb = 1;
    nrPpl = length(ps);
    for n=1:nrPpl
        onePps = ps(n);
        onePns = ns(n);
        tProb = getOnePTxnProb(onePps,onePns,nrGrids,txn);
        txnProb = txnProb.*tProb;
    end
end

function T = getSampleTrans(nrstates,nrobs,nractions,encodedStates,nrGrids,txn)

    for s = 1:nrstates
        for sd = 1:nrstates
            for a = 1:nractions
                ps = encodedStates(s,:);
                ns = encodedStates(sd,:);
                prob = getSttTxnProb(ps,ns,nrGrids,txn);
                T(sd,s,a) = prob;
            end
        end
    end
end

function p = onePersonObsProb(s,a,o,nrobs,obsMat)

    ovObsMat1 = [0.9,0.7,0,0;0,0.9,0.8,0;0,0,0.9,0.6;0,0,0,0.9]; % state to action mapping
    %ovObsMat2 = [0,0.1,0.1,0.1;0.1,0.1,0,0.1;0.1,0.1,0,0.1;0.1,0.1,0.1,0;0.1,0.1,0.1,0.1];
    detP = ovObsMat1(s,a);
    remP = 1 - detP;
    p = 0;
%     if ovObsMat1(s,a) > 0
%         if s==o
%             p = detP;
%         elseif o==nrobs
%             p = remP;
%         end
%     else
%         if ovObsMat2(s,a) > 0
%             remP = ovObsMat2(o,a);
%             p = remP;
%         elseif o==nrobs
%             p = 1-remP;
%         end
%     end
    if ovObsMat1(s,a) > 0 % means that a covers s 
        detP = ovObsMat1(s,a);
        if o==s
            p = detP;
        elseif o==nrobs
            p = 1 - detP;
        elseif ovObsMat1(o,a) > 0
            p = 0.1;
        end
    else                % means a does not cover s
        otemp = find(ovObsMat1(:,a)>0);
        %detP = ovObsMat2(s,a);
        for ip = 1:length(otemp)
        tempo = otemp(ip);
        if o==tempo
            p = 0.1;
        elseif o==nrobs
            p = 0.9;
        end
        end
    end



end


function obsProb = getObsProb(fState,fAction,fObs,nrobs,obsMat)

    obsProb = 1;
    for i = 1:length(fState)
        st = fState(i);
        obs = fObs(i);
        realAction = fAction(1);
        onePProb = onePersonObsProb(st,realAction,obs,nrobs,obsMat);
        obsProb = obsProb*onePProb;
    end
end



function O = getSampleObs(nrstates,nrobs,nraction,encodedStates,encodedAction,encodedObs,nrGrids,obsMat)

    nrg = nrGrids + 1;
    for s=1:nrstates
        for a = 1:nraction
            for o = 1:nrobs
                factoredState = encodedStates(s,:);
                factoredAction = encodedAction(a,:);
                factoredObs = encodedObs(o,:);
                O(s,a,o) = getObsProb(factoredState,factoredAction,factoredObs,nrg,obsMat);
            end
        end
    end
    for s = 1:nrstates
        for a = 1:nraction
            if(sum(O(s,a,:)) > 0)
                O(s,a,:) = O(s,a,:)./sum(O(s,a,:));
            end
        end
    end
end

function r = getIndividualReward(fState,fAction)

    r = 0;
    for i = 1:length(fState)
        is = fState(i);
        ia = fAction(i+1);
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