clc
clear all

a1 = 0.9;
b1 = 0.1;

%nl camera
a2 = 0.7;
b2 = 0.3;

eBel1 = 0.7;
eBel2 = 0.3;

earlierB = [eBel1, eBel2];

nLB1 = [(eBel1)*(b2)/((eBel1)*(b2) + (eBel2)*(a2)) , ((eBel2)*(a2)/((eBel1)*(b2) + (eBel2)*(a2)))] 

nLB2 = [(eBel1)*(1-b2)/((eBel1)*(1-b2) + (eBel2)*(1-a2)) , ((eBel2)*(1-a2)/((eBel1)*(1-b2) + (eBel2)*(1-a2)))] 

LB3 = [(eBel1)*(a1)/((eBel1)*(a1) + (eBel2)*(b1)) , ((eBel2)*(b1)/((eBel1)*(a1) + (eBel2)*(b1)))] 

LB4 = [(eBel1)*(1-a1)/((eBel1)*(1 - a1) + (eBel2)*(1 - b1)) , ((eBel2)*(1-b1)/((eBel1)*(1-a1) + (eBel2)*(1-b1)))] 


rnl1 = max(nLB1)
rnl2 = max(nLB2)
rl3 = max(LB3)
rl4 = max(LB4)

pnLB1 = eBel1*b2 + eBel2*a2
pnLB2 = eBel1*(1-b2) + eBel2*(1-a2)

pLB3 = eBel1*a1 + eBel2*b1
pLB4 = eBel1*(1-a1) + eBel2*(1-b1)

(pnLB1)*rnl1 + (pnLB2)*rnl2
(pLB3)*rl3 + (pLB4)*rl4