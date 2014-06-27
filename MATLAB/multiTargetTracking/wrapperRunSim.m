clc;
clear all;
nPpl = 1;
nGrid = 4;
%txnV = [0.91, 0.7, 0.55];
txn = 0.85;
obsMat = [0.85,0.85,0.85,0.85;0.85,0.85,0.85,0.55;0.85,0.85,0.55,0.55];%0.85,0.55,0.55,0.55;0.55,0.55,0.55,0.55];


%for txni=1:length(txnV)
    %txn = txnV(txni);
    obsMi = 1;
%for obsMi = 1:3
    obsM = obsMat(obsMi,:);
%pomdp = generateProblemMP(nGrid,nPpl);
%pomdpLO = generateProblemMPLO(nGrid,nPpl);
%pomdpIR = generateProblemIR(nGrid,nPpl);
pomdpFB = generateProblemFixBudgIR(txn,obsM);
pomdpFBN = generateProblemFixBudgNorm(txn,obsM);
%pomdpFB = generateProblemFixBudgIR
%pomdpFBN = generateProblemFixBudgNorm();
%nGrid = 4; nPpl = 1;
nSteps = 50;

tempPomdp = generateProblemMP(nGrid,1,txn,obsM);
[VFFBN,S] = solvePOMDPFB(pomdpFBN,20,[]);
[VFFB,S] = solvePOMDPFB(pomdpFB,20,S);

for h = 2:4:20

%VF = solvePOMDPMP(pomdp,h);
%VFLO = solvePOMDPMPLO(pomdpLO,h);
%VFIR = solvePOMDPMPIR(pomdpIR,h);
%VFFB = solvePOMDPFB(pomdpFB,h);
%VFFBN = solvePOMDPFB(pomdpFBN,h);

for tt = 1:1000
    
    %[realPos(tt,:),obsPos(tt,:)] = simDataFromPomdp(tempPomdp,nStepsw);
    [r,o] = simDataFromPomdp(tempPomdp,nSteps);
    
    %pause
    %[rewRand(tt,:),aVecRand(tt,:)] = runMPSimulation(pomdp,realPos(tt,:),obsPos(tt,:),'Random',VF,h);
    %[rewCov(tt,:),aVecCov(tt,:)] = runMPSimulation(pomdpLO,realPos(tt,:),obsPos(tt,:),'LO',VFLO,h);
    %[rewN(tt,:),aVecN(tt,:)] = runMPSimulation(pomdp,realPos(tt,:),obsPos(tt,:),'Normal',VF,h);
    %[rewIR(tt,:),aVecIRN(tt,:),aVecIRP(tt,:)] = runMPSimulation(pomdpIR,realPos(tt,:),obsPos(tt,:),'IR',VFIR,h);
    %[rew(tt,:),act(tt,:)] = runFBSims(pomdpFB,r,o,VFFB,h);
    [rewN(tt,:),actN(tt,:)] = runFBSimsNorm(pomdpFBN,r,o,VFFBN,h);
    [rewIR(tt,:),actIR(tt,:)] = runFBSims(pomdpFB,r,o,VFFB,h);
    %pause
    %[rewN(tt,:),actN(tt,:)] = runFBSims(pomdpFBN,realPos(tt,:),obsPos(tt,:),VFFBN,h);
    
    
end
obsS(obsMi).stt(h).rewN = rewN;
obsS(obsMi).stt(h).rewIR = rewIR;
save('diffHFBRew.mat','obsS');
end
%end