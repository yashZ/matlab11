function VFFB = solvePOMDPOV(pomdp,h)

for i = h
   
    i
    
    global problem
    problem = pomdp;
    disp('problem initiated');
    S = sampleBeliefs(1000);
    disp('beliefs sampled');
    [tao,vl,VFFB] = runPBVILean(S,i);
    runPBVILean(S,1);
    global backupStats;
    VFFB{1} = backupStats;
    %save('solvedPOMDP.mat','VFNorm');
    
end

end