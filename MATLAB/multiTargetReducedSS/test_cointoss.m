%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right Obs + Right Obs

b = [0.5,0.5];

pomdp = generateProblemMPLO(2,1);

a = 1;
o = 1;
bd = updateBelief(pomdp,b',a,o)

expRewL1R = 0.95*max(bd);
bdd = updateBelief(pomdp,bd,a,o)

expRewRR = (0.95)*max(bd) + 0.95*max(bdd);
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right Obs + Wrong Obs

a = 1;
o = 3;
bdd = updateBelief(pomdp,bd,a,o)
expRewRW = 0.95*max(bd) + 0.05*max(bdd);
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wrong Obs + Right Obs

a = 1;
o = 3;
bd = updateBelief(pomdp,b',a,o)
expRewL1W = 0.05*max(bd);

a = 1; o = 1;
bdd = updateBelief(pomdp,bd,a,o)
expRewWR = 0.05*max(bd) + 0.95*max(bdd);
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Wrong Obs + Wrong Obs

a = 1; o = 3;
bd = updateBelief(pomdp,b',a,o)
a = 1; o = 3;
bdd = updateBelief(pomdp,bd,a,o)
expRewWW = 0.05*max(bd) + 0.05*max(bdd);
pause