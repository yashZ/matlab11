function VFIR = solvePOMDPCamIndIR(pomdpir,h)

    global problem
    problem = pomdpir;
    S = mySampleBeliefs(1000);
    myrunPBVIIR(S,2);
    global backupStats;
    VFIR = backupStats;

end