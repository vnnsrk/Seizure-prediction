% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

clear;
close all;
main_dir = '..\Data\Test\';
sub_dir = {'F\','N\','O\','S\','Z\'};

iter=1;
for sd = 1:length(sub_dir)
    cur_dir = dir([main_dir,sub_dir{sd},'\*.txt']);
    for cd=1:length(cur_dir)
        disp(iter);
        iter=iter+1;
        f_test = load([main_dir,sub_dir{sd},cur_dir(cd).name]); 
        m = 100;
        serial_len = 500;
        parallel_len = 1;
        % f_test=load('E:\DSP 2\Dataset\Data_F_Ind_2251_3000\Data_F_Ind2281.txt');
        % f_test = load('E:\DSP 2\Dataset2\S\S007.txt');
        f_test_t = f_test';
        X=f_test(1:m,1);

        % Y=f_test(1:m,2); [x_bestfit] = prob_dist([X,Y],m);  % For focal non focal data
        [x_bestfit] = prob_dist_new(X,m,cd);    % For new data

        % Wo = KR_trainer(X,m);
%         if(iter>399 && iter<500)
%             [Wo,So] = kf_trainer_test1([X;x_bestfit(m+1)],m);
%         else
             Wo = zeros(1,m);
%         end
        % [Wo] = rls_trainer([X;x_bestfit(m+1)],m);
%         Wo = zeros(1,m);
        for k=1:m
            y1_hat(k,(1:m+1-k)) = X(k:m);
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

        % for k=1:parallel_len
        % serial_concatenation
        k=1;
        for i=1:serial_len
            [y1_hat(k,m+i),W_new] = myparticle(y1_hat(k,i:m+i-1),y_est(k,i),Wo);%,So,m
            %y1_hat(k,m+i)=y_est(k,i);
        %     [y1_hat(k,m+i),W_new] = rls_predict(y1_hat(k,i:m+i-1)',y_est(k,i),Wo,m);
        end
         %end
        Y1_hat = y1_hat;
        j1 = serial_len;
        for i= 2:serial_len
            j2= j1-1;
            for k = 2:parallel_len
                Y1_hat(1,m+j1) = (Y1_hat(1,m+j1)+ Y1_hat(k,m+j2))/2;
                j2 = j2-1;
                if(j2==0)
                    break;
                end
            end 
            j1 = j1-1;
        end
        t(sd,cd) = toc;
        real_sig = f_test_t;
        pred_sig = y1_hat;

        
%         u = 1:m+serial_len;
%         figure;
%         plot(u,real_sig(1,(1:m+serial_len)+1),'r-');
%         hold on;
%         plot(u,pred_sig(1,(1:m+serial_len)),'b-');
%         %plot(u,Y1_hat(1,(1:m+serial_len)));
%         legend('dataset','serial Prediction');%,'Kalman Block Prediction');
%         title('Serial-Parallel concatenation Kalman Filter Block');
%         grid
%         hold off;

%         figure
%         plot(abs(f_test_t(1,(1:m+serial_len))-y1_hat(1,(1:m+serial_len))))
%         %  for k=1:parallel_len
%         %  plot(u(k:(36+k-1)),y1_hat(k,(1:m+serial_len)));
%         %  end
        seizure_decision(sd,cd) = sqrt(sum(pred_sig(1,:).^2))>2200;
        pause;
    end
end

actual_decision = [zeros(1,100);zeros(1,100);zeros(1,100);ones(1,100);zeros(1,100)];
% actual_decision=zeros(1,100);
tnr_ind = find((actual_decision - seizure_decision)>0);
tnr = length(tnr_ind);
fpr_ind = find((actual_decision - seizure_decision)<0);
fpr = length(fpr_ind);
%% ENERGY PROFILE TO SHOW THRESHOLD OF DECISION FOR NEW DATASET:
% 
% main_dir = 'C:\Users\srinath8n\Documents\MATLAB\ucsd\ECE251B\project\new\newdata\';
% sub_dir = {'F\','N\','O\','S\','Z\'};
% for i = 1:length(sub_dir)
% cur_dir = dir([main_dir,sub_dir{i},'\*.txt']);
% %     figure
% for j=1:length(cur_dir)
% data = load([main_dir,sub_dir{i},cur_dir(j).name]);
% data_fft = data(1:500);
% eng_sig(i,j) = sqrt(mean(sum(data_fft.^2)));
% %         plot(data_fft(:,1:2))
% %         hold on
% end
% %     hold off
% end
% plot(eng_sig')
