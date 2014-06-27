function [rew,aVec] = runFBSims(pomdp,realTrack,obsTrack,VF,h)

    start = pomdp.start;
    %belief = zeros(1,40);
    %belief(1:4) = 0.25;
    %belief = belief';
    belief = pomdp.start';
    for t=1:length(realTrack)
        ttogo = length(realTrack) - t +1;
        if ttogo > h
            ttogo = h;
        else
            ttogo = ttogo;
        end
        ttogo
        posOfPpl = realTrack(t);
        
        s = posOfPpl;
        a = getBestActionNorm(belief,ttogo,VF,pomdp);
        
        aVec(t) = a;
        encA = pomdp.encodedAction(a,:);
        aN = encA(1);
        aR = encA(2);
        if aN < 5
            obsPosOfPpl = obsTrack((4*aN),t)
            o = getObs(pomdp,aN,posOfPpl,obsPosOfPpl,belief);
        else
            o = 2;
        end

        o
        if rem(aR,4)==0
            ps = 4;
        else
            ps = rem(aR,4);
        end

        aR
        if ps==s
            rew(t) = 1;
        else 
            rew(t) = 0;
        end
        rew(t) ;
        
        newBelief = updateBelief(pomdp,belief,a,o);
        belief = newBelief;
        %pause
    end
    
end

function fo = getObs(pomdp,a,posOfPpl,obsTrack,belief);

    
    if (posOfPpl==a) && (obsTrack==posOfPpl)
        fo = 1;
    elseif (posOfPpl~=a) && (obsTrack==a)
        fo = 1;
    else
        fo = 2;
    end

%     a
%     ii = find(belief>0);
%     for i = 1:length(ii);
%         temp = pomdp.encodedStates(ii(i),:);
%         tempt(i,:) = temp(1);
%     end
%     budg = unique(tempt);
%     length(budg);
%     if length(budg) > 1
%         belief
%         disp('wrong belief');
%         pause;
%     else
%         if (a==posOfPpl)
%             %budg = budg + 1;
%             %budg = min(budg,10);
%             tfo = [budg,1]
%         elseif (a < (pomdp.nrGrids+1))
%             %budg = budg + 1;
%             %budg = min(budg,10);
%             tfo = [budg,2]
%         else
%             tfo = [budg,3];
%         end
%     end
%     belief;
%     a;
%     fo = find(ismember(pomdp.encodedObs,tfo,'rows'));
        
end


function a = getBestActionNorm(belief,h,VF,pomdp)
    h;
    alphas = VF{h}.Vtable{1}.alphaList;
    alphaAction = VF{h}.Vtable{1}.alphaAction;
    [v,i] = max(belief'*alphas,[],2);
    a = alphaAction(i);

end

function a = getBestActionRand(pomdp)
    
    a = floor(rand(1)*pomdp.nrActions) + 1;
    
end