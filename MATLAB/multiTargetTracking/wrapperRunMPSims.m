%wrapperRunMPSims

clc;
clear all
%global problem;

%txn = 0.85;
obsMat = [0.85,0.85,0.85,0.85;0.85,0.85,0.85,0.55;0.85,0.85,0.55,0.55];%0.85,0.55,0.55,0.55;0.55,0.55,0.55,0.55];

txn = 0.9;
%obsMat = [0.85,0.85,0.85,0.85];
nGrid = 4;
obsM = obsMat(1,:);
pomdpIR = generateProblemMP(nGrid,1,txn,obsM);
pomdpCov = generateProblemMPLO(nGrid,1,txn,obsM);
h = 5;
VFIR = solvePOMDPMP(pomdpIR,h);
VFCov = solvePOMDPMP(pomdpVov,h);
nSteps = 100;

for tt = 1:100
    
    [r,o] = simDataFromPomdp(pomdpIR,nSteps);
    [rewIR(tt,:),actIR(tt,:)] = runMPSimulation(pomdpIR,r,o,'Normal',VFIR,h);
    [rewCov(tt,:),actCov(tt,:)] = rumMPSimulation(pompdCov,r,o,'LO',VFCov,h);    
end