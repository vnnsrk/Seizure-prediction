% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [W_new] = rls_trainer(X,m)
    % Initial weights
    Wo = [0 0]';

    lam = 0.99; 
    sig = X;
    W_old = Wo; 

    for p=2:m
        y_est = sig(p+1);
        X = fliplr(sig(1:p));
        lamda = [lam].^(p-1:-1:0); 
        P_old = inv(lamda'.*(X-mean(X))*(X-mean(X))');
        err = inf; iter = 0;
        while(err>0.0001&&iter<100)
            err = y_est - W_old'*X;%+1.5*randn();
            g = P_old*X/(lam+X'*P_old*X);
            P_new = P_old/lam - g*X'*P_old/lam;
            W_new = W_old + err*g;
            W_old = W_new; P_old = P_new;
            iter = iter+1;
        end
        W_old = [W_old;zeros(1,1)];
    end
end