clc;
clear all;


rewNorm30H = {};
rewIR30H = {};
rewRotate30H = {};
rewRandom30H = {};


nrStates = 10;
ValueFunctionLO = load('VFLOH2.mat');
%ValueFunction = load('VFNorm.mat');

allValueFunctionLO = ValueFunctionLO.VF;
%allValueFunction = ValueFunction.VFNorm;
nrstates = 10;

%problemN = generateProblem(nrstates);
problemLO = generateProblemLO(nrstates);

h = 2;

for p = 100
nrSteps = p;

for tp = 1:1000
    
realPos = simulateData(nrSteps,nrStates);
 
%rewNorm(tp,:) = runSimulationRun(problemN,realPos,'Normal',allValueFunction);
%pause
%rewRandom(tp,:) = runSimulationRun(problem,realPos,'Random', allValueFunction,allValueFunctionLO);
%rewRotate(tp,:) = runSimulationRun(problem,realPos,'Rotate', allValueFunction,allValueFunctionLO);
%pause 

rewLO(tp,:) = runSimulationRun(problemLO,realPos,'LO',allValueFunctionLO,h);
%rewIR(tp,:) = runSimulationRun(problem,realPos,'IR', allValueFunction,allValueFunctionIR);
%sum(rewNorm(tp,:))
sum(rewLO(tp,:))


end
 
%rewNorm30H{nrSteps} = rewNorm;
rewLO30H{nrSteps} = rewLO;
%rewRotate30H{nrSteps} = rewRotate;
%rewRandom30H{nrSteps} = rewRandom;

clear rewNorm;
clear rewLO;
clear rewRotate;
clear rewRandom;


end