function rew = getmyRewardIR(nrstates,nractions)
rew = zeros(nrstates,nractions);

for i=1:nrstates
    for j=1:nractions
        if i==j
            rew(i,j) = 1;
        else
            rew(i,j) = 0;
        end
        
    end
end


% 
% 
% for i=1:nrstates
%     for j=1:nractions
%         if i==1 %state - A
%             if j==1
%                 rew(i,j)=1;
%             else
%                 rew(i,j)=0;
%             end
%         end
%         if i==2
%             if j==2
%                 rew(i,j)=1;
%             else
%                 rew(i,j)=0;
%             end
%         end
%         if i==3
%             if j==3
%                 rew(i,j)=1;
%             else
%                 rew(i,j)=0;
%             end
%         end
%         if i==4
%             if j==4
%                 rew(i,j)=1;
%             else
%                 rew(i,j)=0;
%             end
%         end
%         if i==5
%             rew(i,j)=0;
%         end
%     end
% end
%rew(1,1) = 1;
%rew(1,2) = 0;
%rew(2,1) = 0;
%rew(2,2) = 1;
end