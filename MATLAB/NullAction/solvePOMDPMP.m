function VFNorm = solvePOMDPMP(pomdp,h)

VFNorm = {};

for i = h
   
    i
    
    global problem
    problem = pomdp;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    global backupStats;
    VFNorm{i} = backupStats;
    %save('solvedPOMDP.mat','VFNorm');
end
end
