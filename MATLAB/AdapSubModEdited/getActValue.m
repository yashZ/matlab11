function [newbestaction] = getActValue(VF1,VF2,pomdp,b,nC)

    alphas1 = VF1{1}.Vtable{1}.alphaList;
    alphas2 = VF2{2}.Vtable{1}.alphaList;
    actions1 = VF1{1}.Vtable{1}.alphaAction;
    actions2 = VF2{2}.Vtable{1}.alphaAction;
    nrstates = pomdp.nrStates;
    nraction = pomdp.nrActions;
    alphas1;
    [v,i] = max(b*alphas1,[],2);
    bestact1 = actions1(i,:);
    encact = pomdp.encodedAction(bestact1,:);
    bestpossactions = [bestact1:nrstates:nraction];
    for j = 1:length(bestpossactions)
        possact = bestpossactions(j);
        possi = find(actions2==possact);
        if(isempty(possi))
            Q(j) = 0;
            continue;
        end
        %Q(j) = 
        possi;
        b*alphas2;
        [Q(j),ii] = max(b*alphas2(:,possi),[],2);
        I(j) = actions2(possi(ii),:);
    end
    acts = [];
    for kk = 1:nC
        [v,ind1(kk)]=max(Q);
        Q(Q==max(Q)) = 0;
        acts = [acts,I(ind1(kk))];
    end
    newbestaction = [];
    for ii = 1:length(acts)
        enccam = pomdp.encodedAction(acts(ii),:);
        cam(ii) = enccam(1);
        newbestaction = [newbestaction,cam(ii)];
    end
    newbestaction = [newbestaction,encact(2:length(encact))];
end