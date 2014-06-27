function runSims2()
%nPpl = size(realTrack,1);
nGrid = 4; nPpl = 4;
belief = (1/nGrid)*ones(nPpl,nGrid);

for t = 1:size(realTrack,2)
    
    if strcmp(policy,'Normal')
        
        a = getBestActionMP(belief,h,VF,pomdp)
        
    end
    
end


end


function a = getBestActionMP(belief,h,VF,pomdp)

    
    

end