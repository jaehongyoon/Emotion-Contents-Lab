clc
clear

% add path for functions
current_Folder = pwd;
func_Folder = strcat(current_Folder, '\Function');
addpath(func_Folder)

% open data directories (Test_result)
default_data_Folder = ...
    'C:\Emotion_Research\ABM_Analysis\ABM_Analysis_Data_150304';
dir_result = uipickfiles('filterspec', default_data_Folder,...
    'prompt','Open test result directories');
length_default = size(default_data_Folder,2);

% set data saving path
default_save_Folder = ...
    'C:\Emotion_Research\ABM_Analysis';
save_dir = uigetdir(default_save_Folder, 'Select save directory/folder');

% get name of subjects'
length = size(dir_result,2);
subject_name = cell(1,length);
for i = 1:length
    Folders_inside = dir(char(dir_result(i)));
    Folders_inside = Folders_inside(3).name;
    splited = regexp(Folders_inside, '_', 'split');
    subject_name(i) = cellstr(strcat('\',char(splited(1))));
end

% save data files
for i = 1:length
    xlswrite(strcat(save_dir,'\',char(subject_name(i)),'.xlsx'),...
        getArray_actual(char(dir_result(i)), char(subject_name(i))));
end

clc
clear

