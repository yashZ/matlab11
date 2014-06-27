clc;
clear all;

global problem;

rewNorm30H = {};
rewIR30H = {};
rewRotate30H = {};
rewRandom30H = {};

for p = 1:30
nrSteps = p

for tp = 1:100

tp;
nrSTates = 10;

load NormValueFunctionIRGamma1on1NewModel.mat
load NormValueFunctionGamma1on1NewModel.mat

%global allVFN;
%global allVFIR;

%allVFN = allValueFunction;
%allVFIR = allValueFunctionIR;

allValueFunction = VFNorm;
allValueFunctionIR = VFIR;

realPos = simulateData(nrSteps);
problem = generateProblem(nrStates);

rewNorm(tp,:) = runSimulationRun(problem,realPos,'Normal',allValueFunction,allValueFunctionIR);
rewRandom(tp,:) = runSimulationRun(problem,realPos,'Random', allValueFunction,allValueFunctionIR);
rewRotate(tp,:) = runSimulationRun(problem,realPos,'Rotate', allValueFunction,allValueFunctionIR);

problem = generateProblemIR(4);

rewIR(tp,:) = runSimulationRun(problem,realPos,'IR', allValueFunction,allValueFunctionIR);

end

rewNorm30H{nrSteps} = rewNorm;
rewIR30H{nrSteps} = rewIR;
rewRotate30H{nrSteps} = rewRotate;
rewRandom30H{nrSteps} = rewRandom;

clear rewNorm;
clear rewIR;
clear rewRotate;
clear rewRandom;


end