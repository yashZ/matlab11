function solvePOMDP(nrStates, h)

VFNorm = {};

disp(pwd)

for i = h
   
    i
    
    global problem
    problem = generateProblem(nrStates);
    problem.gamma = 1;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VFNorm{i} = backupStats;

    save('solvedPOMDP.mat','VFNorm');

end


end
%solvePOMPD
%save
