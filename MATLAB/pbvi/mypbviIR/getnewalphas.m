
function finalvecs =  getnewalphas(alphas,alphaCount)
global problem;
clear t;
clear newalphas;

newalphas = zeros(problem.nrActionsN,problem.nrObservations);
finalvecs = cell(problem.nrActionsN,problem.nrObservations);
gamma = 0.95;

T = problem.transition;
O = problem.observation;
alphaCount
alphas

t = zeros(1,problem.nrStates);
for action=1:problem.nrActionsN
    for obs = 1:problem.nrObservations
        for al=1:alphaCount
            alpha=alphas(:,al);
            %pause
            for state=1:problem.nrStates
                sumoverstate=0;
                for nextstate=1:problem.nrStates
                    state;
                    %pause
                    nextstate;
                    %pause
                    T(state,nextstate,action);
                    O(nextstate,action,obs);
                    s = gamma*T(state,nextstate,action)*O(nextstate,action,obs)*alpha(nextstate);
                    sumoverstate = sumoverstate + s;
                end 
                t(state) = sumoverstate;
                %pause
            end
            newalphas(al,:) = t;
        end
        finalvecs{action}{obs} = newalphas
    end
end
end
