clc
clear all

load testIncSH2.mat;
twoReward = rewNorm30H{100};
clear rewNorm30H;

load testIncSH5.mat;
fiveReward = rewNorm30H{100};
clear rewNorm30H;

load testIncSH10.mat;
tenReward = rewNorm30H{100};
clear rewNorm30H;

load testIncSH30.mat;
thirtyReward = rewNorm30H{100};
clear rewNorm30H;

m2 = mean(twoReward,1)
s2 = std(twoReward,1)

m5 = mean(fiveReward,1);
s5 = std(fiveReward,1);

m10 = mean(tenReward,1);
s10 = std(tenReward,1);

m30 = mean(thirtyReward,1);
s30 = std(thirtyReward,1);

figure;
errorbar(m2,s2,'bo-');
hold on;
errorbar(m5,s5,'ro-');
hold on;
errorbar(m10,s10,'go-');
hold on
errorbar(m30,s30,'co-');
            
sum(m2)
sum(m5)
sum(m10)
sum(m30)

