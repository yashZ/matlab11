function bool = episodeEnded(r,s1)
% $Id: episodeEnded.m,v 1.1 2003/08/25 09:11:32 mtjspaan Exp $

global problem;
if r == problem.maxReward 
    bool=1;
else
    bool=0;
end
