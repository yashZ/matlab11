% %clc
clear all;

load testIncSH2.mat
rew1 = rewNorm30H{100};
clear rewNorm30H;

m = mean(rew1,1);
s = std(rew1,1);

figure
errorbar(m,s,'b');
mean(m)
% load testIncS1BadN.mat
% rew1 = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncS2BadN.mat
% rew2 = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncS5BadN.mat
% rew5 = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncSN.mat
% rewN = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncS7BadN.mat
% rew7 = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncS9BadN.mat
% rew9 = rewNorm30H{100};
% clear rewNorm30H
% 
% load testIncSChangeReward.mat
% rewC = rewNorm30H{100};
% clear rewNorm30H
% 
% for i = 100
%     
%     %rewI = rewLO30H{i};
%     %rewN = rewNorm30H{i};
%     %rewRo = rewRotate30H{i};
%     %rewRa = rewRandom30H{i};
%     
%     m1 = mean(rew1,1);
%     s1 = std(rew1,1);
%     
%     m2 = mean(rew2,1);
%     s2 = std(rew2,1);
%     
%     mN = mean(rewN,1);
%     sN = std(rewN,1);
%     
%     m5 = mean(rew5,1);
%     s5 = std(rew5,1);
%     
%     m7 = mean(rew7,1);
%     s7 = std(rew7,1);
%    
%     m9 = mean(rew9,1);
%     s9 = std(rew9,1);
%    
%     mC = mean(rewC,1);
%     sC = std(rewC,1);
%     
%     %mN = mean(rewN,1)
%     %sN = std(rewN,1)
% 
%     %mRo = mean(rewRo,1)
%     %sRo = std(rewRo,1)
%     
%     %mRa = mean(rewRa,1)
%     %sRa = std(rewRa,1)
%     figure;
%     %errorbar(mN,sN,'bo-');
%     hold on
%     errorbar(m1,s1,'ro-');
%     hold on
%     errorbar(m2,s2,'bo-');
%     hold on 
%     errorbar(mN,sN,'co-');
%     hold on
%     errorbar(m5,s5,'yo-');
%     hold on
%     errorbar(m7,s7,'go-');
%     hold on
%     errorbar(m9,s9,'mo-');
%     hold on
%     errorbar(mC,sC,'ko-');
%     
%     mean(m1)
%     mean(m2)
%     mean(mN)
%     mean(m5)
%     mean(m7)
%     mean(m9)
%     mean(mC)
%     %errorbar(mRo,sRo,'go-');
%     %errorbar(mRa,sRa,'co-');
%     
%     %pause
% end
%    
