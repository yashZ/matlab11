function sampleProb = generateProblemFixBudg()

% for one person only

nGrid = 4; nPpl = 1;
sampleProb.nrGrids = nGrid;
sampleProb.nrPpl = nPpl;
encodedStates = getEncodedStates(nGrid);
encodedObs = getEncodedObs(nGrid);
encodedAction = getEncodedAction(nGrid);
sampleProb.encodedStates = encodedStates;
sampleProb.encodedObs = encodedObs;
sampleProb.encodedAction = encodedAction;
sampleProb.gamma = 1;
nrStates = (10*nGrid);
nrAction = nGrid + 1;
nrObservation = nGrid + 2;
sampleProb.nrStates = nrStates;
sampleProb.nrActions = nrAction;
sampleProb.nrObservations = nrObservation;
t1 = (1/nGrid*(ones(1,nGrid)));
p2 = (zeros(1,(sampleProb.nrStates - nGrid)));
sampleProb.start = [t1,p2];
%sampleProb.start = (1/nrstates)*ones(1,nrstates);
sampleProb.observation = getSampleObs(encodedStates,encodedObs,nGrid);
sampleProb.transition = getSampleTrans(encodedStates,nGrid);
sampleProb.reward = getSampleReward(nrStates,nrAction,nGrid);

end

function encodedStates = getEncodedStates(nGrid)

    encodedStates = zeros((10*nGrid),2);
    %encStt = npermutek([1:nGrid],1);
    k=0;
    for i = 1:10
        for j = 1:nGrid
            k = k + 1;
            encodedStates(k,1) = i;
            encodedStates(k,2) = j;
        end
    end
end

function encodedObs = getEncodedObs(nGrid)

    encodedObs = zeros((10*(3)),2);
    %encStt = npermutek([1:(nGrid+1)],1);
    k = 0;
    for i = 1:10
        for j = 1:(3)
            k = k + 1;
            encodedObs(k,1) = i;
            encodedObs(k,2) = j;
        end
    end

end

function encodedAction = getEncodedAction(nGrid)

    nAction = nGrid + 1;
    encodedAction = [1:nAction];

end

function T = getSampleTrans(encodedStates,nGrid)

    nraction = nGrid + 1;
    nrstates = size(encodedStates,1);
    sameSttTxn = 0.7;
    defTxn = (1 - sameSttTxn)/2;
    
    for k = 1:nrstates
        for kd = 1:nrstates
            for a = 1:nraction
                pstt = encodedStates(k,:);
                nstt = encodedStates(kd,:);
                if a < nraction    
                    if ((nstt(1) - pstt(1)) == 1)
                        if (nstt(2) == pstt(2))
                            T(k,kd,a) = 0.7;
                        else
                            T(k,kd,a) = 0.1;
                        %elseif (abs(nstt(2) - pstt(2)) ==1) || (abs(nstt(2) - pstt(2))==nGrid)
                        %    T(k,kd,a) = 0.15;
                        %else
                        %    T(k,kd,a) = 0;
                        end                            
                    end
                else
                    if ((nstt(1) - pstt(1)) == 0)
                        if (nstt(2) == pstt(2))
                            T(k,kd,a) = 0.7;
                        else
                            T(k,kd,a) = 0.1;
                        %elseif (abs(nstt(2) - pstt(2)) ==1) || (abs(nstt(2) - pstt(2))==nGrid)
                        %    T(k,kd,a) = 0.15;
                        %else
                        %    T(k,kd,a) = 0;
                        end
                    end
                end
                if pstt(1)==10 && nstt(1)==10
                    if pstt(2)==nstt(2)
                        T(k,kd,a) = 0.7;
                    else
                        T(k,kd,a) = 0.1;
                    end
                end
            end
        end
    end
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


function O = getSampleObs(encodedStates,encodedObs,nGrid)
    
    nrobs = 3;
    nrstates = size(encodedStates,1);
    nraction = nGrid + 1;
    for s = 1:nrstates
        for a = 1:nraction
            for o = 1:size(encodedObs,1)
                stt = encodedStates(s,:);
                obs = encodedObs(o,:);
                stBdg = stt(1);
                obBdg = obs(1);
                if a==nraction
                    if ((obBdg-stBdg)==0 && obs(2)==3)
                        O(s,a,o) = 1;
                    else
                        O(s,a,o) = 0;
                    end
                else
                    if ((stBdg - obBdg) == 1)
                        if a==stt(2)
                            if (obs(2)==1)
                                O(s,a,o) = 0.9;
                            elseif obs(2)==2
                                O(s,a,o) = 0.1;    
                            end
                        else
                            if obs(2)==1
                                O(s,a,o) = 0.1;
                            elseif obs(2)==2
                                O(s,a,o) = 0.9;
                            end
                        end
                    end
                    %if (stBdg==10 && obBdg==10)
                    %    if a==stt(2)
                    %    end
                    %end
                end
            end
        end
    end
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



function R = getSampleReward(nrstates,nractions,nrst)

    for i = 1:nrstates
        for j = 1:nractions
            if (rem(i,nrst)>0)
                ns = rem(i,nrst);
            else
                ns = nrst;
            end
            if ns==j
                R(i,j) = 1;
            end
        end
    end
    for k=37:40
        for jk=1:nractions
            if jk<5
                R(k,jk) = -100;
            else
                R(k,jk) = 0;
            end
        end
    end
    
end