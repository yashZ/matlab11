function R = getmyReward(nrstates,nractions)

% R(s,a)

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

R = zeros(nrstates,nractions);

    function remm = get_remm(j,nrstates)
        if rem(j,nrstates) == 0
            remm =4;
        else
            remm = rem(j,nrstates);
        end
        
    end

for i=1:nrstates
    for j=1:nractions
        remm = get_remm(j,nrstates);
        if remm==i
            R(i,j) = 1;
        else
            R(i,j) = 0;
        end
    end
end




end


% nrstates = 4;
% nractions = 16;
% 
% R = zeros(nrstates,nractions);
% 
% for i=1:nrstates
%     for j=1:nractions
%         if i==1
%             if j==1 || j==5 || j ==9 || j==13
%                 R(i,j) = 1;
%             else
%                 R(i,j) = 0;
%             end
%         elseif i==2 
%             if j==2 || j==6 || j==10 || j==14
%                 R(i,j) = 1;
%             else
%                 R(i,j) = 0;
%             end
%         elseif i==3 
%             if j==3 || j==7 || j==11 || j==15
%                 R(i,j) = 1;
%             else
%                 R(i,j) = 0;
%             end
%         elseif i==4 
%             if j==4 || j==8 || j==12 || j==16
%                 R(i,j) = 1;
%             else
%                 R(i,j) = 0;
%             end
%         end
%         
%     end
% end
% 
% 
% end