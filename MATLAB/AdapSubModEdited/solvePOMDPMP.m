function VFNorm = solvePOMDPMP(pomdp,h)

VFNorm = {};

for i = h
   
    i
    
    global problem
    problem = pomdp;
    disp('problem initiated');
    S = sampleBeliefs(1000);
    disp('beliefs sampled');
    runPBVILean(S,i,0.000001);
    global backupStats;
    VFNorm{i} = backupStats;
    %save('solvedPOMDP.mat','VFNorm');
    
end
end
