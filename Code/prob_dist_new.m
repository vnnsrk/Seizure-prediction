% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [x_bestfit] = prob_dist_new(f_test,m,cd)

    % For new dataset:
    % x = load('x_dir_new_partial.mat');
    x = load('x_dir_new.mat');

    x = x.x1;
    x_test=f_test;

    err_min=inf; sum=0;

    for j=1:500
        if(j~=cd)
            for k=1:m
                err(k)=abs(x_test(k)-x(k,j));
                err(k)=err(k).^2;
                sum=sum+err(k);
            end
            avg_err=sqrt(sum)/m;
            if(avg_err<err_min)
                err_min=avg_err;
                x_bestfit(1,:)=x(:,j);
            end
            sum=0;
        end
    end 
end