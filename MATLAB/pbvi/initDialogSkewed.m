function problem = initDialogSkewed( optCount, rAsk, rConfWrong, rDoWrong, oAsk, oConf, oSkew, tSkew, extraObs );
% this creates initial problem
% structure = start -> opt -> done
% extra obs contains cell array of what states each extra obs maps to
% oSkew contains a cell for states that may be confused with the index state

% ------- INDEPENDENT PARAMETERS:
% set discount factor
gamma = .95;
% stateCount = start, number of options, done
% optCount = 5;

% for the PROBLEM
% transProb = probability of staying in same opt
transProb = .99;
% obsProb = probability of seeing correct observation if asking, conf-ing
% oAsk = .5;
% oConf = .9;
% initially there are five types of rewards - doWrong is for opts, nothing
% rAsk = -10;
rConfRight = -1;
% rConfWrong = -5;
rDoRight = 100;
rDoWrong = rDoWrong*ones(1,optCount+1);

% ------- DEPENDENT PARAMETERS:
% number of states is start, options, end
stateCount = optCount + 2;
% actions are organized by do '1..opt', conf '1..opt', askWhich, doNothing
actionCount = 2*optCount + 2;
% observations are see '1..opt', seeDone, seeConf, seeNo, extraObs
obsCount = optCount + 3 + size(extraObs,2);

% ------- SET UP PROBLEM
problem.gamma = gamma;
problem.nrStates = stateCount;
problem.nrActions = actionCount;
problem.nrObservations = obsCount;
problem.start = zeros(1,stateCount); problem.start(1) = 1;
problem.observation = createObsSkew( stateCount, actionCount, obsCount, ...
    oAsk, oConf, oSkew, extraObs );
problem.transition = createTransSkew( stateCount, actionCount, ...
    transProb, tSkew );
problem.reward = createReward( stateCount, actionCount, ...
    rAsk, rConfRight, rConfWrong, rDoRight, rDoWrong ); 
problem.maxReward = max(max( problem.reward ));

