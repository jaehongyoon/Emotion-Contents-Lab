
clc
clear

%addpath to the libsvm toolbox
addpath('C:\Users\Server\Desktop\NeuroSky\RSVP_NeuroSky\libsvm-3.18\matlab');

%addpath to data
dirData_training = uigetdir('C:\Emotion_Research', 'select training path');

addpath(dirData_training);

%read data set(training)
target = load('ERP_Parameters_of_Target_prior.txt');
nontarget = load('ERP_Parameters_of_NonTarget_prior.txt');
SWLDA = load('in_SWLDA.txt');
weight = SWLDA(1,:)';
nonzeros = find(weight, 4);

target = reshape(target', 4, 12);
target = target.*weight(:,ones(1,12));
target = target(nonzeros,:);
nontarget = reshape(nontarget', 4, 12);
nontarget = nontarget.*weight(:,ones(1,12));
nontarget = nontarget(nonzeros,:);
EEG_train = [target';nontarget']';
length = size(target,2);
trainLabel = [ones(length,1);-ones(length, 1)];
[N D] = size(EEG_train);

% Train the SVM
model = svmtrain(trainLabel, [(1:24)' EEG_train'*EEG_train], '-c 1 -g 0.07 -b 1 -t 4 -q');

%save model file
svm_savemodel(model,'C:\WORK\svm_model2.model');






