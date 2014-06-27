%plotCampGraphs()

figure;
hold all;
color = ['b','r','g','c','m','y']
k = 0;
hs = [2,4,6,8,10];

for i = 1:length(hs)
    j = hs(i)
    k = k + 1;
    
    plot(cumsum(mean(stt(j).rew1)),color(k));
    %errorbar(cumsum(mean(stt(j).rew1)),std(cumsum(stt(j).rew1)),color(k));
end

%errorbar(cumsum(mean(stt(1).rew1)),std(mean(stt(1).rew1))