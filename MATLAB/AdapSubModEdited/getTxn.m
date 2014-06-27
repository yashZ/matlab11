function [] = getTxn(txnmat)
    
    p = generateProblemCamP();
    states = p.encodedStates;
    for i = 1:size(states,1)
        for j = 1:size(states,1)
            ps = states(i,:);
            ns = states(j,:);
            for k = 1:length(ps)
                
            end
    end


end

