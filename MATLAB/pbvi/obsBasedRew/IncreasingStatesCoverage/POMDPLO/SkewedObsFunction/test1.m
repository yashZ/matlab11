%clc
clear all;
load testIncS1Bad.mat
rew1 = rewLO30H{100};
clear rewLO30H

load testIncS2Bad.mat
rew2 = rewLO30H{100};
clear rewLO30H

load testIncS4Bad.mat
rew4 = rewLO30H{100};
clear rewLO30H

load testIncS5Bad.mat
rew5 = rewLO30H{100};
clear rewLO30H

load testIncS.mat
rewN = rewLO30H{100};
clear rewLO30H

load testIncS7Bad.mat
rew7 = rewLO30H{100};
clear rewLO30H

load testIncS9Bad.mat
rew9 = rewLO30H{100};
clear rewLO30H


for i = 100
    
    %rewI = rewLO30H{i};
    %rewN = rewNorm30H{i};
    %rewRo = rewRotate30H{i};
    %rewRa = rewRandom30H{i};
    
    m1 = mean(rew1,1);
    s1 = std(rew1,1);
    
    m2 = mean(rew2,1);
    s2 = std(rew2,1);
    
    mN = mean(rewN,1);
    sN = std(rewN,1);
    
    m4 = mean(rew4,1);
    s4 = std(rew4,1);
    
    m5 = mean(rew5,1);
    s5 = std(rew5,1);
    
    m7 = mean(rew7,1);
    s7 = std(rew7,1);
   
    m9 = mean(rew9,1);
    s9 = std(rew9,1);
   
    
    %mN = mean(rewN,1)
    %sN = std(rewN,1)

    %mRo = mean(rewRo,1)
    %sRo = std(rewRo,1)
    
    %mRa = mean(rewRa,1)
    %sRa = std(rewRa,1)
    figure;
    %errorbar(mN,sN,'bo-');
    hold on
    errorbar(m1,s1,'ro-');
    hold on
    errorbar(m2,s2,'bo-');
    hold on 
    errorbar(mN,sN,'co-');
    hold on
    errorbar(m4,s4,'ko-');
    hold on
    errorbar(m5,s5,'yo-');
    hold on
    errorbar(m7,s7,'go-');
    hold on
    errorbar(m9,s9,'mo-');
    mean(m1)
    mean(m2)
    mean(mN)
    mean(m4)
    mean(m5)
    mean(m7)
    mean(m9)
    %errorbar(mRo,sRo,'go-');
    %errorbar(mRa,sRa,'co-');
    
    %pause
end
    