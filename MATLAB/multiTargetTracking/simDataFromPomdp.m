function [rt,ot] = simDataFromPomdp(pomdp,tStep)
    
    rt = zeros(1,tStep);
    initS = sampleDist(pomdp.start',1);
    s = initS;
    a = 1;
    for i = 1:tStep
            a;
            rt(i) = s;
            dist = pomdp.transition(:,s,a);
            sd = sampleDist(dist,1);
            s = sd;
    end
    obsTrack = getObsTrack(pomdp,rt,tStep);
    ot = obsTrack;
end

function obsTrack = getObsTrack(pomdp,realTrack,tStep)

    obs = pomdp.observation;
    nraction = pomdp.nrActions;
    for i = 1:nraction
        for t = 1:tStep
            st = realTrack(t);
            distO = obs(st,i,:);
            obs1 = sampleDist(distO,1);
%             if obs1 < 5
%                 obs1 = 1;
%             else
%                 obs1 = 2;
%             end
            obsTrack(i,t) = obs1;
        end
    end

end