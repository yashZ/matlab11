function Track1 = simulateData(t)


%numbrPpl = 5;

oldP = 0;
oldStates = [];

D = cell(1);

for i=1:t

    newP = createNewP(oldP);
    newStates = getNewStates(newP, oldStates);
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

function newStates = getNewStates(newP, oldStates)

    l = length(oldStates);
    if length(oldStates) == newP;
        newStates = formNewStates(oldStates);
    else
        newStates = formNewStates(oldStates);
        newStates(l+1) = floor(rand(1)*4) + 1;
    end
    
end


function nS = formNewStates(oldStates)

    nS = oldStates;
    for i = 1:length(oldStates)
        oldpos = oldStates(i) ;
        newpos = getNewPosition(oldpos);
        nS(i) = newpos;
    end
end

function newpos = getNewPosition(oldpos)

    p = rand(1) ;
    if p < 0.5
        newpos = oldpos;
    else
        newpos = floor(rand(1)*4) + 1;
    end
end