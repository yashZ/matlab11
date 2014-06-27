function sampleProb = generateProblemCamP(nChoice)

nPpl = 1;
nCam = 4;
nCell = 4;
%nChoice = 2;
sampleProb.gamma = 1;
encodedStates  = getEncodedStates(nPpl,nCell);
nrStates = size(encodedStates,1);
encodedAction = getEncodedAction(nCell,encodedStates,nChoice);
nrActions = length(encodedAction);
encodedObs = getEncodedObs(nPpl,encodedStates);
nrObservations = length(encodedObs);
sampleProb.encodedStates = encodedStates;
sampleProb.encodedAction = encodedAction;
sampleProb.encodedObs = encodedObs;
sampleProb.nrStates = nrStates;
sampleProb.nrActions = nrActions;
sampleProb.nrObservations = nrObservations;
sampleProb.start = (1/nrStates)*(ones(1,nrStates));
sampleProb.transition = getSampleTrans(nrStates,encodedAction,encodedStates);
sampleProb.observation = getSampleObs(encodedAction,encodedStates,encodedObs,nChoice);
sampleProb.reward = getSampleReward(encodedAction,encodedStates,nChoice);

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

function encodedAction = getEncodedAction(nCell,encodedStates,nChoice)
    
    k = 0;
    normEncoding = npermutek([1:nCell],nChoice)
    for i = 1:size(normEncoding,1)
        for j = 1:size(encodedStates,1)
            k = 1 + k;
            encodedAction(k,:) = [normEncoding(i,:),encodedStates(j,:)];
        end
    end

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
            tr = tr*0.2;
        elseif abs(ns(min(m+1,length(m))) - ps(m)) == 1 && abs(ns(max(m-1,1)) - ps(m)) ==1 
            tr = tr*0.8;
        else
            tr = tr*0.01;
        end
    end
    
    [v,psms] = find(ps>0);
    [v,nsms] = find(ns>0);
    
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

   ln = length(obs);
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
   %st
   %obs
   %a
   %obspr
   %pause
%    if st(a) == obs
%        pr = 0.8;
%    elseif abs(st(a) - obs) == 1
%        pr = 0.1;
%    else
%        pr = 0;
%    end
   %obspr = obspr*probMat(st(a)+1,obs);
%   obspr = obspr*pr;

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
                if (st(t)==act(t+nChoice))
                    r=r+1;
                end
            end
            R(i,j) = r;
        end
    end
end