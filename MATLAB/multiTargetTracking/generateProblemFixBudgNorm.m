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
nrAction = length(encodedAction);
nrObservation = length(encodedObs);
sampleProb.nrStates = nrStates;
sampleProb.nrActions = nrAction;
sampleProb.nrObservations = nrObservation;
t1 = (1/nGrid*(ones(1,nGrid)));
%t1(1) = 0.26;t1(4) = 0.25;
p2 = (zeros(1,(sampleProb.nrStates - nGrid)));
sampleProb.start = [t1,p2];
%sampleProb.start = (1/nrstates)*ones(1,nrstates);
sampleProb.observation = getSampleObs(encodedStates,encodedObs,encodedAction,nGrid,budget,obsMat);
sampleProb.transition = getSampleTrans(encodedStates,encodedAction,nGrid,budget,txn);
sampleProb.reward = getSampleReward(nrStates,encodedAction,nGrid,encodedStates);

end

function encodedStates = getEncodedStates(nGrid,budget)

    encodedStates = zeros((budget*nGrid),2);
    %encStt = npermutek([1:nGrid],1);
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
% 
%     k = 0
%     for i = 1:(nGrid+1)
%         for j = 1:size(encodedStates,1)
%             k = 1 + k;
%             encodedAction(k,:) = [i,j];
%         end
%     end
    encodedAction = [1:(nGrid+1)];
end

function T = getSampleTrans(encodedStates,encodedAction,nGrid,budget,txn)

    nraction = nGrid + 1;
    nrstates = size(encodedStates,1);
    sameSttTxn = txn;
    defTxn = (1 - sameSttTxn)/3;
    
    for k = 1:nrstates
        for kd = 1:nrstates
            for a = 1:length(encodedAction)
                pstt = encodedStates(k,:);
                nstt = encodedStates(kd,:);
                avar = encodedAction(a);
                if avar < nraction    
                    if ((nstt(1) - pstt(1)) == 1)
                        if (nstt(2) == pstt(2))
                            T(kd,k,a) = sameSttTxn;
                        else
                            T(kd,k,a) = defTxn;
                        %elseif (abs(nstt(2) - pstt(2)) ==1) || (abs(nstt(2) - pstt(2))==nGrid)
                        %    T(k,kd,a) = 0.15;
                        %else
                        %    T(k,kd,a) = 0;
                        end                            
                    end
                else
                    if ((nstt(1) - pstt(1)) == 0)
                        if (nstt(2) == pstt(2))
                            T(kd,k,a) = sameSttTxn;
                        else
                            T(kd,k,a) = defTxn;
                        %elseif (abs(nstt(2) - pstt(2)) ==1) || (abs(nstt(2) - pstt(2))==nGrid)
                        %    T(k,kd,a) = 0.15;
                        %else
                        %    T(k,kd,a) = 0;
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
    nraction = length(encodedAction);
    %nraction = length(encodedAction);
    for s = 1:nrstates
        for a = 1:nraction
            for o = 1:length(encodedObs)
                stt = encodedStates(s,:);
                avar = encodedAction(a);
                if avar==(nGrid+1)
                    O(s,a,o) = 0.5;
                    %else
                    %    O(s,a,o) = 0;
                elseif avar<=nGrid
                        if avar==stt(2)
                            p = obsMat(avar);
                            if (o==1)
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

%                 if a==nraction
%                     if (stt(1) == bdg) && o < 5
%                         O(stt,a,o) = 0.25;
%                     else
%                         O(stt,a,o) = 0;
%                     end
%                 else
%                     if (a==pos) && (bdg==stt(1))
%                         O(stt,a,o) = 0.9
%                     else
%                         O(stt,a,o) = 0.1;
%                     end
%                 end



function R = getSampleReward(nrstates,encodedAction,nrst,encodedStates)

    nractions = length(encodedAction);
    R = zeros(nrstates,nractions);
    for i = 1:nrstates
        for j = 1:nractions
            avar = encodedAction(j);
            stt = encodedStates(i,:);
            realSt = stt(2);
            if (realSt==j)
                R(i,j) = 1;
            end
        end
    end
%     for i=37:40
%         for j=1:nractions
%             if j<5
%                 R(i,j) = 0;
%             end
%         end
%     end
end



% function T = getSampleTrans(nrstates,nrobs,nractions,nrst)
% 
% sameStateTxn = 0.7;
% defTxn = (1 - sameStateTxn)/(2);
% 
% numtoadd = nrstates;
% 
%     for i = 1:nrstates
%         for j=1:nrstates
%             for k = 1:nractions
%                 if k < nractions
%                     if j == (i + nrst)
%                         T(i,j,k) = sameStateTxn;
%                     elseif j-i==nrst+1 || (rem(i,nrst)==1 && j-i==(2*nrst)-1) || (rem(i,nrst)>1 && (j-i) == (nrst-1))
%                         T(i,j,k) = defTxn;
%                     else
%                         T(i,j,k) = 0;
%                     end
%                 else
%                     if i==j 
%                         T(i,j,k) = sameStateTxn;
%                     elseif (rem(i,nrst)==1)
%                         if ((j-i)==1) || ((j-i)==nrst-1)
%                         %T(i,j,k) = getTxn(i,j,sameStateTxn,nrstates);
%                             T(i,j,k) = defTxn;
%                         end
%                     elseif (rem(i,nrst)==0)
%                         if ((i-j)==1) || ((i-j)==nrst-1)
%                             T(i,j,k) = defTxn;
%                         end
%                     elseif (rem(i,nrst)>1)
%                         if (abs(j-i)==1)
%                             T(i,j,k) = defTxn;
%                         end
%                     else
%                         T(i,j,k) = 0;
%                     end
%                 end
%             end
%         end
%     end
%     
%     for ii = 37:40
%         for jj=37:40
%             for kk=1:nractions
%                 kk
%                 if ii==jj
%                     T(ii,jj,kk) = sameStateTxn;
%                 elseif (abs(ii-jj)==1 || abs(ii-jj)==(nrst-1))
%                     T(ii,jj,kk) = defTxn;
%                 else 
%                     T(ii,jj,kk) = 0;
%                 end
%             end
%         end
%     end
% end


% function O = getSampleObs(encodedStates,encodedObs,nGrid)
%     
%     nrobs = 3; % 1 is person found , 2 is person not found.
%     nrstates = size(encodedStates,1);
%     nraction = nGrid + 1;
%     for s = 1:nrstates
%         for a = 1:nraction
%             for o = 1:nrobs
%                 stt = encodedStates(s,:);
%                 if a==nraction
%                     if (o == 3)
%                         O(s,a,o) = 1;
%                     else
%                         O(s,a,o) = 0;
%                     end
%                 else
%                     if a==stt(2)
%                         if o==1
%                             O(s,a,o) = 0.9;
%                         elseif o==2
%                             O(s,a,o) = 0.1;
%                         end
%                     else
%                         if o==1
%                             O(s,a,o) = 0.1;
%                         elseif o==2
%                             O(s,a,o) = 0.9;
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end