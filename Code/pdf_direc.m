% Seizure prediction 
% Author  : Srinath Narayanan
% For ECE 251B course at UCSD
% Date : 06-11-2017

function [x,y] = pdf_direc()

    % PDF Generation for x(m+1),x(m+2)....x(n) given datatset x(1)..x(m)

    % Loading the values for establishing correlation
    % Taking the first file containing 750 Focal values
    % main_dir = '..\Data\';
    % sub_dir = {'Data_F_Ind_1_750\','Data_F_Ind_2251_3000\','Data_N_Ind_1_750\','Data_N_Ind_2251_3000\'};

    for i = 1:2
        %length(sub_dir)
        cur_dir = dir([main_dir,sub_dir{i},'\*.txt']);
        for j=1:length(cur_dir)
            data_temp = load([main_dir,sub_dir{i},cur_dir(j).name]);
            x1(:,j+(i-1)*length(cur_dir)) = data_temp(:,1);
            y1(:,j+(i-1)*length(cur_dir)) = data_temp(:,2);
        end
    end
    for i = 3:4%length(sub_dir)
        cur_dir = dir([main_dir,sub_dir{i},'\*.txt']);
        for j=1:length(cur_dir)
            data_temp = load([main_dir,sub_dir{i},cur_dir(j).name]);
            x2(:,j+(i-2)*length(cur_dir)) = data_temp(:,1);
            y2(:,j+(i-2)*length(cur_dir)) = data_temp(:,2);
        end
    end
    x3(1:length(x2)/2,:) =  x2(1:length(x2)/2,:);
    x3(length(x2)/2+1:length(x2),:) =  x1(length(x2)/2+1:length(x2),:);
    y3(1:length(x2)/2,:) =  y2(1:length(x2)/2,:);
    y3(length(x2)/2+1:length(x2),:) =  y1(length(x2)/2+1:length(x2),:);
    x = [x1,x2,x3];
    y = [y1,y2,y3];

    % For new dataset:
    main_dir = 'Data\';
    sub_dir = {'F\','N\','O\','S\','Z\'}; %S is seizure data

    for i = 1:5%length(sub_dir)
        cur_dir = dir([main_dir,sub_dir{i},'\*.txt']);
        for j=1:3*length(cur_dir)/4
            data_temp = load([main_dir,sub_dir{i},cur_dir(j).name]);
            x1(:,j+(i-1)*length(cur_dir)) = data_temp(:,1);
    %         y1(:,j) = data_temp(:,2);
        end
    end
end