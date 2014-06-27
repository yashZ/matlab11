function [VFNorm,VFIR] = solvePOMDP(nrStates)

VFNorm = {};
VFIR = {};

for i = 1:30
   
    global problem
    problem = generateProblem(nrStates);
    problem.gamma = 1;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VFNorm{i} = backupStats;
    
    problem = generateProblemIR(nrStates);
    problem.gamma = 1;
    myrunPBVIIR(S,i,0.000001);
    
    global backupStats;
    VFIR{i} = backupStats;
    
    
end

end
%solvePOMPD
%save
