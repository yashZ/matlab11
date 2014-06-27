global problem
Q = reshape(problem.reward,[1 problem.nrStates problem.nrActions]);
Q = repmat(Q,[100 1 1]);

S = mySampleBeliefs(100);

for ac=1:problem.nrActions
    expectRew(:,ac) = sum(Q(:,:,ac).*S, 2);
end
% for each sampled belief point get max reward and best action
[maxRew,action] = max(expectRew')

for a = 1:problem.nrActions % select the best actions
        mask(:,:,a) = repmat( transpose(action == a), 1, problem.nrStates );
end
v = squeeze(sum( Q.*mask,3));
a = action'
clear mask;
[ alphaList ind1 ind2 ] = unique( v, 'rows' );


% vals = S*alphaList';
% [val,maxInd] = max(vals,[],2);
% a = ind1(maxInd);
% 
% alphaCount = size(alphaList,2);
% gammaAO = cell(problem.nrActions,1);
% for action = 1:problem.nrActions
%     for obs = 1:problem.nrObservations
%         gammaAO{action}{obs} = 0.2*alphaList;
%     end
% end