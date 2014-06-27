%function [] = run_time_vs_states()
clc;
clear all;
%nrstates = 4;

e1 = zeros(1,10000);
e2 = zeros(1,10000);

%horizon = [5,10,20];


%for hor=1:length(horizons)
%h = horizon(hor);

h = 5;
for iter = 4:30

global problem;
problem = generateProblem(iter);
iter

S = sampleBeliefs(1000);
% t1 = cputime;
% runPBVILean(S,h,0.01);
% global backupStats;
% alpha1 = backupStats.Vtable{1}.alphaList;
% e1(iter) = cputime - t1;
% size(alpha1)
problem = generateProblemIR(iter);

t2 = cputime;
myrunPBVIIR(S,h,0.01);
e2(iter) = cputime - t2;
global backupStats;
alpha2 = backupStats.Vtable{1}.alphaList;
size(alpha2)

%save('increasingsamplepsH5NS10.mat');
% 
% newS = mySampleBeliefs(100);
% 
% vals1 = newS*alpha1;
% vals2 = newS*alpha2;
% 
% [v1,i1] = max(vals1,[],2);
% [v2,i2] = max(vals2,[],2);
% 
% diff = v1-v2;
% [v,i] = find(diff==0);


end
%end