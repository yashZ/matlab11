function T = getmyTrans(nrstates,nractions)

% O(s,a,o)

% actions -                                                                 
% a1 - pred1 + obs1
% a2 - pred2 + obs1
% a3 - pred3 + obs1
% a4 - pred4 + obs1
% a5 - pred1 + obs2
% a6 - pred2 + obs2
% a7 - pred3 + obs2
% a8 - pred4 + obs2
% a9 - pred1 + obs3
% a10 - pred2 + obs3
% a11 - pred3 + obs3
% a12 - pred4 + obs3
% a13 - pred1 + obs4
% a14 - pred2 + obs4
% a15 - pred3 + obs4
% a16 - pred4 + obs4


T = zeros(nrstates,nrstates,nractions);

for s=1:nrstates
    for sd=1:nrstates
        for a=1:nractions
            if s==sd
                T(s,sd,a) = 0.7;
            else
                T(s,sd,a) = 0.1;
            end
        end
    end
end

end