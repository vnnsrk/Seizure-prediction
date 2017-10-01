% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [y,W_new] = kf_predict(X,y_est,Wo,So,p)

% So = eye(p);
% Updating
% X = fliplr(sig(1+i:p+i)'); % Or any window of p values 

S_old = So; W_old = Wo; 
% Ro = (X-mean(X))'*(X-mean(X)); % R is cov matrix of X, use if needed

err = inf; 
iter = 0;
while(err>0.1&&iter<100)
    y = W_old*X';   % +1.5*randn(); (AWGN Noise)
    K_new = S_old*X'/(var(W_old)+X*S_old*X');
    A_new = W_old'+K_new*(y_est-y);
    W_new = A_new'; 
    S_new = (eye(p)-K_new*X)*S_old;
    err = abs(y_est-y); 
    S_old = S_new; W_old = W_new;
    iter = iter+1;
end