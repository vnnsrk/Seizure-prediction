% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [y,W_new] = rls_predict(X,y_est,Wo,p)

    % So = eye(p);
    % Updating
    % X = fliplr(sig(1+i:p+i)'); % Or any window of p values 
    lam = 0.99; 
    lamda = lam.^(p-1:-1:0); 
    W_old = Wo'; 
    Po = inv(lamda'.*(X-mean(X))*(X-mean(X))'); % R is cov matrix of X
    err = inf; 
    iter = 0;
    P_old = Po; 
    
    while(err>0.1&&iter<100)
        err = y_est - W_old'*X;%+1.5*randn();
        g = P_old*X/(lam+X'*P_old*X);
        P_new = P_old/lam - g*X'*P_old/lam;
        W_new = W_old + err*g;
        iter = iter+1;
        W_old = W_new; P_old = P_new;
    end
    y = W_old'*X;

end
