n = 1000;

%global problem
%problem = ppltrack;
t = cputime;
S = sampleBeliefs(n);
runPBVILean(S,2,0.001);
e = cputime-t

