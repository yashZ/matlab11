function particleFilterTrial1()

nrGrid = 4;
nrPpl = 2;
nrStep = 10;
tempPomdp = generateProblem(nrGrid,1);
N = 10;

[x,z] = simulateIndData(nrPpl,nrStep,nrGrid,tempPomdp);

initX = x(:,1);
initZ = z(:,1);

xEst = [];

for i = 1:N
    
    xEst(i) = 
    
end

end