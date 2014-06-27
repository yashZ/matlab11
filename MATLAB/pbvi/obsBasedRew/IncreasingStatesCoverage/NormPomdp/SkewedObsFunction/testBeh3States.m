global problem
problem = generateProblem(5);
S = sampleBeliefs(100);
runPBVILean(S,2,0.0001);
global backupStats

%b = problem.start;
alphas = backupStats.Vtable{1}.alphaList;
[v,i] = max((b'*alphas),[],2);
a = backupStats.Vtable{1}.alphaAction(i)

b = updateBelief(problem,b,a,5)
