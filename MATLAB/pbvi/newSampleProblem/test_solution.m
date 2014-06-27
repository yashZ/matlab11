function test_solution()

n = 4;h = 2;
global problem;
problem = generateProblem(n);

S = sampleBeliefs(100);
runPBVILean(S,h,0.01);

global backupStats;
alphas = backupStats.Vtable{1}.alphaList;

actions = 1:12;
notOptimalActions = 13:16;

S = sampleBeliefs(10);
%for st = 1:length(S)
    
    %s = S(st,:)
    s = [0.2446,0.1495,0.0202,0.5856];
    [v,i] = max((s*alphas),[],2);
    a = backupStats.Vtable{1}.alphaAction(i,:);
    o = floor((a-1)/n) + 1
    nb = updateBelief(problem,s',a,o)
    r1 = max(nb);
    nb = updateBelief(problem,s',a,5);
    r2 = max(nb);
    fin_rew_old = r1 + r2
    
    for noat = 1:length(notOptimalActions)
        noa = notOptimalActions(noat);
        o = floor((noa-1)/n) + 1;
        nb = updateBelief(problem,s',noa,o);
        r1 = max(nb);
        nb = updateBelief(problem,s',noa,5);
        fin_rew_new = r1 + r2
    end
    
    
%end


end
