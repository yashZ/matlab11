function sampleProb = generateProblemCamIndp()

nPpl = 1;
nCell = 4;
nCamera = 4;

encodedStates = getEncodedStates(nPpl,nCell);
sampleProb.encodedStates = encodedStates;
encodedActionN = getEncodedAction(nCell,nCamera);
sampleProb.encodedAction = encodedActionN;
%encodedObs = getEncodedObs(nPpl,nCell);
sampleProb.gamma = 1;
encodedObs = encodedStates;
sampleProb.encodedObs = encodedObs;
nrStates = size(encodedStates,1);
nrObservation = size(encodedObs,1);
nrActionsN = size(encodedActionN,1);
nrActionP = nrStates
sampleProb.start = (1/nrStates)*(ones(1,nrStates));
encodedActionP = encodedStates;
sampleProb.nrActionsP = nrActionP;
sampleProb.encodedActionP = encodedActionP;
sampleProb.nrStates = nrStates;
sampleProb.nrObservations = nrObservation;
sampleProb.nrActionsN = nrActionsN;
sampleProb.transition = getSampleTransition(nrStates,encodedStates,nrActionsN);
sampleProb.observation = getSampleObs(nrStates,nrActionsN,nrObservation,encodedStates,encodedObs,encodedActionN);
sampleProb.reward = getSampleReward(nrStates,nrActionP,encodedStates,encodedActionP);

end

function encodedStates = getEncodedStates(nPpl,nCell)

    % case 1 - only 0 and 4s
    m1 = [4,0,0,0;0,4,0,0;0,0,4,0;0,0,0,4];
    % case 2 - 1 and 3s
    
    temp1 = npermutek([1,3,0,0],4);
    l = 0;
    for i = 1:size(temp1,1)
        if (sum(temp1(i,:)) == 4)
            l = l + 1;
            m2(l,:) = temp1(i,:);
        end
    end
    l=0;
    temp1 = npermutek([2,2,0,0],4);
    for i = 1:size(temp1,1)
        if sum(temp1(i,:))==4
            l = l + 1;
            m3(l,:) = temp1(i,:);
        end
    end
    m4 = [1,1,1,1];
    
    encodedStatestemp  = [m1;m2;m3;m4];
    encodedStates = unique(encodedStatestemp,'rows');
    
end

function encodedAction = getEncodedAction(nPpl,nCamera)

    encodedAction = npermutek([1:4],2);

end

function encodedObs = getEncodedObs(nPpl,nCell)

    %encodedObs = npermutek([1:nCell],nPpl);

end

function T = getSampleTransition(nrStates,encodedStates,nrAction)

    % 4 -> 1 0.1
    % 4 -> 2 0.2
    % 4 -> 3 0.3
    % 4 -> 4 0.4
    T = zeros(nrStates,nrStates,nrAction);
    
    for s = 1:nrStates
        for sd = 1:nrStates
            for a = 1:nrAction
                ps = encodedStates(s,:);
                ns = encodedStates(sd,:);
                covT = sum(abs(ps - ns));
                if covT==0
                    T(s,sd,a) = 0.4;
                elseif (covT == 1)
                    T(s,sd,a) = 0.3;
                elseif (covT == 2)
                    T(s,sd,a) = 0.2;
                elseif (covT==3)
                    T(s,sd,a) = 0.1;
                end
            end
        end
    end
    for i = 1:size(T,2)
        for j = 1:nrAction
            T(i,:,j) = T(i,:,j)./sum(T(i,:,j));
        end
    end
end

function O = getSampleObs(nrStates,nrAction,nrObs,encodedStates,encodedObs,encodedAction)

    O = zeros(nrStates,nrAction,nrObs);
    for i = 1:nrStates
       for j = 1:nrAction
           for k = 1:nrObs
               encstt = encodedStates(i,:);
               encact = encodedAction(j,:);
               encobs = encodedObs(k,:);
               cam1 = encact(1);cam2 = encact(2);
               st1=encstt(cam1); st2=encstt(cam2);
               obs1=encobs(cam1);obs2=encobs(cam2);
               if (abs(st1-obs1) + abs(st2-obs2)) == 0
                   O(i,j,k) = 0.5;
               elseif (abs(st1-obs1) + abs(st2-obs2)) == 1
                   O(i,j,k) = 0.3;
               elseif (abs(st1-obs1) + abs(st2-obs2)) == 2
                   O(i,j,k) = 0.2;
               else
                   O(i,j,k) = 0.05;
               end
           end
       end
    end
    
    for s = 1:nrStates
        for a = 1:nrAction
            O(s,a,:) = O(s,a,:)./sum(O(s,a,:));
        end
    end
end

function R = getSampleReward(nrStates,nrActionP,encodedStates,encodedActionP)

    for i = 1:nrStates
        for j = 1:nrActionP
            encstt = encodedStates(i,:);
            encact = encodedActionP(j,:);
            r = 0;
            for k = 1:length(encact)
                if encstt(k) == encact(k)
                    r = r + 1;
                end
            end
            R(i,j) = r;
        end
    end

end