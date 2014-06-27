clc
clear all

for h = 2:3:5
%pomdp = generateProblemCamP();
nC = 2;
pomdp = generateProblemCamP(nC);
pomdp1 = generateProblemCamP(1);
pomdpir = generateProblemCamPIR(nC);
pomdpir1 = generateProblemCamPIR(1);
tempPomdp = pomdp;
% tempT = pomdp.transition;
% for i = 1:size(tempT,3)
%     g = tempT(:,:,i);
%     tempT(:,:,i) = g';
% end
% 
% tempPomdp.transition = tempT;

VFCI = solvePOMDPCamInd(pomdp,h);
VF1 = solvePOMDPCamInd(pomdp1,h);
%VF2 = solvePOMDPCamInd(pomdp1,5);
VFIR = solvePOMDPCamIndIR(pomdpir,h);
VFIR1 = solvePOMDPCamIndIR(pomdpir1,h);
VFIR1h = solvePOMDPCamIndIR(pomdpir1,1);
%VFIR = VFIR1;
tStep = 100;
%sVFCI = solvePOMDPCamInd(pomdp,sh);


for i = 1:300
    i
    [realTrack,obsTrack] = simulateDataCam(tempPomdp,tStep);
    [realTrackir,obsTrackir] = simulateDataCamIR(pomdpir,tStep);
    %rew1(i,:) = simCamInd(realTrack,obsTrack,pomdp,VFCI,h,'CamInd',VF1,pomdp1);%,sVFCI,sh);
    rew1(i,:) = simCamInd(realTrack,obsTrack,pomdp,VFCI,h,'CamInd',VF1,pomdp1,nC);%,sVFCI,sh);
    rewirOpt(i,:) = simCamIndIR(realTrackir,obsTrackir,pomdpir,VFIR,h,'optimal',VFIR1,pomdpir1,nC);
    %rewirFac(i,:) = simCamIndIR(realTrackir,obsTrackir,pomdpir,VFIR1h,h,'factorized',VFIR1,pomdpir1,nC);
    
    %rewirRand(i,:) = simCamIndIR(realTrackir,obsTrackir,pomdpir,VFIR,h,'random',VFIR1,pomdpir1,nC);
    %rew2(i,:) = simCamInd(realTrack,obsTrack,pomdp,VFCI,h,'Random');
    %sum(rewirOpt(i,:));
    %sum(rewirFac(i,:));
    %pause
end
stt(h).rew1 = rew1;
stt(h).rewirOpt = rewirOpt;
%stt(h).rewirFac = rewirFac;
%stt(h).rewirRand = rewirRand;
%stt(h).rew2 = rew2;
end