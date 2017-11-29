clc
clear

%% set data file paths

%addpath to the libsvm toolbox
addpath('C:\Users\Server\Desktop\NeuroSky\RSVP_NeuroSky\libsvm-3.18\matlab');

% set function path
current_Folder = pwd;
dir_Func = uigetdir(pwd, 'open function m.file directory');
addpath(dir_Func);

% open data directories (training)
default_data_Folder = ...
    'C:\Emotion_Research\ABM_Analysis\ABM_Analysis_Data_150304';
dir_train = uipickfiles('filterspec', default_data_Folder,...
    'prompt','Open training data directories');
size_train = size(dir_train,2);


%% construct svm model files

% achieve svm_files for all (svm)
for i = 1:size_train
    
    %tell which data user is using
    str = char(dir_train(i));
    idx = strfind(str, '\');
    str = str(idx(4)+1:idx(5)-1);
    prompt_display = strcat('you are working on data file of subject '...
        ,str);
    disp(prompt_display);
    
    % request user for channel to discard
    discard = true;
    channels_discard = [];
    while (discard == true)
        disp('do you have channel to discard? type y/n')
        answer = input('y/n: ','s');
        if (answer == 'y')
            chan = input('select channel to discard (0~10): ', 's');
            chan = str2num(chan);
            channels_discard(end+1) = chan;        
        else    
            discard = false;
        end  
    end
    
    %load data files
    target_file_path = ...
        strcat(char(dir_train(i)),'\ERP_Parameters_of_Target_prior.txt');
    nontarget_file_path = ...
        strcat(char(dir_train(i)),'\ERP_Parameters_of_NonTarget_prior.txt');
    in_matrix_file_path = ...
        strcat(char(dir_train(i)),'\in_SWLDA.txt');
    target = load(target_file_path);
    nontarget = load(nontarget_file_path);
    SWLDA = load(in_matrix_file_path);
    
    % re-organize in_matrix data
    chan_dis_size = size(channels_discard,2);
    weight_length = 44 - 4*chan_dis_size;
    weight = SWLDA(1,1:weight_length)';
    nonzeros = find(weight, weight_length);
    
    % re-organize ERP feature data
    target = reshape(target', 44, 12);
    nontarget = reshape(nontarget', 44, 12);
    
    % discard channels
    chan_dis_size = size(channels_discard,2);
    discard_features = [];
    for j = 1:chan_dis_size
        current_num = channels_discard(j);
        starting = current_num*4+1;
        ending = (current_num+1)*4;
        discard_features(end+1:end+4) = starting:ending;
    end

    target(discard_features,:) = [];
    nontarget(discard_features,:) = [];
    
    target_in = target.*weight(:,ones(1,12));
    target_in = target_in(nonzeros,:);    
    nontarget_in = nontarget.*weight(:,ones(1,12));
    nontarget_in = nontarget_in(nonzeros,:);   
    
    % make EEG_kernel for svm
    EEG_train = [target';nontarget']';
    length = size(target,2);
    trainLabel = [ones(length,1);-ones(length, 1)];

    % make EEG_kernel for swsvm
    EEG_train_in = [target_in';nontarget_in']';

    % Train the SVM and save
    model = ...
        svmtrain(trainLabel, [(1:24)' EEG_train'*EEG_train], ...
        '-c 1 -g 0.07 -b 1 -t 4 -q');
    file_directory = strcat(char(dir_train(i)), '\svm_model.model');
    svm_savemodel(model,char(file_directory));
    
    % Train the SWSVM
    model_in = svmtrain(trainLabel, [(1:24)' EEG_train_in'*EEG_train_in],...
        '-c 1 -g 0.07 -b 1 -t 4 -q');

    %save model file
    file_directory = strcat(char(dir_train(i)), '\svm_model2.model');
    svm_savemodel(model_in,char(file_directory));
    
end
