    function [TAO vL] = myrunPBVIIR(S,h,epsilon)
    
    % function [TAO vL] = runPBVILean(S,h,epsilon)
% runs the point-based value iteration algorithm -- Lean version does not
% keep all of the old history; overwrites alpha vectors. (So iter is 1.)
%  S - set of beliefs
%  h - number of backups to perform
%  epsilon - convergence value
% to enable tree structuring later, we currently do NOT prune repeat
% vectors in the alpha set, instead keeping a vector per belief... if this
% is not needed in the future, vectors can easily be pruned using matlab's
% 'unique' or 'union' functions
%
% backup stats stores our solution and intermediate computations
%   backupStats.Q{ iter, belief number }(:, action ) = gamma^a_b 
%   backupStats.Qo{ iter, belief number, action,obs } = ind of maximizing
%       alpha vectors from the previous iteration in decreasing order
%       (currently there are 3 total stored)
%   backupStats.V{ iter }.v( bel number ) = alphaindex; alphalist(:,i) is vec
%   backupStats.Vtable{ iter }.alphaList( :,i ) = unique alpha vector list
%   backupStats.Vtable{ iter }.alphaUserSet{i} = bels that use alphalist(:,i)
%   backupStats.Vtable{ iter }.alphaAction(i) = action for alpha i
%   backupStats.Vtable{ iter }.alphaUse(i) = when alpha i was last used
% all vectors are COLUMN VECTORS

    clear global backupStats;
    global backupStats;
    global problem;

    useEps=0;
    if nargin==3
        useEps=1;
    end
    
    vL = [];
    TAO = createTAO;
    TgammaAB = cacheImmRew(S);
    beliefCount = size(S,1);
    QP = reshape(problem.reward,[1 problem.nrStates problem.nrActionsP]);
    QP = repmat(QP,[beliefCount 1 1]);
    Q = zeros(size(S,1),problem.nrStates,problem.nrActionsN);
    findBestQLean(S,Q,QP);
    [a1,v1] = getAction(S,backupStats.Vtable);
    
    for i = 1:h
        
        backupQ(S,TAO,TgammaAB);
        %pause
        
         if useEps
             [a2 v2] = getAction(S,backupStats.Vtable);
             conver = sum(abs(v2-v1));vL(:,i)=v1;v1=v2;
             if conver < epsilon
                 return;
             end
             disp(['Completed PBVI iter ' num2str(i) 'conv' num2str(conver) ]);
         else
             disp(['Completed PBVI iter ' num2str(i)]);
         end
    end
end

function TAO = createTAO
% when TAO{action}{obs} is multiplied by backupStats.Vtable{1}.alphaList,
% we get gammaAO
    global problem;
     TAO = cell(problem.nrActionsN,problem.nrObservations);    
     for action = 1:problem.nrActionsN
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

function TgammaAB = cacheImmRew(S)

    global problem;
    TgammaAP = problem.reward;
    [immRew,indsAP] = max(S*TgammaAP,[],2);
    TgammaAB = TgammaAP(:,indsAP);

end



function backupQ(S, TAO, TgammaAB)
    % computes the Q vectors for the next backup
    global problem;
    global backupStats;
    alphaCount = size(backupStats.Vtable{1}.alphaList,2);
    backupStats.Vtable{1}.alphaList;
    % first compute gammoAO, (return if are in state s, see o, do a)
    gammaANO = cell(problem.nrActionsN,1);
    for action = 1:problem.nrActionsN
        for obs = 1:problem.nrObservations
            gammaANO{action}{obs} = TAO{action}{obs} * backupStats.Vtable{1}.alphaList;
        end
    end
    QP = reshape(problem.reward,[1 problem.nrStates,problem.nrActionsP]);
    QP = repmat(QP,[size(S,1) 1 1]);
    
    % next pick q vectors for each belief
    for action = 1:problem.nrActionsN
       
        gammaAP = problem.reward;
        [vAP, iAP] = max(S*gammaAP,[],2);
        
        gammaAB = TgammaAB
        %gammaAB = gammaAP(:,iAP);
        for obs = 1:problem.nrObservations
            [ vals inds ] = max( S * gammaANO{action}{obs},[],2 );
            gammaAB = gammaAB + gammaANO{action}{obs}(:, inds);
        end
        Q(:,:,action) = gammaAB';
    end
    % update the V
    findBestQLean(S,Q,QP);
    
    % get rid of huge gamma structure
    clear gammaANO;
    clear gammaAP;
end


%------------------------------------------------------------
function findBestQLean(S,Q,QP)
    % updates backup stats for each q vector, belief
    global problem;
    global backupStats;
    
    % determine the best immediate reward vector and action
    for ap = 1:problem.nrActionsP
        valsP(:,ap) = sum(QP(:,:,ap).*S,2);
    end
    [maxvalsP, actP] = max(valsP');
    for apm = 1:problem.nrActionsP % select the best actions
        mask(:,:,apm) = repmat( transpose(actP == apm), 1, problem.nrStates );
    end
    vp = squeeze(sum(QP.*mask,3));
    ap = actP';
    clear mask;
    
    % first determine best alpha vector for each belief
    for ac = 1:problem.nrActionsN
        vals(:,ac) = sum( Q(:,:,ac) .* S,2 );
    end
    [maxVal action] = max(vals');
    for a = 1:problem.nrActionsN % select the best actions
        mask(:,:,a) = repmat( transpose(action == a), 1, problem.nrStates );
    end
    
    v = squeeze(sum( Q.*mask,3));
    a = action';
    clear mask;
    
    % best vector for both immediate action and future actions decided now
    % add them
    %vp 
    %v
    %pause
    
    final_vectors = v;
    new_a = [a,ap];
    % for debuggering
    % disp([' ** values are: ' num2str(maxVal)])
    
    % next prune the list to a unique set
    [ alphaList ind1 ind2 ] = unique( final_vectors, 'rows' );
    
    backupStats.Vtable{1}.alphaList = alphaList';
    backupStats.Vtable{1}.alphaAction = new_a( ind1,: );
end
