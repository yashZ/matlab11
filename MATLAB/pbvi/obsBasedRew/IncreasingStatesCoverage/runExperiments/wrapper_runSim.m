clc;
clear all;

global problem;

rewNorm = {};
rewLO = {};

nrStates = 10;

allValueFunctionLO = VFNormLOGamma1
allValueFunction = VFNorm;

for p = 30
nrSteps = p;

for tp = 1 
    
realPos = simulateData(nrSteps,nrStates);
problem = generateProblem(nrStates);
 
rewNorm(tp,:) = runSimulationRun(problem,realPos,'Normal',allValueFunction,allValueFunctionLO);
%pause
%rewRandom(tp,:) = runSimulationRun(problem,realPos,'Random', allValueFunction,allValueFunctionLO);
%rewRotate(tp,:) = runSimulationRun(problem,realPos,'Rotate', allValueFunction,allValueFunctionLO);
%pause 
problem = generateProblemLO(nrStates);
rewLO(tp,:) = runSimulationRun(problem,realPos,'LO', allValueFunction,allValueFunctionLO);
 
%rewIR(tp,:) = runSimulationRun(problem,realPos,'IR', allValueFunction,allValueFunctionIR);
 
end
 
rewNorm30H{nrSteps} = rewNorm;
rewLO30H{nrSteps} = rewLO;
%rewRotate30H{nrSteps} = rewRotate;
%rewRandom30H{nrSteps} = rewRandom;

clear rewNorm;
clear rewLO;
clear rewRotate;
clear rewRandom;


end