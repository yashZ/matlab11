function [gammaAO] = calcGammaAO(problem,backupStats)

    alphas = backupStats.Vtable{1}.alphaList;
    gammaAO = cell(problem.nrActions,1);
    
    for k = 1:size(alphas,2)
        alphas(:,k)
        tempG = [];
        for i = 1:problem.nrActions
            for j = 1:problem.nrObservations
                i;
                j;
                alphad = temp(problem,alphas(:,k));
                pause
                tempG = [tempG;alphad];
            end
            gammaAO{i}{j} = tempG;
        end
        
    end
    
end

function [alphad] = temp(problem,talpha)

    for action = 1:problem.nrActions
        for obs = 1:problem.nrObservations
            for s = 1:problem.nrStates
                t = 0;
                s
                for sd = 1:problem.nrStates
                    sd
                    action 
                    obs
                    ggg = problem.transition(s,sd,action)
                    ppp = problem.observation(sd,action,obs)
                    t = t + problem.transition(s,sd,action)*problem.observation(sd,action,obs)*talpha(sd)
                    pause
                end
                alphad(s) = t;
            end
        end
    end

end