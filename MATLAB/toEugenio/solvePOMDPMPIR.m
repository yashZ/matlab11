function VFIR = solvePOMDPMPIR(pomdp,h)

VFIR = {};

for i = h
   
    i
    
    global problem
    problem = pomdp;
    S = mySampleBeliefs(1000);
    myrunPBVIIR(S,i,0.000001);
    global backupStats;
    VFIR{i} = backupStats;
    %save('solvedPOMDPIR.mat','VFIR');
end
end
