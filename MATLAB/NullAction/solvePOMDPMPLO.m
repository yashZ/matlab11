function VFLO = solvePOMDPMPLO(pomdp,h)

VFLO = {};

for i = h
   
    i
    
    global problem
    problem = pomdp;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    global backupStats;
    VFLO{i} = backupStats;
    %save('solvedPOMDPLO.mat','VFLO');
end
end
