mfunction O = getmyObs(nrstates,nractions,nrobs)
    
% O(s,a,o)

% actions -                                                                 
% a1 - pred1 + obs1
% a2 - pred2 + obs1
% a3 - pred3 + obs1
% a4 - pred4 + obs1
% a5 - pred1 + obs2
% a6 - pred2 + obs2
% a7 - pred3 + obs2
% a8 - pred4 + obs2
% a9 - pred1 + obs3
% a10 - pred2 + obs3
% a11 - pred3 + obs3
% a12 - pred4 + obs3
% a13 - pred1 + obs4
% a14 - pred2 + obs4
% a15 - pred3 + obs4
% a16 - pred4 + obs4

% action config - 
% so prediction change like first bit ( cont)
% but obs change like second bit (only after one iteration of pred changes)


% number of action estimation - 
% if S is the number of grid then
% nActionN = S
% nPredN = S
% Total action = S^2.



%nrstates = 4;
%nraction = 16;
%nrobs = 4;
O = zeros(nrstates,nractions,nrobs);

numtoadd = nrstates;

actionSet = [0:numtoadd:nractions];

defobscorrect = 0.09/(nrstates-1);
defobswrong = 0.9/(nrstates-1);

for s=1:nrstates
    s;
    minActionBrac = (s-1)*nrstates;
    maxActionBrac = minActionBrac + numtoadd + 1;
    for a=1:nractions
        for o=1:nrobs
            %for i=1:length(actionSet)
                if a>minActionBrac && a<maxActionBrac
                    if s==o
                        O(s,a,o) = 0.91;
                    else
                        O(s,a,o) = defobscorrect;
                    end
                else
                    if (floor(a/nrstates) + 1) == o
                        O(s,a,o) = 0.1;
                    else
                        O(s,a,o) = defobswrong;
                    end     
                end  
            %end
        end
    end
end


% 
% for s=1:nrstates
%     actionbracmin = s-1;
%     actionbracmax = s*numtoadd + 1;
%     
% end



% 
% for s=1:nrstates
%     for a=1:nraction
%         if s==1
%             if a>0 && a<5 
%                 O(s,a,1) = 0.91;
%                 O(s,a,2) = 0.03;
%                 O(s,a,3) = 0.03;
%                 O(s,a,4) = 0.03;
%             elseif a>4 && a<9
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.1;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>8 && a<13
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.1;
%                 O(s,a,4) = 0.3;
%             elseif a>12 && a<17
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.1;
%             end
%         elseif s==2
%             if a>0 && a<5 
%                 O(s,a,1) = 0.1;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>4 && a<9
%                 O(s,a,1) = 0.03;
%                 O(s,a,2) = 0.91;
%                 O(s,a,3) = 0.03;
%                 O(s,a,4) = 0.03;
%             elseif a>8 && a<13
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.1;
%                 O(s,a,4) = 0.3;
%             elseif a>12 && a<17
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.1;
%             end
%         elseif s==3
%             if a>0 && a<5 
%                 O(s,a,1) = 0.1;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>4 && a<9
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.1;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>8 && a<13
%                 O(s,a,1) = 0.03;
%                 O(s,a,2) = 0.03;
%                 O(s,a,3) = 0.91;
%                 O(s,a,4) = 0.03;
%             elseif a>12 && a<17
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.1;
%             end
%         elseif s==4
%             if a>0 && a<5 
%                 O(s,a,1) = 0.1;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>4 && a<9
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.1;
%                 O(s,a,3) = 0.3;
%                 O(s,a,4) = 0.3;
%             elseif a>8 && a<13
%                 O(s,a,1) = 0.3;
%                 O(s,a,2) = 0.3;
%                 O(s,a,3) = 0.1;
%                 O(s,a,4) = 0.3;
%             elseif a>12 && a<17
%                 O(s,a,1) = 0.03;
%                 O(s,a,2) = 0.03;
%                 O(s,a,3) = 0.03;
%                 O(s,a,4) = 0.91;
%             end
%         end
%     end
% end


end