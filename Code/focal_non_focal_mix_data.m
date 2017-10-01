% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017


clear;
close all;

m = 600;
serial_len = 50;
parallel_len = 1;
y1_hat = zeros(m,10240);
y_est = zeros(1,10240);
Y1_hat = zeros(1,10240);
f_test1_downsample_256 = zeros(512,2);

test_file = '../Data/Data_F_Ind2261.txt';

f_test1=load(test_file,'ascii');
f_test2=load(test_file,'ascii');
f_test(1:512,:) =  f_test2(1:512,:);
f_test(513:1024,:) =  f_test1(513:1024,:);
f_test_t = f_test';


X=f_test(1:m,1)';
%Y=f_test1([1:m],2)';

[x_bestfit] = prob_dist(f_test,m);
Wo = KR_trainer(X,m);

for k=1:m
    y1_hat(k,(1:m+1-k)) = X(1,k:m);
    if(k>1)
      y1_hat(k,(m+1-k:m)) = x_bestfit(1,m+1:m+k);
    end
end
  
for k=1:parallel_len
    for i=1:serial_len
        y_est(k,i) = x_bestfit(1,m+i+k-1);
    end
end 
tic;

for i=1:serial_len
    [y1_hat(1,m+i),W_new] = kf_predict(y1_hat(1,i:m+i-1),y_est(1,i),Wo,m);
end

% Y1_hat = y1_hat;
% j1 = serial_len;
% for i= 2:serial_len
%   j2= j1-1;
%   for k = 2:parallel_len
%       Y1_hat(1,m+j1) = (Y1_hat(1,m+j1)+ Y1_hat(k,m+j2))/2;
%       j2 = j2-1;
%       if(j2==0)
%           break;
%       end
%   end 
%   j1 = j1-1;
% end

t = toc;
u = 1:m+serial_len;
plot(u,f_test_t(1,(1:m+serial_len)));
hold on
plot(u,y1_hat(1,(1:m+serial_len)));

%  hold on
%  plot(u,Y1_hat(1,(1:m+serial_len)));
%  for k=1:parallel_len
%  plot(u(k:(36+k-1)),y1_hat(k,(1:m+serial_len)));
%  end

legend('dataset','serial Prediction','Kalman Block Prediction');
title('Serial-Parallel concatenation Kalman Filter Block');
grid
hold off;