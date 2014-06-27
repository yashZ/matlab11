load IncSH2S10.mat


rewN = zeros(1,10);
rewL = zeros(1,10);
rewRo = zeros(1,10);
rewRa = zeros(1,10);

for i = 1:10
    rewN(i) = rewNorm30{i};
    rewL(i) = rewLO30{i};
    rewRo(i) = rewRotate30{i};
    rewRa(i) = rewRandom30{i};
end

rewN(1) = 15000;
rewL(1) = 15000;
rewRa(1) = 15000;
rewRo(1) = 15000;
rewN = rewN/15000;
rewL = rewL/15000;
rewRo = rewRo/15000;
rewRa = rewRa/15000;

figure
plot(rewN,'bo-')
hold on
plot(rewL,'ro-')
hold on
plot(rewRo,'go-')
hold on
plot(rewRa,'co-')


% clear all
% 
% load IncSH10S10.mat
% 
% rewN = zeros(1,10);
% rewL = zeros(1,10);
% rewRo = zeros(1,10);
% rewRa = zeros(1,10);
% 
% for i = 1:10
%     rewN(i) = rewNorm30{i};
%     rewL(i) = rewLO30{i};
%     rewRo(i) = rewRotate30{i};
%     rewRa(i) = rewRandom30{i};
% end
% 
% rewN(1) = 15000;
% rewL(1) = 15000;
% rewRa(1) = 15000;
% rewRo(1) = 15000;
% 
% rewN = rewN/15000;
% rewL = rewL/15000;
% rewRo = rewRo/15000;
% rewRa = rewRa/15000;
% 
% plot(rewN,'bo-')
% hold on
% plot(rewL,'ro-')
% hold on
% plot(rewRo,'go-')
% hold on
% plot(rewRa,'co-')
% clear all


% load IncSH30S10.mat
% 
% rewN = zeros(1,length(rewNorm30));
% rewL = zeros(1,length(rewNorm30));
% rewRo = zeros(1,length(rewNorm30));
% rewRa = zeros(1,length(rewNorm30));
% 
% for i = 1:10
%     rewN(i) = rewNorm30{i};
%     rewL(i) = rewLO30{i};
%     rewRo(i) = rewRotate30{i};
%     rewRa(i) = rewRandom30{i};
% end
% 
% rewN(1) = 15000;
% rewL(1) = 15000;
% rewRa(1) = 15000;
% rewRo(1) = 15000;
% 
% rewN = rewN/15000;
% rewL = rewL/15000;
% rewRo = rewRo/15000;
% rewRa = rewRa/15000;
% 
% plot(rewN,'bo-')
% hold on
% plot(rewL,'ro-')
% hold on
% plot(rewRo,'go-')
% hold on
% plot(rewRa,'co-')
% clear all
