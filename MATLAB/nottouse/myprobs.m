global myproblem;

myproblem.gamma = 0.2;
myproblem.nrStates = 5;
myproblem.nrActions = 16;
myproblem.nrObservations = 5;
myproblem.start = [0.2 0.2 0.2 0.2 0.2];
myproblem.observation = getmyObs();
myproblem.transition = getmyTxn();
myproblem.reward = getmyReward();
