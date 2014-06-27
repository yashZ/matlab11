clc
clear all

for h = 2:8:10
pomdp = generateProblemCamP();

tempPomdp = pomdp;
tempT = pomdp.transition;
for i = 1:size(tempT,3)
    g = tempT(:,:,i);
    tempT(:,:,i) = g';
end

tempPomdp.transition = tempT;

VFCI = solvePOMDPCamInd(pomdp,h);
tStep = 500;
%sVFCI = solvePOMDPCamInd(pomdp,sh);

for i = 1:10
    [realTrack,obsTrack] = simulateDataCam(tempPomdp,tStep);
    rew1(i,:) = simCamInd(realTrack,obsTrack,pomdp,VFCI,h,'CamInd');%,sVFCI,sh);
    %rew2(i,:) = simCamInd(realTrack,obsTrack,pomdp,VFCI,h,'Random');
end
stt(h).rew1 = rew1;
%stt(h).rew2 = rew2;
end