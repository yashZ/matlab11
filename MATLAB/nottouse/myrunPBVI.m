function [TAO vL] = myrunPBVI(S,h,epsilon)
    clear global backupStats;
    global backupStats;
    global problem;

    useEps=0;
    if nargin==3
        useEps=1;
    end
    
    vL = [];
    TAO = createTAO;
    beliefCount = size(S,1);
    Q = reshape(problem.reward,[1 problem.nrStates,problem.nrActions]);
    Q = repmat(Q,[beliefCount 1 1]);
    findBestQLean(S,Q);
    
    [a1,v1] = getAction(S,backupStats.Vtable);
    
    for i = 2:h
        backupQ(S,TAO);

        
        if useEps
            [a2 v2] = getAction(S,backupStats.Vtable);
            conver = sum(abs(v2-v1));vL(:,i)=v1;v1=v2;
            if conver > epsilon
                return;
            end
        else
            disp(['Completed PBVI iter ' num2str(i)]);
        end
    end
    
end

function TAO = createTAO
% when TAO{action}{obs} is multiplied by backupStats.Vtable{1}.alphaList,
% we get gammaAO
    global problem;
     TAO = cell(problem.nrActions,problem.nrObservations);    
     for action = 1:problem.nrActions
        for obs = 1:problem.nrObservations
     
            % compute transition matrix                        
            tprob = problem.transition(:,:,action);
            oprob = problem.observation(:,action,obs);
            for i = 1:problem.nrStates
                tprob(:,i) = tprob(:,i) .* (oprob);
            end
            tprob = tprob * problem.gamma;
            TAO{action}{obs} = tprob';
        end
     end
end

function findBestQLean(S,Q)
    % updates backup stats for each q vector, belief
    global problem;
    global backupStats;
    
    % first determine best alpha vector for each belief
    for ac = 1:problem.nrActions
        vals(:,ac) = sum( Q(:,:,ac) .* S,2 );
    end
    [maxVal action] = max(vals');
    for a = 1:problem.nrActions % select the best actions
        mask(:,:,a) = repmat( transpose(action == a), 1, problem.nrStates );
    end
    v = squeeze(sum( Q.*mask,3));
    a = action';
    clear mask;
    
    % for debuggering
    % disp([' ** values are: ' num2str(maxVal)])
    
    % next prune the list to a unique set
    [ alphaList ind1 ind2 ] = unique( v, 'rows' );
    backupStats.Vtable{1}.alphaList = alphaList';
    
    backupStats.Vtable{1}.alphaAction = a( ind1 );
end

function backupQ(S, TAO)
    % computes the Q vectors for the next backup
    global problem;
    global backupStats;
    alphaCount = size(backupStats.Vtable{1}.alphaList,2);
    
    % first compute gammoAO, (return if are in state s, see o, do a)
    gammaAO = cell(problem.nrActions,1);
    for action = 1:problem.nrActions
        for obs = 1:problem.nrObservations
            gammaAO{action}{obs} = TAO{action}{obs} * backupStats.Vtable{1}.alphaList;
        end
    end
    
    % next pick q vectors for each belief
    for action = 1:problem.nrActions
        
        % add expected return for each obs + action
        gammaAB = repmat( problem.reward(:,action)  ,1,size(S,1)  );
        for obs = 1:problem.nrObservations
            [ vals inds ] = max( S * gammaAO{action}{obs},[],2 );
            gammaAB = gammaAB + gammaAO{action}{obs}(:, inds);
        end
        Q(:,:,action) = gammaAB';
    end
    
    
    % update the V
    findBestQLean(S,Q);
    
    % get rid of huge gamma structure
    clear gammaAO;
end
