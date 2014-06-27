function trackppl = ppltrack
%global trackppl;

trackppl.gamma=0.9;
trackppl.nrStates = 4;
trackppl.nrActions = 16;
trackppl.nrObservations=4;
trackppl.start = [0.25 0.25 0.25 0.25];
trackppl.observation = getmyObs();
trackppl.transition = getmyTrans();
trackppl.reward = getmyReward();

end