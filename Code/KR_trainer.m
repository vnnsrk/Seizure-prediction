% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [W_new] = KR_trainer(m)
    for p=1:m
        So = eye(p);
        Wo = [0,zeros(1,p-1)];
        % Updating
        text_file = '../Data/Data_F_Ind2261.txt';
        data =load(text_file,'ascii');
        sig = data(:,1);
        y_est = sig(p+1);
         X = fliplr(sig(1:p)'); % Or any window of p values 
        S_old = So; W_old = Wo; 
        Ro = (X-mean(X))'*(X-mean(X)); % R is cov matrix of X
        err = inf; iter = 0;
        while(err>0.1&&iter<100)
            y = W_old*X'+1.5*randn();
            K_new = S_old*X'/(var(W_old)+X*S_old*X');
            A_new = W_old'+K_new*(y_est-y);
            W_new = A_new'; 
            S_new = (eye(p)-K_new*X)*S_old;
            err = abs(y_est-y); 
            S_old = S_new; W_old = W_new;
            iter = iter+1;
        end
    end
end