function [newbestaction] = getActValueIR(VFFac,pomdp,b,nC,h,VF1)

    alphasFac = VFFac.Vtable{1}.alphaList;
    actionsFac = VFFac.Vtable{1}.alphaAction;
    
    ap = getBestPredAct(VF1,b);
    bestactions = [];
    for i =1:(pomdp.nCell)
        
        temptup = [i,ap];
        bestactions = [bestactions;temptup];
        %[alt,alv] = ismember(temptup,actionsFac,'rows');
        alvs = find(sum(abs(actionsFac - ones(length(actionsFac),1)*temptup),2)==0);
        tempQ = [];
        if (length(alvs) > 0)
            for alv = 1:length(alvs)
                tempQ = [tempQ,b*alphasFac(:,alvs(alv))];
                Q(i) = max(tempQ);
            end
        else
            continue;
        end
    end
    acts = [];
    for kk = 1:nC
        [v,ind1] = max(Q);
        tempbact = bestactions(ind1,:);
        camtosel = tempbact(1);
        Q;
        Q(find(Q==max(Q)))=0;
        acts = [camtosel,acts];
    end
    
    %pause
    acts = [acts,ap];
    newbestaction = acts;
    %[tt,vv] = ismember(newbestaction,actionsFac,'rows');
    %vals = b*alphasFac(:,vv);
%     newbestaction1 = newbestaction;
%     [v,i] = max(b*alphasFac,[],2);
%     newbestaction = actionsFac(i,:);
%     if (newbestaction1==newbestaction)
%         'd';
%     elseif vals == v
%         'd';
%     else
%         b
%         newbestaction
%         ismember(newbestaction,actionsFac,'rows')
%         [m,n] = ismember(newbestaction,bestactions,'rows')
%         %if (~isempty(n) && n > 0) 
%         %    Q(n)
%         %end
%         %Q
%         newbestaction1
%         vals
%         v
%         pause
%     end
    
    
    
end


function ap = getBestPredAct(VF1,b)

    alphas = VF1.Vtable{1}.alphaList;
    actions = VF1.Vtable{1}.alphaAction;
    [v,i] = max(b*alphas,[],2);
    ap2 = actions(i,:);
    ap = ap2(2);
    
end