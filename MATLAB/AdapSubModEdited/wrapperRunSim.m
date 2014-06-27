clc;
clear all;
nPpl = 1;
nGrid = 4;
pomdp = generateProblemMP(nGrid,nPpl);
pomdpLO = generateProblemMPLO(nGrid,nPpl);
pomdpIR = generateProblemIR(nGrid,nPpl);
pomdpIRMC1 = generateProblemMCIR(nGrid,nPpl,1);
pomdpIRMC2 = generateProblemMCIR(nGrid,nPpl,2);
pomdpIRMC3 = generateProblemMCIR(nGrid,nPpl,3);
nSteps = 100;

tempPomdp = generateProblemMP(nGrid,1);

h = 4;
%VF = solvePOMDPMP(pomdp,h);
%VFLO = solvePOMDPMPLO(pomdpLO,h);
%VFIR = solvePOMDPMPIR(pomdpIR,h);
VFIRMC1 = solvePOMDPMPIR(pomdpIRMC1,h);
VFIRMC2 = solvePOMDPMPIR(pomdpIRMC2,h);
VFIRMC3 = solvePOMDPMPIR(pomdpIRMC3,h);

VFAll{1} = VFIRMC1;
VFAll{2} = VFIRMC2;
VFAll{3} = VFIRMC3;

save('VFAll.mat',VFAll);


% for tt = 1:50
%     [realPos,obsPos] = simulateIndData(nPpl,nSteps,nGrid,tempPomdp);
% 
%     %rewRand(tt,:) = runMPSimulation(pomdp,realPos,obsPos,'Random',VF,h);
%    
%     %[rewCov(tt,:),aVec(tt,:)] = runMPSimulation(pomdpLO,realPos,obsPos,'LO',VFLO,h);
%     %[rewN(tt,:),aVec(tt,:)] = runMPSimulation(pomdp,realPos,obsPos,'Normal',VF,h);
%     %rewIR(tt,:) = runMPSimulation(pomdpIR,realPos,obsPos,'IR',VFIR,h);
%     rewIRMC1(tt,:) = runMPSimulation(pomdpIRMC1,realPos,obsPos,'IR',VFIRMC1,h);
%     rewIRMC2(tt,:) = runMPSimulation(pomdpIRMC2,realPos,obsPos,'IR',VFIRMC2,h);
%     rewIRMC3(tt,:) = runMPSimulation(pomdpIRMC3,realPos,obsPos,'IR',VFIRMC3,h);
%     
% end