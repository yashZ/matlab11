function rew = getmyReward()
rew = zeros(5,16);
for i=1:5
    for j=1:16
        if i==1 %state - A
            if j==1 || j==5 || j==9 || j==13
                rew(i,j)=1;
            else
                rew(i,j)=0;
            end
        end
        if i==2
            if j==2 || j==6 || j==10 || j==14
                rew(i,j)=1;
            else
                rew(i,j)=0;
            end
        end
        if i==3
            if j==3 || j==7 || j==11 | j==15
                rew(i,j)=1;
            else
                rew(i,j)=0;
            end
        end
        if i==4
            if j==4 || j== 8 || j==12 || j==16
                rew(i,j)=1;
            else
                rew(i,j)=0;
            end
        end
        if i==5
            rew(i,j)=0;
        end
    end
end
end