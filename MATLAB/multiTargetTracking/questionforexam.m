% question for exam

belief = [0.25,0.25,0.25,0.25];
pomdpI = generateProblemMP(4,1);
pomdpC = generateProblemMPLO(4,1);
VFI = solvePOMDPMP(pomdpI,4); alphasI = VFI{4}.Vtable{1}.alphaList; alphaActionI = VFI{4}.Vtable{1}.alphaAction;
VFC = solvePOMDPMPLO(pomdpC,4);alphasC = VFC{4}.Vtable{1}.alphaList;alphaActionC = VFC{4}.Vtable{1}.alphaAction; 

[v,i] = max(belief*alphasI,[],2); aI = alphaActionI(i)
[v,i] = max(belief*alphasC,[],2); aC = alphaActionC(i)

pause
beliefI = updateBelief(pomdpI,belief',aI,4)
beliefC = updateBelief(pomdpC,belief',aC,4)

[v,i] = max(beliefI'*alphasI,[],2); aI = alphaActionI(i)
[v,i] = max(beliefC'*alphasC,[],2); aC = alphaActionC(i)

pause
beliefI = updateBelief(pomdpI,beliefI,aI,5)
beliefC = updateBelief(pomdpC,beliefC,aC,5)


[v,i] = max(beliefI'*alphasI,[],2); aI = alphaActionI(i)
[v,i] = max(beliefC'*alphasC,[],2); aC = alphaActionC(i)
pause

beliefI = updateBelief(pomdpI,belief',aI,1)
beliefC = updateBelief(pomdpC,belief',aC,1)


% a = 1;
% o = 1;
% belief = updateBelief(pomdp,belief',a,o);
% 
% a = 1;
% o = 1;
% 
% belief = updateBelief(pomdp,belief,a,o);
% 
% a = 1;
% o = 5;
% 
% belief = updateBelief(pomdp,belief,a,o)
% 
