function sorted = getArray_actual(dir_train, name)
%% paths
FLDA = strcat(dir_train, name, '_FLDA');
BLDA = strcat(dir_train,name, '_BLDA');
SVM  = strcat(dir_train,name, '_SVM');
SWLDA= strcat(dir_train,name, '_SWLDA');
SWSVM = strcat(dir_train,name, '_SWSVM');


%% read data

% target
target = load(strcat(FLDA, '\Target_Total.txt'));

%FDLA
FLDA_ERP_num   = load(strcat(FLDA, '\ERP_¹ß»ý_ÃÑÈ½¼ö.txt'));
FLDA_ERP_total = load(strcat(FLDA, '\ERP_¹ß»ý_total.txt'));
FLDA_matrix = load(strcat(FLDA, '\FLDA_hyperplane_value.txt'));
FLDA_selected = load(strcat(FLDA, '\Selected_Total.txt'));
length = size(FLDA_ERP_num, 1);

%BDLA
BLDA_ERP_num   = load(strcat(BLDA, '\ERP_¹ß»ý_ÃÑÈ½¼ö.txt'));
BLDA_ERP_total = load(strcat(BLDA, '\ERP_¹ß»ý_total.txt'));
BLDA_matrix = load(strcat(BLDA, '\BLDA_hyperplane_value.txt'));
BLDA_selected = load(strcat(BLDA, '\Selected_Total.txt'));

%SVM
SVM_ERP_total = load(strcat(SVM, '\ERP_¹ß»ý_total.txt'));
SVM_decision = load(strcat(SVM, '\decision.txt'));
SVM_selected = load(strcat(SVM, '\Selected_Total.txt'));

%SWLDA
SWLDA_total = ...
    load(strcat(SWLDA, '\ERP_¹ß»ý_total.txt'));
SWLDA_matrix = ...
    load(strcat(SWLDA, '\SWLDA_hyperplane_value.txt'));
SWLDA_selected = ...
    load(strcat(SWLDA, '\Selected_Total.txt'));

%SWSVM
SWSVM_total = ...
    load(strcat(SWSVM, '\ERP_¹ß»ý_total.txt'));
SWSVM_decision = ...
    load(strcat(SWSVM, '\decision.txt'));
SWSVM_matrix = ...
    load(strcat(SWSVM, '\SWLDA_hyperplane_value.txt'));
SWSVM_selected = ...
    load(strcat(SWSVM, '\Selected_Total.txt'));


%% reorder those array of length 24
target_revision = zeros(length,1);
FLDA_selected_revision = zeros(length,1);
BLDA_selected_revision = zeros(length,1);
SVM_selected_revision = zeros(length,1);
SWLDA_selected_revision = zeros(length,1);
SWSVM_selected_revision = zeros(length,1);

for i = 1:length
    if (mod(i,6) == 1)
        target_revision(i) = target(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        FLDA_selected_revision(i) = FLDA_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        BLDA_selected_revision(i) = BLDA_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SVM_selected_revision(i) = SVM_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWLDA_selected_revision(i) = SWLDA_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_selected_revision(i) = SWSVM_selected(fix(i/6)+1);
    end        
end

%% re-organize flda matrix
FLDA_matrix_revision = zeros(length,1);
num1 = 1;
num2 = 6;
for i = 1:length/6
    start = (i-1)*6+1;
    ending = i*6;
    part_FLDA = FLDA_ERP_total(start:ending);
    if(sum(part_FLDA) == 1)
        FLDA_matrix_revision(start:ending) = [NaN NaN NaN NaN NaN NaN];
    else
        FLDA_matrix_revision(start:ending) = FLDA_matrix(num1:num2);
        num1 = num1+6;
        num2 = num2+6;
    end
end


%% sort
sorted = [target_revision, FLDA_ERP_num, FLDA_ERP_total, FLDA_matrix_revision,...
FLDA_selected_revision, BLDA_ERP_num, BLDA_ERP_total, BLDA_matrix,...
BLDA_selected_revision, SVM_ERP_total, SVM_decision, SVM_selected_revision,...
SWLDA_total, SWLDA_matrix, ...
SWLDA_selected_revision, ...
SWSVM_total, ...
SWSVM_decision, SWSVM_matrix, ...
SWSVM_selected_revision];

