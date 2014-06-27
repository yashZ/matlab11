function sampleProb = generateProblemCamPIR(nChoice)

nPpl = 1;
nCam = 4;
nCell = 4;
%nChoice = 2;
sampleProb.nCell = nCell;
sampleProb.gamma = 1;
encodedStates  = getEncodedStates(nPpl,nCell);
nrStates = size(encodedStates,1);
encodedActionN = getEncodedActionN(nCell,encodedStates,nChoice);
encodedActionP = getEncodedActionP(nCell,encodedStates,nChoice);
nrActionsN = size(encodedActionN,1);
nrActionsP = size(encodedActionP,1);
encodedObs = getEncodedObs(nPpl,encodedStates);
nrObservations = length(encodedObs);
sampleProb.encodedStates = encodedStates;
sampleProb.encodedActionN = encodedActionN;
sampleProb.encodedActionP = encodedActionP;
sampleProb.encodedObs = encodedObs;
sampleProb.nrStates = nrStates;
sampleProb.nrActionsN = nrActionsN;
sampleProb.nrActionsP = nrActionsP;
sampleProb.nrObservations = nrObservations;
sampleProb.start = (1/nrStates)*(ones(1,nrStates));
sampleProb.transition = getSampleTrans(nrStates,encodedActionN,encodedStates);
sampleProb.observation = getSampleObs(encodedActionN,encodedStates,encodedObs,nChoice);
sampleProb.reward = getSampleReward(encodedActionP,encodedStates,nChoice);

end

function encodedStates = getEncodedStates(nPpl,nCell)

    encS = npermutek([0:1:nPpl],nCell);
    k = 0;
    for j = 1:size(encS,1)
        if sum(encS(j,:))==nPpl
            k = k + 1;
            encodedStates(k,:) = encS(j,:);
        end
    end

end

function encodedActionN = getEncodedActionN(nCell,encodedStates,nChoice)
    
    k = 0;
    normEncoding = npermutek([1:nCell],nChoice)
    for i = 1:size(normEncoding,1)
            k = k+1;
            encodedActionN(k,:) = [normEncoding(i,:)];
    end
end

function encodedActionP = getEncodedActionP(nCell,encodedStates,nChoice)

    encodedActionP = encodedStates;
    
end

function encodedObs = getEncodedObs(nPpl,encodedStates)

    %encodedObs = [1:nPpl+1];
    encodedObs = encodedStates;

end


function T = getSampleTrans(nrStates,encodedAction,encodedStates)

%     txn = load('txnmat.mat');
    nrAction = size(encodedAction,1);
    
    for s = 1:nrStates
        for sd = 1:nrStates
            for a = 1:nrAction
                encS = encodedStates(s,:);
                encSd = encodedStates(sd,:);
                T(sd,s,a) = getIndvTrans(encS,encSd);
            end
        end
    end


    for i = 1:size(T,2)
        for j = 1:size(encodedAction,1)
            T(i,:,j) = T(i,:,j)./sum(T(i,:,j));
        end
    end
    
    for a = 1:size(T,3)
        g = T(:,:,a);
        T(:,:,a) = g';
    end
    
end

function tr = getIndvTrans(ps,ns)

%     probMat = [0.7,0.2,0.1;0.15,0.7,0.15;0.1,0.2,0.7];
% 
%     tr = 1;
%     for m = 1:length(ps)
%         tr = tr*probMat(ps(m)+1,ns(m)+1);
%     end

    tr = 1;
    for m = 1:length(ps)
        if ps(m)==ns(m)
            tr = tr*0.4;
        else
            tr = tr*0.2;
        end
    end
end

function O = getSampleObs(encodedAction,encodedStates,encodedObs,nChoice)

    nrAction = size(encodedAction,1);
    nrStates = size(encodedStates,1);
    nrObs = size(encodedObs,1);
    for s = 1:nrStates
        for a = 1:nrAction
            for o = 1:nrObs
                encS = encodedStates(s,:);
                encAt = encodedAction(a,:);
                camOn = encAt(1:nChoice);
                %encA = encAt(1);
                encO = encodedObs(o,:);
                O(s,a,o) = getIndvObs(encS,encO,camOn);
            end
        end
    end
    for s = 1:nrStates
        for a = 1:nrAction
            O(s,a,:) = O(s,a,:)./sum(O(s,a,:));
        end
    end
    
    
end

function obspr = getIndvObs(st,obs,a)

   obspr = 1;
   for i = 1:length(obs)
       ta = 0;
       for j = 1:length(a)
           if a(j)==i
               ta = 1;
           end
       end
       if ta==1
            if (st(i) == obs(i))
                obspr = obspr * 0.9;
            elseif (abs(st(i) - obs(i)) == 1)
                obspr = obspr * 0.1;
            else
                obspr = obspr * 0.01;
            end
       else
           obspr = obspr * 0.01;
       end
       %obspr
       %pause
   end


end

function R = getSampleReward(encodedAction,encodedStates,nChoice)

    nrStates = size(encodedStates,1);
    nrAction = size(encodedAction,1);
    for i = 1:nrStates
        for j = 1:nrAction
            r = 0;
            st = encodedStates(i,:);
            act = encodedAction(j,:);
            for t = 1:length(st)
                if (st(t)==act(t))
                    r=r+1;
                end
            end
            R(i,j) = r;
        end
    end
end