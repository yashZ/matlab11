p = generateProblemFixBudg;
b = p.start;
action = 1;
nrstates = p.nrStates;
for i=1:40
    temp = 0;
    for j=1:40
        temp = temp + p.transition(j,i)*b(j);
    end
    ub(i) = temp;
end
    

