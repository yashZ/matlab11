function solvePOMDP(nrStates,h)

VF = {};
VFIR = {};

disp(pwd)

for i = h
   
    i
    
    global problem
    problem = generateProblemLO(nrStates);
    problem.gamma = 1;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VF{i} = backupStats;

    save('solvedPOMDP.mat','VF');

end


end
%solvePOMPD
%save
