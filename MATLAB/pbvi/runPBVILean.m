function [TAO vL] = runPBVILean(S,h,epsilon)
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

% check for epsilon
useEps = 0;
if nargin == 3
    useEps = 1;
end

% intermediate useful stuffies
vL = [];
TAO = createTAO;

% initialize the q and alpha vectors
% Q(i,:,k) is the q-vector for action k in belief i
beliefCount = size(S,1);

% FAST VERSION : first permute Q into dimensions 2 and 3 (tip on side),
% then replicate slice for every belief
Q = reshape( problem.reward, [1 problem.nrStates problem.nrActions] );
Q = repmat( Q, [beliefCount 1 1 ] );

% SLOW VERSION
% for i = 1:beliefCount;
%         Q(i,:,:) = problem.reward;
% end
findBestQLean(S,Q);

% debug -- progress reporter
[a1 v1] = getAction( S, backupStats.Vtable );

% perform dynamic programming backups
for i = 2:h
    
    backupQ(S, TAO);
    
    % convergence/progress reporter
    if useEps
        [a2 v2] = getAction( S, backupStats.Vtable );
        conver = sum(abs(v2-v1)); vL(:,i) = v1; v1 = v2;
        if conver < epsilon
            i
            return;
        end
        disp(['Completed PBVI iter ' num2str(i) ' conv ' num2str(conver)  ]);
    else
        disp(['Completed PBVI iter ' num2str(i)]);
    end
end

% initialize to when the alphaList was initiated
global backupStats;
backupStats.Vtable{end}.alphaUse = cputime * ones(length(backupStats.Vtable{end}.alphaAction),1);

%------------------------------------------------------------------------
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
            tprob';
            action;
            obs;
            TAO{action}{obs} = tprob;
            %pause
        end
    end

% include beliefs which are necessary
%------------------------------------------------------------------------
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
            
            %% changed line
            %size(backupStats.Vtable{1}.alphaList')
            %size(TAO{action}{obs})
            %gammaAO{action}{obs} = backupStats.Vtable{1}.alphaList'*TAO{action}{obs};
            %gammaAO{action}{obs} = gammaAO{action}{obs}';
            %tempT = TAO{action}{obs} * 1;
            %gammaAO{action}{obs} = gammaAO{action}{obs};
            %pause
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
        action
        Q(:,:,action) = gammaAB';
        %gammaAO{action}{obs};
        %pause
    end
    
    
    
    
    % update the V
    findBestQLean(S,Q);
    
    % get rid of huge gamma structure
    clear gammaAO;
    
%-------------------------------------------------------------------------
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
    % disp([' ** values are: ' num2str(maxVal)];
    % next prune the list to a unique set
    [ alphaList ind1 ind2 ] = unique( v, 'rows' );
    backupStats.Vtable{1}.alphaList = alphaList';
    backupStats.Vtable{1}.alphaAction = a( ind1 );
    % SLOWER VERSION OF THE (SINGLE) LINE ABOVE
    %     for i = 1:length(ind1)
    %         backupStats.Vtable{1}.alphaAction(i) = a( ind1(i) );
    %     end

    % OBSOLETE, SINCE NO ONE CARES ABOUT WHICH ALPHA VECTOR YOU REPRESENT
    % store alpha users, alpha used by each belief
    %     alphaUserSet{ length( ind1 ) } = [];
    %     for i = 1:size(S,1)
    %         backupStats.V{1}.v( i ) = ind2( i );
    %         alphaUserSet{ ind2(i) }(end + 1) = i;
    %     end
    %     backupStats.Vtable{1}.alphaUserSet = alphaUserSet;