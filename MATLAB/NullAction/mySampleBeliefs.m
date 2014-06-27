function S = mySampleBeliefs(n)

% n = number of belief points
% S = (n x d) sampled beliefs

global problem;
S = problem.start;
diffeps = 0.01;

while size(S,1) <= n 
    
    newSet = addPBVIFar(S);
    
    newSet = epSetDiff(newSet,S,diffeps); % find unique bs only
    totalCount = size(S,1) + size(newSet,1);
    if totalCount > n 
        % to get n belief points
        newCount = n - size(S,1);
        ind = randperm(size(newSet,1));
        ind = ind(1:newCount);
        newSet = newSet(ind,:);
        S = [S;newSet];
        break;
    else
        S = [S;newSet];
    end
   
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function db1 = addPBVIFar(S)
    global problem;
    for i = 1:problem.nrActionsN
        propSet(:,:,i) = problem.transition(:,:,i)*S'; % this are next start probs
        
        for j=1:size(S,1)
            propSet(:,j,i) = sampleObsAndUpdate(propSet(:,j,i),i);
        end
        
        %distance to new belief
        propDist(:,i) = sum( (propSet(:,:,i) - S').^2);
    end
    [maxVal, maxInd] = max(propDist');
    for i=1:size(S,1)
        db1(i,:) = transpose(propSet(:,i,maxInd(i)));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bel = sampleObsAndUpdate( prevBel, action )
    global problem;
    
    
    obs = sampleObs( prevBel, action );
    %obs = floor(length(prevBel)*rand(1)) + 1;
    bel = prevBel .* problem.observation(:,action,obs);
    bel = bel/sum(bel);
end   
% samples observation given a belief state and action
% bel is a COLUMN vector
function obs = sampleObs( bel, action )
    global problem;
    pdf = transpose( squeeze( problem.observation(:,action,:))) * bel;
    obs = sampleDist( pdf, 1);
end

function c = epSetDiff(A,B,ep);

     A = unique(A,'rows');
    [c,ndx] = sortrows([A;B]);
    [rowsC,colsC] = size(c);
    if rowsC > 1 && colsC ~= 0
      % d indicates the location of non-matching entries
      % d = c(1:rowsC-1,:) ~= c(2:rowsC,:);
      d = sum(  abs(  c(1:rowsC-1,:) - c(2:rowsC,:)  ), 2  ) > ep;
    else
      d = zeros(rowsC-1,0);
    end
    % d = any(d,2);
    d(rowsC,1) = 1;   % Final entry always included.
    
    % d = 1 now for any unmatched entry of A or of B.
    n = size(A,1);
    d = d & ndx <= n; % Now find only the ones in A.
    
    c = c(d,:);
end

