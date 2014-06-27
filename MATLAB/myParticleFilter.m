clear all
close all
clc

x = 0.1;  % x is the real state
x_N = 1;
x_R = 1;
T = 75;
N = 100;

V = 2;
x_P = []; % vector of particles
for i = 1:N
    x_P(i) = x + sqrt(V) * randn;
end


z_out = [x^2 / 20 + sqrt(x_R) * randn];  %the actual output vector for measurement values.
x_out = [x];  %the actual output vector for measurement values.
x_est = [x]; % time by time output of the particle filters estimate
x_est_out = [x_est]; % the vector of particle filter estimates.

for t = 1:T
    
    x = 0.5*x + 25*x/(1 + x^2) + 8*cos(1.2*(t-1)) +  sqrt(x_N)*randn; % next state
    z = x^2/20 + sqrt(x_R)*randn;   % next obs
    
    for i = 1:N
        
        x_P_update(i) = 0.5*x_P(i) + 25*x_P(i)/(1 + x_P(i)^2) + 8*cos(1.2*(t-1)) + sqrt(x_N)*randn;
        z_update(i) = x_P_update(i)^2/20;
        P_w(i) = (1/sqrt(2*pi*x_R)) * exp(-(z - z_update(i))^2/(2*x_R));
        
    end
    
    P_w = P_w./sum(P_w);
    
    for i = 1 : N
        x_P(i) = x_P_update(find(rand <= cumsum(P_w),1));
    end
    
    x_est = mean(x_P);
    x_out = [x_out x];
    z_out = [z_out z];
    x_est_out = [x_est_out x_est];
    
end

