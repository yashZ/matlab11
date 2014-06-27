function [VFFB,S] = solvePOMDPFB(pomdp,h,S)

VFNorm = {};

for i = h
   
    i
    
    global problem
    problem = pomdp;
    disp('problem initiated');
    

    s = sampleBeliefs(100);
    problem.start = s(99,:);
    ss = sampleBeliefs(1000);
    S = [s;ss];
    problem.start = S(990,:);
    sss = sampleBeliefs(1000);
    S = [s;ss;sss];
    problem.start = S(1990,:);
    ssss = sampleBeliefs(1000);
    S = [s;ss;sss;ssss];
    disp('beliefs sampled');
    [tao,vl,VFFB] = runPBVILean(S,i);
    runPBVILean(S,1);
    global backupStats;
    VFFB{1} = backupStats;
    %save('solvedPOMDP.mat','VFNorm');
    
end
end
