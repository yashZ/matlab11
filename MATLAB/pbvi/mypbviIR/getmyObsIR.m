function obs = getmyObsIR(nrstates,nraction,nrobs)
obs= zeros(nrstates,nraction,nrobs);
% obs(1,1,:) = [0.91,0.03,0.03,0.03];
% obs(1,2,:) = [0.3,0.1,0.3,0.3];
% obs(1,3,:) = [0.3,0.3,0.1,0.3];
% obs(1,4,:) = [0.3,0.3,0.3,0.1];
% obs(2,1,:) = [0.1,0.3,0.3,0.3];
% obs(2,2,:) = [0.03,0.91,0.03,0.03];
% obs(2,3,:) = [0.3,0.3,0.1,0.3];
% obs(2,4,:) = [0.3,0.3,0.3,0.1];
% obs(3,1,:) = [0.1,0.3,0.3,0.3];
% obs(3,2,:) = [0.3,0.1,0.3,0.3];
% obs(3,3,:) = [0.03,0.03,0.91,0.03];
% obs(3,4,:) = [0.3,0.3,0.3,0.1];
% obs(4,1,:) = [0.1,0.3,0.3,0.3];
% obs(4,2,:) = [0.3,0.1,0.3,0.3];
% obs(4,3,:) = [0.3,0.3,0.1,0.3];
% obs(4,4,:) = [0.03,0.03,0.03,0.91];


defobscorrect = 0.09/(nrstates - 1);
if nrstates < 100
    defobswrong = 0.9/(nrstates - 1);
else
    defobswrong = 1/nrstates;
end
for i=1:nrstates
    for j = 1:nraction
        for k=1:nrobs
           if i==j       % if state and action are same grid
               if j==k   % for observation grid
                   obs(i,j,k) = 0.91;
               else
                   obs(i,j,k) = defobscorrect;
               end
               
           else          % if state and action are not same
               if j==k   % if action and obs are same
                   if nrstates < 100
                        obs(i,j,k) = 0.1;
                   else
                        obs(i,j,k) = defobswrong;
                   end
               else
                   obs(i,j,k) = defobswrong;
               end
           end
        end
    end
end



% for i=1:4    % if in A
%     for j=1:4   % you choose to observe A
%         
%         if i==1 
%             if j==1 
%                 obs(i,j,:) = [0.91,0.03,0.03,0.03];
%             else
%                 obs(i,j,:) = [0.1,0.3,0.3,0.3];
%             end
%         end
%         
%         if i==2 
%             if j==2 
%                 obs(i,j,:) = [0.03,0.91,0.03,0.03];
%             else
%                 obs(i,j,:) = [0.3,0.1,0.3,0.3];
%             end
%         end
%         
%         if i==3
%             if j==3
%                 obs(i,j,:) = [0.03,0.03,0.91,0.03];
%             else
%                 obs(i,j,:) = [0.3,0.3,0.1,0.3];
%             end
%         end
%         
%         if i==4
%             if j==4
%                 obs(i,j,:) = [0.03,0.03,0.03,0.91];
%             else
%                 obs(i,j,:) = [0.3,0.3,0.3,0.1];
%             end
%         end
%            
% 
%     end
% end
end

        
%         for k=1:4
%             if i==1   
%                 if j==1 
%                     obs(i,j,1) = 0.9; 
%                     obs(i,j,5) = 0.1;
%                 end
%                 if j==2
%                     obs(i,j,2) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==3
%                     obs(i,j,3) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==4
%                     obs(i,j,4) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%             end
%             if i==2 % true state - B
%                 if j==1
%                     obs(i,j,1) = 0.1; 
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==2
%                     obs(i,j,2) = 0.9;
%                     obs(i,j,5) = 0.1;
%                 end
%                 if j==3
%                     obs(i,j,3) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==4
%                     obs(i,j,4) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%             end
%             if i==3 % state - C
%                 if j==1
%                     obs(i,j,1) = 0.1; 
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==2
%                     obs(i,j,2) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==3
%                     obs(i,j,3) = 0.9;
%                     obs(i,j,5) = 0.1;
%                 end
%                 if j==4
%                     obs(i,j,4) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%             end
%             if i==4 % state - D
%                 if j==1 
%                     obs(i,j,1) = 0.1; 
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==2
%                     obs(i,j,2) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==3
%                     obs(i,j,3) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==4
%                     obs(i,j,4) = 0.9;
%                     obs(i,j,5) = 0.1;
%                 end
%             end
%             if i==5 % state - O
%                 if j==1 
%                     obs(i,j,1) = 0.1; 
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==2
%                     obs(i,j,2) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==3
%                     obs(i,j,3) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%                 if j==4
%                     obs(i,j,4) = 0.1;
%                     obs(i,j,5) = 0.9;
%                 end
%             end
%         end


% function obs = getmyObsIR()
% obs=zeros(2,2,2);
% obs(1,1,1) = 0.9;
% obs(1,1,2) = 0.1;
% obs(1,2,1) = 0.9;
% obs(1,2,2) = 0.1;
% obs(2,1,1) = 0.1;
% obs(2,1,2) = 0.9;
% obs(2,2,1) = 0.1;
% obs(2,2,2) = 0.9;
% end
