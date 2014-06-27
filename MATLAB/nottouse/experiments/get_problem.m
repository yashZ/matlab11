function trackppl = get_problem(nrst)

trackppl.gamma=1;
trackppl.nrStates = nrst;
trackppl.nrActions = nrst^2;
trackppl.nrObservations=nrst;
trackppl.start = (1/nrst)*ones(1,nrst);
trackppl.observation = getmyObs(trackppl.nrStates,trackppl.nrActions,trackppl.nrObservations);
trackppl.transition = getmyTrans(trackppl.nrStates,trackppl.nrActions);
trackppl.reward = getmyReward(trackppl.nrStates,trackppl.nrActions);


end