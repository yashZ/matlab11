# to run a sample problem - 

# Cov Rew - 
global problem
problem = generateProblemMP(4,1)
# add pbvi folder to matlab path
# to sample beliefs
S = sampleBeliefs(1000) # this uses global pomdp
# to run the solver
runPBVILean(S,4,0.01)
# to access solver pomdp  - Finale - Doshi Software
global backupStats
alphas = backupStats.Vtable{1}.alphaList
# define b, max(b*alphas, [],2) find alphaActions

# IR Rew - 
global problem
problem = generateProblemIR(4,1);
S = mySampleBeliefs(1000);
myrunPBVIIR(S,5,0.001);

# to run the wrapper 
wrapperRunSim
