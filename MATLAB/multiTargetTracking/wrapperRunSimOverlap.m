%wrapperRunSimOverlap

clc
clear all
pomdpIR = generateProblemFBOverlap(4,1,0.7,[0.85,0.85,0.85,0.85]);
pomdpCov = generateProblemFBOverlapCov(4,1,0.7,[0.85,0.85,0.85,0.85]);

VFIR = solvePOMDPOV(pomdpIR,5);
VFCov = solvePOMDPOV(pomdpCov,5);
nSteps = 100;
for h = 2:3:5

for tt=1:100
    
    [r,o] = simDataFromPomdp(pomdpIR,nSteps);
    [rewIR(tt,:),act(tt,:)] = runMPSimulation(pomdpIR,r,o,'Normal',VFIR,h);
    [rewCov(tt,:),act(tt,:)] = runMPSimulation(pomdpCov,r,o,'LO',VFCov,h); 
end
stt(h).rewIR = rewIR;
stt(h).rewCov = rewCov;

end
