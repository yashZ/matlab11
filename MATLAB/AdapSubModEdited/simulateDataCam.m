function [rTrack,obsTrack] = simulateDataCam(pomdp,tStep)

    initS = sampleDist(pomdp.start',1);
    s = initS;
    for i = 1:tStep
        
        rTrack(i,:) = s;
        dist = pomdp.transition(s,:,1)';
        sd = sampleDist(dist,1);
        s = sd;
    end
    obsTrack = getObsTrack(pomdp,rTrack);
    %obsTrack = rTrack;
    
end

function obsTrack = getObsTrack(pomdp,realTrack)

    obs = pomdp.observation;
    nraction = pomdp.nrActions;
    for i = 1:nraction
        for t = 1:length(realTrack)
            st = realTrack(t);
            distO = obs(st,i,:);
            obsTrack(i,t) = sampleDist(distO,1);
        end
    end
end