function bel = updateBelief( pomdp, prev_bel, action, obs );
    % function bel = updateBelief( pomdp, prev_bel, action, obs );
    % updates the belief given a NON-permuted pomdp
    % beliefs should be COLUMN vectors
    % if no observation is given, just does an update based on the
    % transition matrix
    % obs can be a matrix or a single value -- should be a ROW
    
    % check if we're using observations
    if nargin == 3
        useObs = false;
    else
        useObs = true;
    end
    
    % update transition
    action_bel = pomdp.transition(:,:,action) * prev_bel;
    bel = action_bel;
    
    % update observation -- single observation case
    if useObs == true
        
        % single update
        if length(obs) == 1
                
                
                bel = bel .* pomdp.observation(:,action,obs);

        % multiple (expectation) update
        else
            belmat = repmat( bel, 1, pomdp.nrObservations ) .* ...
                squeeze( pomdp.observation(:,action,:) );
            belmat = repmat( obs, pomdp.nrStates, 1 ) .* ...
                belmat;
            bel = sum(belmat');
            bel = bel'; 
        end
    end
    
    % normalize -- watch for invalid observations!!
    if sum(bel) == 0
        bel = action_bel;
        disp('warning -- invalid observation');
    else
        bel = bel/sum(bel);
    end
        
    