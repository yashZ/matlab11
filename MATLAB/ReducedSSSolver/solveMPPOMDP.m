function solveMPPOMDP()

nppl = 5;
ngrids = 10;

%posState = getEncodedStates(ngrids,nppl)
oneManProb = generateProblemMP(ngrids,1);

global problem
problem = oneManProb;

b = zeros(nppl,ngrids);
s = sampleBeliefs(1000);



for i = 1:nppl
    
    j = floor(1000*rand(1)) + 1;
    s1 = s(j,:);
    b(i,:) = s1;
    
end

end


function states = getEncodedStates(ngrids,nppl)

    states = npermutek([1:ngrids],nppl);

end

function aBelief = aggregateBelief()

    s{1} = sampleBeliefs


end

function p = mergeBeliefs(ngrids,nppl,encodedStates)

    % b1 - is 1 x ngrids
    % b2 - is 1 x ngrids
    % b is nppl x ngrids
    % encodedStates is nStates x nppl
    
    %encodedStates = getEncodedStates(ngrids,nppl);
    nstates = size(encodedStates,1);
    p = ones(nstates,1);         
            
    ppl = 0;
    for i = 1:nstates
        stt = encodedStates(i,:);
        for j = 1:length(stt)
            psnBelief = b(j,:);
            ind = stt(j);
            p(i) = psnBelief(ind)*p(i);
        end 
    end
end