% load IncSH10S10.mat
% 
% rewN = zeros(1,length(10));
% rewL = zeros(1,length(10));
% rewRo = zeros(1,length(10));
% rewRa = zeros(1,length(10));
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
% 
% % 
% % load IncSH10S10VSkewedObs.mat
% % 
% % rewN = zeros(1,length(10));
% % rewL = zeros(1,length(10));
% % rewRo = zeros(1,length(10));
% % rewRa = zeros(1,length(10));
% % 
% % for i = 1:10
% %     rewN(i) = rewNorm30{i};
% %     rewL(i) = rewLO30{i};
% %     rewRo(i) = rewRotate30{i};
% %     rewRa(i) = rewRandom30{i};
% % end
% % 
% % rewN(1) = 15000;
% % rewL(1) = 15000;
% % rewRa(1) = 15000;
% % rewRo(1) = 15000;
% % 
% % rewN = rewN/15000;
% % rewL = rewL/15000;
% % rewRo = rewRo/15000;
% % rewRa = rewRa/15000;
% % 
% % plot(rewN,'b*-')
% % hold on
% % plot(rewL,'r*-')
% % hold on
% % %plot(rewRo,'g*-')
% % %hold on
% % %plot(rewRa,'c*-')
% % clear all
% 
% 
% load IncSH10S10VSkewedObs2Bad.mat
% 
% rewN = zeros(1,length(10));
% rewL = zeros(1,length(10));
% rewRo = zeros(1,length(10));
% rewRa = zeros(1,length(10));
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
% plot(rewN,'b*-')
% hold on
% plot(rewL,'r*-')
% hold on
% 
% clear all
% 

% load CumsumH102Bad.mat
% i = 100;
% rewN = rewNorm30H{i};
% rewL = rewLO30H{i};
% rewRo = rewRotate30H{i};
% rewRa = rewRandom30H{i};
% 
% mN = mean(cumsum(rewN,2));
% mL = mean(cumsum(rewL,2));
% mRo = mean(cumsum(rewRo,2));
% mRa = mean(cumsum(rewRa,2));
% 
% sN = std(cumsum(rewN,2));
% sL = std(cumsum(rewL,2));
% sRo = std(cumsum(rewRo,2));
% sRa = std(cumsum(rewRa,2));
% 
% %errorbar(mN,sN);
% %hold on
% %errorbar(mL,sL,'r');
% %errorbar(mRo,sRo,'g');
% %errorbar(mRa,sRa,'c');
% 
% 
% plot(mN,'bo-')
% hold on 
% plot(mL,'ro-')
% %plot(mRo,'go-')
% %plot(mRa,'co-')
% 
% 
load CumsumH2NoBad.mat
i = 100;
rewN = rewNorm30H{i};
rewL = rewLO30H{i};
rewRo = rewRotate30H{i};
rewRa = rewRandom30H{i};

mN = mean(cumsum(rewN,2));
mL = mean(cumsum(rewL,2));
mRo = mean(cumsum(rewRo,2));
mRa = mean(cumsum(rewRa,2));

sN = std(cumsum(rewN,2));
sL = std(cumsum(rewL,2));
sRo = std(cumsum(rewRo,2));
sRa = std(cumsum(rewRa,2));

%errorbar(mN,sN);
%hold on
%errorbar(mL,sL,'r');
%errorbar(mRo,sRo,'g');
%errorbar(mRa,sRa,'c');


plot(mN,'b--')
hold on 
plot(mL,'r--')
%plot(mRo,'mo-')
%plot(mRa,'ko-')


load CumsumH10NoBad.mat
i = 100;
rewN = rewNorm30H{i};
rewL = rewLO30H{i};
rewRo = rewRotate30H{i};
rewRa = rewRandom30H{i};

mN = mean(cumsum(rewN,2));
mL = mean(cumsum(rewL,2));
mRo = mean(cumsum(rewRo,2));
mRa = mean(cumsum(rewRa,2));

sN = std(cumsum(rewN,2));
sL = std(cumsum(rewL,2));
sRo = std(cumsum(rewRo,2));
sRa = std(cumsum(rewRa,2));

%errorbar(mN,sN);
%hold on
%errorbar(mL,sL,'r');
%errorbar(mRo,sRo,'g');
%errorbar(mRa,sRa,'c');


plot(mN,'b')
hold on 
plot(mL,'r')
%plot(mRo,'mo-')
%plot(mRa,'ko-')

