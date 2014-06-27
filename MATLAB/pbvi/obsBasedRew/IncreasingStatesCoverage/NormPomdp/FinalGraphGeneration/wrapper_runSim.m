
clc;
clear all;


rewNorm30H = {};
rewIR30H = {};
rewRotate30H = {};
rewRandom30H = {};

h = 10;



for nrStates = 10
%ValueFunctionLO = load('VFLO.mat');
%ValueFunction = load('VFNorm.mat');

%allValueFunctionLO = ValueFunctionLO.VF;
%allValueFunction = ValueFunction.VFNorm;
%nrstates = 10;

problemN = generateProblem(nrStates);
problemLO = generateProblemLO(nrStates);

allValueFunction = solvePOMDPNorm(nrStates,h);
allValueFunctionLO = solvePOMDPLO(nrStates,h);

for p = 100
nrSteps = p;

for tp = 1:100
     
realPos = simulateData(nrSteps,nrStates);
  
rewNorm(tp,:) = runSimulationRun(problemN,realPos,'Normal',allValueFunction);
%pause
disp('Random---------')
%pause
rewRandom(tp,:) = runSimulationRun(problemN,realPos,'Random', allValueFunction);
disp('Rotate---------')
%pause
rewRotate(tp,:) = runSimulationRun(problemN,realPos,'Rotate', allValueFunction);
%pause 

rewLO(tp,:) = runSimulationRun(problemLO,realPos,'LO',allValueFunctionLO);
%rewIR(tp,:) = runSimulationRun(problem,realPos,'IR', allValueFunction,allValueFunctionIR);


sum(rewNorm(tp,:));
sum(rewLO(tp,:));
sum(rewRotate(tp,:));
sum(rewRandom(tp,:));

end
end
%rewNorm30{nrStates} = (sum(rewNorm))
%rewLO30{nrStates} = (sum(rewLO))
%rewRotate30{nrStates} = (sum(rewRotate))
%rewRandom30{nrStates} = (sum(rewRandom))


rewNorm30H{nrSteps} = rewNorm;
rewLO30H{nrSteps} = rewLO;
rewRotate30H{nrSteps} = rewRotate;
rewRandom30H{nrSteps} = rewRandom;

clear rewNorm;
clear rewLO;
clear rewRotate;
clear rewRandom;


end