clc
clear

%% add path for functions
current_Folder = pwd;
func_Folder = strcat(current_Folder, '\Function');
addpath(func_Folder)

%% set feature number
feature_num = 6;

%% open data directory. space bar in between foler name is okay for MATLAB
default_Folder = ...
    'C:\Emotion_Research\ABM_Analysis';
data_dir = uigetdir(default_Folder, 'open data directory');

%% set saving directory
save_dir = uigetdir(default_Folder, 'open save directory');

%% get all data files
File_list = dir(strcat(data_dir, '\*.xlsx'));

%% sort data
% step1. initiate 3D array of size(size of single data file, length of 
% file list)
% step2. read all Excel files in the directory
% step3. cut only numerical parts in data file and plug in to 3D array
length = size(File_list,1);
size_of_file = size(xlsread([data_dir,'\',File_list(1).name]));
column = size_of_file(2);
data_all = zeros(144, column, length);

for i = 1:length
     current_data = xlsread([data_dir,'\',File_list(i).name]);
    data_all(:,:,i) = current_data(4:size_of_file(1), 1:size_of_file(2));    
end

%% calculate 
% 1) accuracy
% 2) sensitivity (accuracy 1)
% 3) total_accuracy for ITR (accuracy 2)

% get trial number
trial_num = 24;

% create cell to store calculated stat results
% should be cell to store the string of different length
% format: 
%       cell = string, printf(%d%(%d/%d), accuracy, correct score, trial
%               number)
%
%       array = dim(subject, classifier_number, 3)
%       3 = number of accuracies (order: accuracy, sensitivity, acc_total)
% ___________________________________________________________________
%           FLDA    SVM     SWLDA   SWSVM
%____________________________________________________________________
% subject1
% subject2
% ....
%
% create array storing correct score with same format as cell
classifier_num = 4;

data_Excel = cell(length+1, classifier_num+1, 3);
data_Excel_num = cell(length+1, classifier_num+1, 3);
data_Score = zeros(length, classifier_num, 3);

% format cell array 

first_row = [cellstr('FLDA') cellstr('SVM') ...
    cellstr('SWLDA') cellstr('SWSVM')];

for j = 1:3
    data_Excel(1, 2:end, j) = first_row;
    data_Excel_num(1, 2:end, j) = first_row;
    for k = 2:length+1
        cell_value = sprintf('subject_%d', k-1);
        data_Excel(k,1,j) = cellstr(cell_value);
        data_Excel_num(k,1,j) = cellstr(cell_value);
    end
end

for i = 1:length
    current_data = data_all(:,:,i);
    
    % get Target and selected array for classifiers
    target                              = current_data(1:144, 2);
    FLDA_selected                       = current_data(1:144, 6);
    SVM_selected                        = current_data(1:144, 13);
    SWLDA_selected                      = current_data(1:144, 16);
    SWSVM_selected                      = current_data(1:144, 20);
    
    % re-order Target and selected array
    target_revised                               = zeros(1,trial_num);
    FLDA_selected_revised                        = zeros(1,trial_num);
    SVM_selected_revised                         = zeros(1,trial_num);
    SWLDA_selected_revised                       = zeros(1,trial_num);
    SWSVM_selected_revised                       = zeros(1,trial_num);
    
    for j = 1:trial_num
        target_revised(j) = target((j-1)*feature_num+1);
        FLDA_selected_revised(j) = FLDA_selected((j-1)*feature_num+1);
        SVM_selected_revised(j) = SVM_selected((j-1)*feature_num+1);
        SWLDA_selected_revised(j) = ...
            SWLDA_selected((j-1)*feature_num+1);
        SWSVM_selected_revised(j) = ...
            SWSVM_selected((j-1)*feature_num+1);       
    end
    
    % get ERP_total for all classifiers
    FLDA_ERP                       = current_data(:, 4);
    SVM_ERP                        = current_data(:, 11);
    SWLDA_ERP                      = current_data(:, 14);
    SWSVM_ERP                      = current_data(:, 17);
       
    % make online label
    onlineLabel = zeros(1,144);
    target_order = zeros(1,trial_num);
    
    for j = 1:trial_num
        target_order(j) = target_revised(j)+(j-1)*6+1;
    end
    onlineLabel(target_order) = 1;
    
    %calculate accuracy
    [acc1 cs_acc1] = accuracy(target_revised, FLDA_selected_revised);
    [acc2 cs_acc2] = accuracy(target_revised, SVM_selected_revised);
    [acc3 cs_acc3] = accuracy(target_revised, ...
        SWLDA_selected_revised);
    [acc4 cs_acc4] = accuracy(target_revised, ...
        SWSVM_selected_revised);
        
    %calculate sensitivity (accuracy 1)
    [sen1 cs_sen1] = sensitivity(target_order, FLDA_ERP);
    [sen2 cs_sen2] = sensitivity(target_order, SVM_ERP);
    [sen3 cs_sen3] = sensitivity(target_order, ...
        SWLDA_ERP);
    [sen4 cs_sen4] = sensitivity(target_order, ...
        SWSVM_ERP);
        
     %calculate total accuracy (accuracy 2)
    [act1 cs_act1] = accu_tot(onlineLabel, FLDA_ERP);
    [act2 cs_act2] = accu_tot(onlineLabel, SVM_ERP);
    [act3 cs_act3] = accu_tot(onlineLabel, ...
        SWLDA_ERP);
    [act4 cs_act4] = accu_tot(onlineLabel, ...
        SWSVM_ERP);
        
    % store data into separate array
    acc = [acc1, acc2, acc3, acc4];
    cs_acc = [cs_acc1, cs_acc2, cs_acc3, cs_acc4];
    
    sen = [sen1, sen2, sen3, sen4];
    cs_sen = [cs_sen1, cs_sen2, cs_sen3, cs_sen4];
    
    act = [act1, act2, act3, act4];
    cs_act = [cs_act1, cs_act2, cs_act3, cs_act4];   
    
    % store data into cell and double array to save as Excel and
    % statistical analysis
       
    % accuracy
    for j = 2:5
        cell_value = sprintf('%.3f(%d/%d)', acc(j-1), cs_acc(j-1), trial_num);
        data_Excel(i+1, j,1) = cellstr(cell_value);
        data_Excel_num(i+1, j,1) = num2cell(acc(j-1));
        data_Score(i, j-1 ,1) = cs_acc(j-1);
    end
    
    % sensitivity (accuracy 1)
    for j = 2:5
        cell_value = sprintf('%.3f(%d/%d)', sen(j-1), cs_sen(j-1), trial_num);
        data_Excel(i+1, j ,2) = cellstr(cell_value);
        data_Excel_num(i+1, j ,2) = num2cell(sen(j-1));
        data_Score(i, j-1 ,2) = cs_sen(j-1);
    end
    
    % accuracy total (accuracy 2)
    for j = 2:5
        cell_value = sprintf('%.3f(%d/%d)', act(j-1), cs_act(j-1), 144);
        data_Excel(i+1, j ,3) = cellstr(cell_value);
        data_Excel_num(i+1, j ,3) = num2cell(act(j-1));
        data_Score(i, j-1 ,3) = cs_act(j-1);
    end
    
end

%% store data_Excel

save_data_Excel = strcat(save_dir, '\Acc_Result.xlsx');
xlswrite(save_data_Excel,data_Excel(:,:,1),1);
xlswrite(save_data_Excel,data_Excel(:,:,2),2);
xlswrite(save_data_Excel,data_Excel(:,:,3),3);

save_data_Excel_num = strcat(save_dir, '\Acc_Result_num.xlsx');
xlswrite(save_data_Excel_num,data_Excel_num(:,:,1),1);
xlswrite(save_data_Excel_num,data_Excel_num(:,:,2),2);
xlswrite(save_data_Excel_num,data_Excel_num(:,:,3),3);

%% Statistical analysis

hypo = zeros(3,4);
p_value = zeros(3,4);

% perform ks test 
for i = 1:3       
    current_data = data_Score(:,:,i);
    for j = 1:4
        now = current_data(:,j);
        st_dev = std(now);
        avg = mean(now);
        if(st_dev == 0)
            normalized = now;
        else
            normalized = (now - avg)./st_dev;
        end
        [hypo(i,j) p_value(i,j)] = kstest(normalized);
    end 
end

% save ks-test result
save_kstest = strcat(save_dir, '\KS_Result.xlsx');
ks_result = cell(4, 5, 2);
for i = 1:2
    ks_result(1, 2:5, i) = first_row;
    ks_result(2:4,1, i) = [cellstr('accuracy'), cellstr('sensitivity'),...
        cellstr('accuracy_total')];
end
ks_result(2:4,2:5,1) = num2cell(hypo);
ks_result(2:4,2:5,2) = num2cell(p_value);

xlswrite(save_kstest,ks_result(:,:,1),1);
xlswrite(save_kstest,ks_result(:,:,2),2);

% construct group
group = cell(4, length);
 for i = 1:length
    group(:,i) = first_row';
 end
 group = oneD2twoD(group);
 
 Test_P_val = zeros(1,3);
 Test_ANOVA_Tab = cell(5,6,3);
 
% perform ANOVA one-way(Kruskalwallis) test
for i = 1:3
    current_data = data_Score(:,:,i);
    current_data = oneD2twoD(current_data');
    % determine wheter parametric vs. non-parametric
    param = find(hypo(i,:), 1);
    
    if(isempty(param))
        % parametrical case
        % use anova1 to test        
        [P,ANOVATAB,STATS] = anova1(current_data',group');
        Test_P_val(i) = P;
        Test_ANOVA_Tab(1,1,i) = cellstr('ANOVA1');
        Test_ANOVA_Tab(2:5,:,i) = ANOVATAB;
       
    else
        % non-parametrical case
        % use KruskalWallis test
        [P,ANOVATAB,STATS] = kruskalwallis(current_data, group);
        Test_P_val(i) = P;
        Test_ANOVA_Tab(1,1,i) = cellstr('Kruskalwallis');
        Test_ANOVA_Tab(2:5,:,i) = ANOVATAB;
    end
end

save_anova = strcat(save_dir, '\ANOVA_result.xlsx');
xlswrite(save_anova,Test_P_val,1);
xlswrite(save_anova,Test_ANOVA_Tab(:,:,1),2);
xlswrite(save_anova,Test_ANOVA_Tab(:,:,2),3);
xlswrite(save_anova,Test_ANOVA_Tab(:,:,3),4);

figHandles = findobj('Type','figure');
fig_num = size(figHandles,1);

for i = 1:fig_num
    fig = figure(figHandles(i));
    file_name = strcat(save_dir, '\figure_',num2str(figHandles(i)));
    print(fig,file_name, '-dpng')    
end









