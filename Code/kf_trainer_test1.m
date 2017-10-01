% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [W_new,S_new] = kf_trainer_test1(X,m)
    % order
    p = 2;
    Wo = [0 0];
    So = eye(p);

    % Updating
    % data=load('../Data/Data_F_Ind2261.txt');
    % sig = data(:,1);
    % X = fliplr(sig(1:p)');
    % Or any window of p values 

    sig = X;
    S_old = So; W_old = Wo; 
    Ro = (X-mean(X))'*(X-mean(X)); % R is cov matrix of X

    for p=2:m
        y_est = sig(p+1);
        X = fliplr(sig(1:p)');
        Ro = (X-mean(X))'*(X-mean(X)); 
        err = inf; iter = 0;
        while(err>0.0001&&iter<100)
            y = W_old*X'+1.5*randn();
            K_new = S_old*X'/(var(W_old)+X*S_old*X');
            A_new = W_old'+K_new*(y_est-y);
            p;
            W_new = A_new' ;
            S_new = (eye(p)-K_new*X)*S_old;
            err = abs(y_est-y); 
            S_old = S_new; W_old = W_new;
            iter = iter+1;
        end
        W_old = [W_old,zeros(1,1)];
        S_old(p+1,p+1) = 1;
    end
end