function [VFNorm,VFIR] = obsSolvePOMDP(nrStates)

VFNorm = {};
VFIR = {};

for i = 1:10
   
    global problem
    problem = generateProblemLO(nrStates);
    %problem.gamma = 0.9;
    S = sampleBeliefs(1000);
    runPBVILean(S,i,0.000001);
    
    global backupStats;
    VFNorm{i} = backupStats;
    
    %problem = generateProblemIR(nrStates);
    %problem.gamma = 1;
    %myrunPBVIIR(S,i,0.000001);
    
    %global backupStats;
    %VFIR{i} = backupStats;
    
end

%save('allValueFunction10States.mat','VFNorm');
%save('allValueFunctionIR10States.mat','VFIR');
save('VFNormGamma1States10R1x0StrucTxn.mat','VFNorm');

end
%solvePOMPD
%save
