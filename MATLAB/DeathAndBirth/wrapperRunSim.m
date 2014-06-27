clc;
clear all;
nPpl = 2;
nGrid = 4;
%pomdp = generateProblemMP(nGrid,nPpl);
pomdpLO = generateProblemMPLO(nGrid,nPpl);
%pomdpIR = generateProblemIR(nGrid,nPpl);
nSteps = 50;

tempPomdp = generateProblemMP(nGrid,1);

h = 30;

%VF = solvePOMDPMP(pomdp,h);
VFLO = solvePOMDPMPLO(pomdpLO,h);
%VFIR = solvePOMDPMPIR(pomdpIR,h);

for tt = 1:100
    [realPos,obsPos] = simulateIndData(nPpl,nSteps,nGrid,tempPomdp);

    %rewRand(tt,:) = runMPSimulation(pomdp,realPos,obsPos,'Random',VF,h);
    rewCov(tt,:) = runMPSimulation(pomdpLO,realPos,obsPos,'LO',VFLO,h);
    %rewN(tt,:) = runMPSimulation(pomdp,realPos,obsPos,'Normal',VF,h);
    %rewIR(tt,:) = runMPSimulation(pomdpIR,realPos,obsPos,'IR',VFIR,h);
    
end