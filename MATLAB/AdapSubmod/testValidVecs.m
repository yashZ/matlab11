function usedI = testValidVecs()

    global problem;
    problem = generateProblemMP(6,1);
    S = sampleBeliefs(100);
    runPBVILean(S,32,0.0001);
    global backupStats;
    alphas = backupStats.Vtable{1}.alphaList;
    backupStats.Vtable{1}.alphaAction
    for t = 1:size(S,1)
        b = S(t,:);
        [v,i] = max((b*alphas),[],2);
        usedI(t) = backupStats.Vtable{1}.alphaAction(i)
        %usedI(t) = i;
    end

    tempPomdp = generateProblem(4,1);
    [realPos,obsPos] = simulateIndData(1,10,4,tempPomdp);
    for i = 1:realPos
        r = realPos(i)
        o = obsPos(i)
        
        
    end
    
    
end
