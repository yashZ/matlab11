clc
clear all;
load testIncS.mat

for i = 100
    
    rewI = rewLO30H{i};
    rewN = rewNorm30H{i};
    %rewRo = rewRotate30H{i};
    %rewRa = rewRandom30H{i};
    
    mI = mean(rewI,1);
    sI = std(rewI,1);
    
    mN = mean(rewN,1)
    sN = std(rewN,1)

    %mRo = mean(rewRo,1)
    %sRo = std(rewRo,1)
    
    %mRa = mean(rewRa,1)
    %sRa = std(rewRa,1)
    figure;
    errorbar(mN,sN,'bo-');
    hold on
    errorbar(mI,sI,'ro-');
    %errorbar(mRo,sRo,'go-');
    %errorbar(mRa,sRa,'co-');
    
    %pause
end
    