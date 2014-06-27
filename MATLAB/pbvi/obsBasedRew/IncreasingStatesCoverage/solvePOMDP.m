function [VFNorm,VFIR] = solvePOMDP(nrStates)

VFNorm = {};
VFIR = {};


for i = 30
   
    i
    global problem
    problem = generateProblem(nrStates);
    problem.gamma = 1;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VFNorm{i} = backupStats;
    
    %problem = generateProblemIR(nrStates);
    %problem.gamma = 1;
    %myrunPBVIIR(S,i,0.000001);
    
    
    %global backupStats;
    %VFIR{i} = backupStats;
    
    problem = generateProblemLO(nrStates);
    problem.gamma = 1;
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VFLO{i} = backupStats;
    
end

save('VFLO1.mat','VFLO');
save('VFNorm1.mat','VFNorm');


end
%solvePOMPD
%save
