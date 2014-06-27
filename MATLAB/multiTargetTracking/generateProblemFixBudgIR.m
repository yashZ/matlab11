function sampleProb = generateProblemFixBudgIR(txn,obsMat)

% for one person only

nGrid = 4; nPpl = 1;budget = 20;
sampleProb.nrGrids = nGrid;
sampleProb.nrPpl = nPpl;
encodedStates = getEncodedStates(nGrid,budget);
encodedObs = getEncodedObs(nGrid,budget,encodedStates);
encodedAction = getEncodedAction(nGrid,encodedStates);
sampleProb.encodedStates = encodedStates;
sampleProb.encodedObs = encodedObs;
sampleProb.encodedAction = encodedAction;
sampleProb.gamma = 1;
nrStates = size(encodedStates,1);
nrAction = size(encodedAction,1);
nrObservation = length(encodedObs);
sampleProb.nrStates = nrStates;
sampleProb.nrActions = nrAction;
sampleProb.nrObservations = nrObservation;
t1 = (1/nGrid*(ones(1,nGrid)));
p2 = (zeros(1,(sampleProb.nrStates - nGrid)));
sampleProb.start = [t1,p2];
sampleProb.observation = getSampleObs(encodedStates,encodedObs,encodedAction,nGrid,budget,obsMat);
sampleProb.transition = getSampleTrans(encodedStates,encodedAction,nGrid,budget,txn);
sampleProb.reward = getSampleReward(nrStates,encodedAction,nGrid);

end

function encodedStates = getEncodedStates(nGrid,budget)

    encodedStates = zeros((budget*nGrid),2);
    k=0;
    for i = 1:budget
        for j = 1:nGrid
            k = k + 1;
            encodedStates(k,1) = i;
            encodedStates(k,2) = j;
        end
    end
end

function encodedObs = getEncodedObs(nGrid,budget,encodedStates)

%     encodedObs = zeros((budget*(2)),2);
%     %encStt = npermutek([1:(nGrid+1)],1);
%     k = 0;
%     for i = 1:budget
%         for j = 1:(2)
%             k = k + 1;
%             encodedObs(k,1) = i;
%             encodedObs(k,2) = j;
%         end
%     end
    encodedObs = [1,2];

end

function encodedAction = getEncodedAction(nGrid,encodedStates)

    k = 0
    for i = 1:(nGrid+1)
        for j = 1:size(encodedStates,1)
            k = 1 + k;
            encodedAction(k,:) = [i,j];
        end
    end
end

function T = getSampleTrans(encodedStates,encodedAction,nGrid,budget,txn)

    nraction = nGrid + 1;
    nrstates = size(encodedStates,1);
    sameSttTxn = txn;
    defTxn = (1 - sameSttTxn)/3;
    
    for k = 1:nrstates
        for kd = 1:nrstates
            for a = 1:size(encodedAction,1)
                pstt = encodedStates(k,:);
                nstt = encodedStates(kd,:);
                avar = encodedAction(a,:);
                if avar(1) < nraction    
                    if ((nstt(1) - pstt(1)) == 1)
                        if (nstt(2) == pstt(2))
                            T(kd,k,a) = sameSttTxn;
                        else
                            T(kd,k,a) = defTxn;
                        end                            
                    end
                else
                    if ((nstt(1) - pstt(1)) == 0)
                        if (nstt(2) == pstt(2))
                            T(kd,k,a) = sameSttTxn;
                        else
                            T(kd,k,a) = defTxn;
                        end
                    end
                end
                if pstt(1)==budget && nstt(1)==budget
                    if pstt(2)==nstt(2)
                        T(kd,k,a) = sameSttTxn;
                    else
                        T(kd,k,a) = defTxn;
                    end
                end
            end
        end
    end
end

function O = getSampleObs(encodedStates,encodedObs,encodedAction,nGrid,budget,obsMat)

    nrstates = size(encodedStates,1);
    nraction = size(encodedAction,1);
    for s = 1:nrstates
        for a = 1:nraction
            for o = 1:length(encodedObs)
                stt = encodedStates(s,:);
                avar = encodedAction(a,:);
                if avar(1)==(nGrid+1)
                    O(s,a,o) = 0.5;
                elseif avar(1)<=nGrid
                        if avar(1)==stt(2)
                            if (o==1)
                                p = obsMat(avar(1));
                                O(s,a,o) = p;
                            elseif (o==2)
                                O(s,a,o) = 1-p;    
                            end
                        else
                            if o==1
                                O(s,a,o) = 0.1;
                            elseif o==2
                                O(s,a,o) = 0.3;
                            end
                        end
                end
            end
        end
    end
    for s = 1:nrstates
        for a = 1:nraction
            for o = 1:length(encodedObs)
                if (s >= (nrstates - nGrid + 1))
                    O(s,a,o) = 0.5;
                end
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
 
    
    
% something wrong with obs function - obs function should be such that 
% agent gets no information in final states (where he has used all the
% budget
end


function R = getSampleReward(nrstates,encodedAction,nrst)

    nractions = size(encodedAction,1);
    R = zeros(nrstates,nractions);
    for i = 1:nrstates
        for j = 1:nractions
            avar = encodedAction(j,:);
            if i < (nrstates - nrst + 1)
                if i==avar(2)
                    R(i,j) = 1;
                end
            elseif (avar(1) == (nrst+1)) && (i == avar(2))
                R(i,j) = 1;
            end
        end
    end
end