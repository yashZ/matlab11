% ----- INITIALIZATION ------ %
clear all;
% repcount = trials, testCount = dialogs/trial, maxIterCount = max interactions/dialog
repCount = 10;
testCount = 20;
maxIterCount = 50; 

% number of belief sample to use to estimate value function
sampleCount = 500; 

% number of iterations to solve value function
pbviIterCount = 10;

% number of places to go
optCount = 5;

% params for rewards, obs, trans
rAsk = -2; rConfWrong = -10; rDoWrong = -100;
sim_rAsk = -1; sim_rConfWrong = -5; sim_rDoWrong = -500;
oAsk = .7; oConf = .9;
sim_oAsk = .6; sim_oConf = .9;
tSkew = 1; oSkew = cell( 1,optCount+2 );
sim_tSkew = .5; sim_oSkew = cell(1,optCount+2); sim_oSkew{2} = [3 4]; sim_oSkew{3} = [4]; 
extraObs = [];

% initialize problem, simulated problem
global problem; problem = initDialogSkewed( optCount, rAsk, rConfWrong, rDoWrong, oAsk, oConf, oSkew, tSkew, extraObs );
global sim_pomdp; sim_pomdp = initDialogSkewed( optCount, sim_rAsk, sim_rConfWrong, sim_rDoWrong, sim_oAsk, sim_oConf, sim_oSkew, sim_tSkew, extraObs );

% ----- LOOP ------ %
for tind = 1:repCount;
   disp(['starting new rep ' num2str(tind) ]);

        % solve the problem
        S = sampleBeliefs( sampleCount, 'pbvi-far' );
        runPBVILean(S, pbviIterCount);
        global backupStats;
        disp('completed belset, algorithm');
   
        % ----- EVALUATION ------ %
        for i = 1:testCount

            % initialize test
            reward = 0;
            value = 0;
            new_reward = 0;
            iterCount = 0;
            state = 1;
            bel = sim_pomdp.start; bel = bel';

            clear history;
            % loop until maxed or done
            if episodeEnded( reward, state )
                disp( 'episode ended' );
            end
            
            while( iterCount < maxIterCount && episodeEnded( new_reward,state) == false )

                % get an action
                action = getAction( bel', backupStats.Vtable );

                % sample a transition and update reward
                next_state = sampleDist( sim_pomdp.transition(:, state, action ), 1 );
                new_reward = sim_pomdp.reward( state, action );
                reward = reward + new_reward;
                value = value + new_reward * sim_pomdp.gamma ^ (iterCount);

                % sample an observation from the current state
                obs = sampleDist( sim_pomdp.observation( state, action, :), 1 );
                
                % store history so far
                history(iterCount+1, 1) = obs;
                history(iterCount+1, 2) = action;
                history(iterCount+1, 3) = sim_pomdp.reward( state, action );
                history(iterCount+1, 4) = state;

                % update belief
                state = next_state;
                bel = updateBelief(problem, bel, action, obs );

                % update the iters
                iterCount = iterCount + 1;

            end

            % store reward information
             valvec(i, tind) = value;
             rvec( i,tind ) = reward;
             ivec( i,tind ) = iterCount;
             histarray{i,tind} = history;
             
        end % tests
        save testData valvec rvec ivec histarray
        
end % repCount
save testData valvec rvec ivec histarray 