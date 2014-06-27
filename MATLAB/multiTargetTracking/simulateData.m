function Track1 = simulateData(t,nrStates)

%numbrPpl = 5;

oldP = 0;
oldStates = [];

D = cell(1);

for i=1:t

    newP = createNewP(oldP);
    newStates = getNewStates(newP, oldStates,nrStates);
    oldP = newP;
    oldStates = newStates;
    D{i}= newStates;
    Track1 = getOneTrack(D);
end


end

function Track1 = getOneTrack(D)

    for t = 1:length(D)
        
      temp = D{t};
      Track1(t) = temp(1);
      
    end

end


function numP = createNewP(oldP)
    prand = rand(1);
    if oldP <= 0
        numP = oldP + 1;
    elseif oldP <= 5
        if prand > 0.7
            numP = oldP + 1;
        else
            numP = oldP;
        end
    else
        if prand < 0.9
            numP = oldP;
        else
            numP = oldP + 1;
        end
    end
end

function newStates = getNewStates(newP, oldStates,nrStates)

    l = length(oldStates);
    if length(oldStates) == newP;
        newStates = formNewStates(oldStates,nrStates);
    else
        newStates = formNewStates(oldStates,nrStates);
        newStates(l+1) = floor(rand(1)*nrStates) + 1;
    end
    
end


function nS = formNewStates(oldStates,nrStates)

    nS = oldStates;
    for i = 1:length(oldStates)
        oldpos = oldStates(i) ;
        newpos = getNewPosition(oldpos, nrStates);
        nS(i) = newpos;
    end
end

function newpos = getNewPosition(oldpos,nrStates)

    p = rand(1) ;
    if p < 0.91
        newpos = oldpos;
    %elseif p > 0.4 && p < 0.8
    %    newpos = getNewPos1(oldpos,nrStates);
    %else
    %    %newpos = floor(rand(1)*nrStates) + 1;
    %    newpos = getNewPos2(oldpos,nrStates);
    %end
    else 
        newpos = getNewPos1(oldpos,nrStates);
    end
end

function nP = getNewPos2(oldPos,nrStates) 

    if (oldPos==1)
        vec = [oldPos+2, nrStates-1];
    elseif (oldPos==nrStates)
        vec = [oldPos-2, 2];
    elseif (oldPos==2)
        vec = [nrStates,4];
    elseif (oldPos==9)
        vec = [oldPos-2 , 1];
    else
        vec = [oldPos - 2, oldPos + 2];
    end
    nP = randsample(vec,1);
        
end

function nP = getNewPos1(oldPos,nrStates) 

    if (oldPos==1)
        vec = [oldPos+1, nrStates];
    elseif (oldPos==nrStates)
        vec = [oldPos-1, 1];
    else
        vec = [oldPos - 1, oldPos + 1];
    end
    nP = randsample(vec,1);
        
end