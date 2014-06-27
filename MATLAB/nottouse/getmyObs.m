function obs = getmyObs()
obs= zeros(5,16,5); 
for i=1:5
    for j=1:16
        for k=1:5
            if i==1    % true state - A
                if j>0 && j<5 
                    obs(i,j,1) = 0.9; 
                    obs(i,j,5) = 0.1;
                end
                if j>4 && j<9
                    obs(i,j,2) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>8 && j<13
                    obs(i,j,3) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>12 && j<17
                    obs(i,j,4) = 0.1;
                    obs(i,j,5) = 0.9;
                end
            end
            if i==2 % true state - B
                if j>0 && j<5 
                    obs(i,j,1) = 0.1; 
                    obs(i,j,5) = 0.9;
                end
                if j>4 && j<9
                    obs(i,j,2) = 0.9;
                    obs(i,j,5) = 0.1;
                end
                if j>8 && j<13
                    obs(i,j,3) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>12 && j<17
                    obs(i,j,4) = 0.1;
                    obs(i,j,5) = 0.9;
                end
            end
            if i==3 % state - C
                if j>0 && j<5 
                    obs(i,j,1) = 0.1; 
                    obs(i,j,5) = 0.9;
                end
                if j>4 && j<9
                    obs(i,j,2) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>8 && j<13
                    obs(i,j,3) = 0.9;
                    obs(i,j,5) = 0.1;
                end
                if j>12 && j<17
                    obs(i,j,4) = 0.1;
                    obs(i,j,5) = 0.9;
                end
            end
            if i==4 % state - D
                if j>0 && j<5 
                    obs(i,j,1) = 0.1; 
                    obs(i,j,5) = 0.9;
                end
                if j>4 && j<9
                    obs(i,j,2) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>8 && j<13
                    obs(i,j,3) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>12 && j<17
                    obs(i,j,4) = 0.9;
                    obs(i,j,5) = 0.1;
                end
            end
            if i==5 % state - O
                if j>0 && j<5 
                    obs(i,j,1) = 0.1; 
                    obs(i,j,5) = 0.9;
                end
                if j>4 && j<9
                    obs(i,j,2) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>8 && j<13
                    obs(i,j,3) = 0.1;
                    obs(i,j,5) = 0.9;
                end
                if j>12 && j<17
                    obs(i,j,4) = 0.1;
                    obs(i,j,5) = 0.9;
                end
            end
        end
    end
end
end