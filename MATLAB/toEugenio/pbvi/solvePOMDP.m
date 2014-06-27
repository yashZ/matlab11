
clc
clear all

VFNorm = {};
VFIR = {};


for i = 1:30
   
    i
    global problem
    problem = generateProblem(4);
    %problem.gamma = 0.1;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.01);
    
    global backupStats;
    VFNorm{i} = backupStats;
    
    problem = generateProblemIR(4);
    %problem.gamma = 0.1;
    myrunPBVIIR(S,i,0.01);
    
    global backupStats;
    VFIR{i} = backupStats;
    
    
end

%solvePOMPD
%save
