
nPpl = 2;
nGrid = 5;
h = 10;
%pomdp = generateProblemMP(nGrid,1);
%VF = solvePOMDPMP(pomdp,h);

pomdpLO = generateProblemMPLODiffRew(nGrid,1);
VFLO = solvePOMDPMPLO(pomdpLO,h);

pomdpDiff = generateProblemMPDiffRew(nGrid,1);
VFDiff = solvePOMDPMP(pomdpDiff,h);

%for tt = 1:500

%    rewRedSS(tt,:) = runSimsIndpP(pomdp,nGrid,nPpl,h,VF,'d');

%end

for pp = 1:500
    
    rewLODiff(pp,:) = runSimsIndpP(pomdpLO,nGrid,nPpl,h,VFLO,'d');
    
end

for gg = 1:500
    
    rewDiff(gg,:) = runSimsIndpP(pomdpDiff,nGrid,nPpl,h,VFDiff,'Diff');
    
end