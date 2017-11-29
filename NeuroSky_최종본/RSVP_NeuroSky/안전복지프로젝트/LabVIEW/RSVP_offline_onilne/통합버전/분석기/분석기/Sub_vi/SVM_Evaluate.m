
clc
% clear

%addpath to the libsvm toolbox
addpath('C:\Users\Server\Desktop\NeuroSky\RSVP_NeuroSky\libsvm-3.18\matlab');

%addpath to data
dirData_training = uigetdir('C:\Emotion_Research', 'select training path');
dirData_online = uigetdir('C:\Emotion_Research', 'select online path');
addpath(dirData_training);
addpath(dirData_online);

%read data set(training)
target = load('ERP_Parameters_of_Target_prior.txt');
nontarget = load('ERP_Parameters_of_NonTarget_prior.txt');
% SWLDA = load('in_SWLDA.txt');
% weight = SWLDA(1,:)';
% nonzeros = find(weight, 4);

target = reshape(target', 4, 12);
% target = target.*weight(:,ones(1,12));
% target = target(nonzeros,:);
nontarget = reshape(nontarget', 4, 12);
% nontarget = nontarget.*weight(:,ones(1,12));
% nontarget = nontarget(nonzeros,:);
EEG_train = [target';nontarget']';
length = size(target,2);
trainLabel = [ones(length,1);-ones(length, 1)];

%read data set(online)
data = load('ERP_all_icon.txt');
target_order = load('Target_order.txt');
%reshape
data = reshape(data, 4, 72);
%transpose
data = data(1:4,:);
% data = data.*weight(:,ones(1,72));
% data = data(nonzeros,:);
data = data';

OS = size(data, 1);
%make range 1~6
target_order = target_order+1;
P = size(target_order,1);
target_label = zeros(P,1);
%set label information
for i = 1:P
    target_label(i) = target_order(i)+(i-1)*6;
end
%Determine the online target, non_target index
onlineLabel = -ones(OS,1); onlineLabel(target_label) = 1;

% Train the SVM
model = svmtrain(trainLabel, [(1:24)' EEG_train'*EEG_train], '-c 1 -g 0.07 -b 1 -t 4 -q');

%use the SVM model to classifty the data
[predict_label, accuracy, prob_values] = ...
    svmpredict(onlineLabel, [(1:72)' data*EEG_train], model, '-b 1');

% save model file
% svm_savemodel(model,'C:\Emotion_Research\ÀÌµ¿¿ø_SWLDA_Offline_Analysis2\2014-02-25\swsvm.model');

occurance = zeros(72,1);
for i = 1:72
    if (prob_values(i) >= 0.5)
        occurance(i) = 1;
    else
         occurance(i) = 0;
    end
end


