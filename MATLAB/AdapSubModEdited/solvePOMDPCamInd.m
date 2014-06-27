function VFLO = solvePOMDPCamInd(pomdp,h)

VFLO = {};

global problem
problem = pomdp;
S = sampleBeliefs(1000);

for i = 1:h
   
    i
        
    runPBVILean(S,i);
    global backupStats;
    VFLO{i} = backupStats;
    %save('solvedPOMDPLO.mat','VFLO');
end
end