%-------------------------------------------------------------------------%
function transMat = createTransSkew( stateCount, actionCount, transProb, transSkew )
    % T(s',s,a) is the format; action are do, conf, ask, nothing
    % have a preferred option
    optCount = stateCount - 2;
    pMove = (1 - transProb)/optCount;
    
    % --- queries: small probability of switching to another opt or done
    queryMat = ones(stateCount, stateCount) * pMove;
    queryMat = queryMat + eye(stateCount,stateCount)*(transProb - pMove);
    queryMat(1,:) = zeros(1,stateCount);
    % done action stays done
    queryMat(:,stateCount) = zeros(stateCount,1); 
    queryMat(stateCount,stateCount) = 1;
    % start moves out equally likely
    queryMat(:,1) = [0 1 transSkew transSkew^2*ones(1,optCount-2) 0]';
    queryMat(:,1) = queryMat(:,1) / sum( queryMat(:,1) );
    
    for a = 1:actionCount
        transMat(:,:,a) = queryMat;
        
        % if this was a do action, correct state (a+1) moves to done
        if a <= optCount
             transMat(:,a+1,a) = [ zeros(1,optCount+1) 1];
        end
        
    end     
    
%-------------------------------------------------------------------------%
function obsMat = createObsSkew( stateCount, actionCount, obsCount, ...
    oAsk, oConf, askSkew, extraObs );

    % O(s,a,o) is the format; obs are opt, done, conf, no, extras
    optCount = stateCount - 2;
    obsMat = zeros(stateCount, actionCount, obsCount );
    pBadAsk = (1-oAsk)/(obsCount - 1);
    pBadConf = (1-oConf)/(obsCount - 1);
    
    % nomat is P(s,o) -- except done likely to seeDone always
    noInd = optCount + 3;
    noMat = ones(stateCount,obsCount)*pBadConf;
    noMat(:,noInd) = ones(stateCount,1)*oConf;
    noMat(stateCount,noInd) = pBadConf;
    noMat(stateCount,optCount+1) = oConf;
       
    % loop through actions
    for a = 1:actionCount
        obsMat(:,a,:) = noMat;
        
        % if you do something, expect to see done if the move was correct
        if a <= optCount
            obsMat(a+1,a,noInd) = pBadConf;
            obsMat(a+1,a,optCount+1) = oConf;
        % if you confirm, expect to see confirm if correct
        elseif a <= 2*optCount
            obsMat(a-optCount+1,a,noInd) = pBadConf;
            obsMat(a-optCount+1,a,optCount+2) = oConf;
        % if you ask which, expect to see state asked about (could be an
        % extra obs as well)
        elseif a == 2*optCount + 1
            askMat = ones(stateCount,obsCount) * pBadAsk;
            for s = 1:stateCount
                if s == 1
                    askMat(s,1:optCount) = oAsk;
                    for eo = 1:size( extraObs, 2 ); if any( extraObs{eo} > 0 ); 
                    askMat( s,optCount+3+eo ) = oAsk; end; end;
                elseif s == stateCount
                    askMat(s,optCount+1) = oAsk;
                    for eo = 1:size( extraObs, 2 ); if any( extraObs{eo} == s ); 
                    askMat( s,optCount+3+eo ) = oAsk; end; end;
                else
                    askMat(s,s-1) = oAsk;
                    if ~isempty( askSkew{s-1} ); askMat(s, askSkew{s-1} ) = oAsk^2; end;
                    for eo = 1:size( extraObs, 2 ); if any( extraObs{eo} == s ); 
                    askMat( s,optCount+3+eo ) = oAsk; end; end;
                end
            end
            askSum = sum( askMat , 2 );
            askMat = askMat ./ repmat( askSum, 1, obsCount );
            obsMat( :, a, : ) = askMat;
        end
    end
    obsMat = obsMat ./ repmat( sum(obsMat,3), [1 1 obsCount] );
    
%             % nearby confusions for the remainder:
%             optMat = eye(optCount,optCount) ...
%                 + diag(ones(1,optCount-1),1)*askSkew ...
%                 + diag(ones(1,optCount-1),-1)*askSkew ...
%                 + ones(optCount,optCount)*askSkew^2 ...
%                 - diag(ones(1,optCount-1),1)*askSkew^2 ...
%                 - diag(ones(1,optCount-1),-1)*askSkew^2 ...
%                 - eye(optCount,optCount)*askSkew^2;
%             optMat = optMat .* repmat( 1./sum(optMat), optCount, 1 );
%             obsMat(2:stateCount-1,a,1:optCount) = optMat;
            
%-------------------------------------------------------------------------%
function rewardMat = createReward( stateCount, actionCount, ...
    rAsk, rConfRight, rConfWrong, rDoRight, rDoWrong );
    % R(s,a) is the format; action are do, conf, ask, nothing
    optCount = stateCount - 2;
    rNothing = rDoWrong(end);
    rDoWrong(end) = [];
    
    % do action
    rewardMat(1:stateCount,1:optCount) = repmat(rDoWrong,stateCount,1);
    rewardMat(2:stateCount-1,1:optCount) = rewardMat(2:stateCount-1,1:optCount) ...
        + eye(optCount,optCount)*rDoRight - diag(rDoWrong);
    
    % conf action
    rewardMat(1:stateCount,optCount+1:2*optCount) = ones(stateCount,optCount)*rConfWrong;
    rewardMat(2:stateCount-1,optCount+1:2*optCount) = rewardMat(2:stateCount-1,optCount+1:2*optCount) ...
        + eye(optCount,optCount)*(rConfRight-rConfWrong);

    % ask action
    rewardMat(1:stateCount,2*optCount+1) = ones(stateCount,1)*rAsk;
    
    % do nothing action
    rewardMat(1:stateCount,2*optCount+2) = ones(stateCount,1)*rNothing;
    rewardMat(stateCount, 2*optCount+2) = 0;

%-------------------------------------------------------------------------%
function varMat = createRewardVariance( stateCount, actionCount, ...
    vAsk, vConfRight, vConfWrong, vDoRight, vDoWrong );
    % R(s,a) is the format; action are do, conf, ask, nothing
    optCount = stateCount - 2;
    vNothing = vDoWrong(end);
    vDoWrong(end) = [];
    
    % do action
    varMat(1:stateCount,1:optCount) = repmat(vDoWrong,stateCount,1);
    varMat(2:stateCount-1,1:optCount) = varMat(2:stateCount-1,1:optCount) ...
        + eye(optCount,optCount)*vDoRight - diag(vDoWrong);
    
    % conf action
    varMat(1:stateCount,optCount+1:2*optCount) = ones(stateCount,optCount)*vConfWrong;
    varMat(2:stateCount-1,optCount+1:2*optCount) = varMat(2:stateCount-1,optCount+1:2*optCount) ...
        + eye(optCount,optCount)*(vConfRight-vConfWrong);

    % ask action
    varMat(1:stateCount,2*optCount+1) = ones(stateCount,1)*vAsk;
    
    % do nothing action
    varMat(1:stateCount,2*optCount+2) = ones(stateCount,1)*vNothing;