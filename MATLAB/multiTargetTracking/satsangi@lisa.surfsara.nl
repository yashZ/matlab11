function [tIR, tN, tLO] = plotTimeGraphs()

   h = 20;
   for nGrid = 3:20
       nGrid
       
       e1 = cputime;
       pomdpIR = generateProblemIR(nGrid,1);
       solvePOMDPMPIR(pomdpIR,h);
       e2 = cputime - e1;
       
       e3 = cputime;
       pomdpN = generateProblemMP(nGrid,1);
       solvePOMDPMP(pomdpN,h);
       e4 = cputime - e3;
       
       e5 = cputime;
       pomdpLO = generateProblemMPLO(nGrid,1);
       solvePOMDPMPLO(pomdpLO,h)
       e6 = cputime - e5;
       
       tIR(nGrid) = e2;
       tN(nGrid) = e4;
       tLO(nGrid) = e6;
       
   end

end