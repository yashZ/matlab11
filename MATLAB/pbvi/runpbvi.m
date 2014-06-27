optCount = 5;
rAsk = -2; rConfWrong = -10; rDoWrong = -100;
oAsk = .7; oConf = .9;
tSkew = 1; oSkew = cell( 1,optCount+2 );
extraObs = [];
global problem; problem = initDialogSkewed( optCount, rAsk, rConfWrong, rDoWrong, oAsk, oConf, oSkew, tSkew, extraObs );