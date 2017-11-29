function sorted = getArray(dir_train, name)
%% paths
FLDA = strcat(dir_train, name, '_FLDA');
BLDA = strcat(dir_train,name, '_BLDA');
SVM  = strcat(dir_train,name, '_SVM');
SWLDA_LDA_pe001pr005 = strcat(dir_train,name, '_SWLDA_LDA_pe001pr005');
SWLDA_LDA_pe01pr02 = strcat(dir_train,name, '_SWLDA_LDA_pe01pr02');
SWLDA_LDA_pe005pr01 = strcat(dir_train,name, '_SWLDA_LDA_pe005pr01');
SWSVM_LDA_pe001pr005 = strcat(dir_train,name, '_SWSVM_LDA_pe001pr005');
SWSVM_LDA_pe01pr02 = strcat(dir_train,name, '_SWSVM_LDA_pe01pr02');
SWSVM_LDA_pe005pr01 = strcat(dir_train,name, '_SWSVM_LDA_pe005pr01');
SWSVM_in_pe001pr005 = strcat(dir_train,name, '_SWSVM_in_pe001pr005');
SWSVM_in_pe01pr02 = strcat(dir_train,name, '_SWSVM_in_pe01pr02');
SWSVM_in_pe005pr01 = strcat(dir_train,name, '_SWSVM_in_pe005pr01');
SWSVM_New_LDA_pe001pr005 = strcat(dir_train,name, '_SWSVM_New_LDA_pe001pr005');
SWSVM_New_LDA_pe01pr02 = strcat(dir_train,name, '_SWSVM_New_LDA_pe01pr02');
SWSVM_New_LDA_pe005pr01 = strcat(dir_train,name, '_SWSVM_New_LDA_pe005pr01');
SWSVM_New_in_pe001pr005 = strcat(dir_train,name, '_SWSVM_New_in_pe001pr005');
SWSVM_New_in_pe01pr02 = strcat(dir_train,name, '_SWSVM_New_in_pe01pr02');
SWSVM_New_in_pe005pr01 = strcat(dir_train,name, '_SWSVM_New_in_pe005pr01');

%% read data

% target
target = load(strcat(FLDA, '\Target_Total.txt'));

%FDLA
FLDA_ERP_num   = load(strcat(FLDA, '\ERP_발생_총횟수.txt'));
FLDA_ERP_total = load(strcat(FLDA, '\ERP_발생_total.txt'));
FLDA_matrix = load(strcat(FLDA, '\FLDA_hyperplane_value.txt'));
FLDA_selected = load(strcat(FLDA, '\Selected_Total.txt'));
length = size(FLDA_ERP_num, 1);

%BDLA
BLDA_ERP_num   = load(strcat(BLDA, '\ERP_발생_총횟수.txt'));
BLDA_ERP_total = load(strcat(BLDA, '\ERP_발생_total.txt'));
BLDA_matrix = load(strcat(BLDA, '\BLDA_hyperplane_value.txt'));
BLDA_selected = load(strcat(BLDA, '\Selected_Total.txt'));

%SVM
SVM_ERP_total = load(strcat(SVM, '\ERP_발생_total.txt'));
SVM_decision = load(strcat(SVM, '\decision.txt'));
SVM_selected = load(strcat(SVM, '\Selected_Total.txt'));

%SWLDA_LDA_pe001pr005
SWLDA_LDA_pe001pr005_ERP_total = ...
    load(strcat(SWLDA_LDA_pe001pr005, '\ERP_발생_total.txt'));
SWLDA_LDA_pe001pr005_matrix = ...
    load(strcat(SWLDA_LDA_pe001pr005, '\SWLDA_hyperplane_value.txt'));
SWLDA_LDA_pe001pr005_selected = ...
    load(strcat(SWLDA_LDA_pe001pr005, '\Selected_Total.txt'));

%SWLDA_LDA_pe01pr02
SWLDA_LDA_pe01pr02_ERP_total = ...
    load(strcat(SWLDA_LDA_pe01pr02, '\ERP_발생_total.txt'));
SWLDA_LDA_pe01pr02_matrix = ...
    load(strcat(SWLDA_LDA_pe01pr02, '\SWLDA_hyperplane_value.txt'));
SWLDA_LDA_pe01pr02_selected = ...
    load(strcat(SWLDA_LDA_pe01pr02, '\Selected_Total.txt'));

%SWLDA_LDA_pe005pr01
SWLDA_LDA_pe005pr01_ERP_total = ...
    load(strcat(SWLDA_LDA_pe005pr01, '\ERP_발생_total.txt'));
SWLDA_LDA_pe005pr01_matrix = ...
    load(strcat(SWLDA_LDA_pe005pr01, '\SWLDA_hyperplane_value.txt'));
SWLDA_LDA_pe005pr01_selected = ...
    load(strcat(SWLDA_LDA_pe005pr01, '\Selected_Total.txt'));

%SWSVM_in_pe001pr005
SWSVM_in_pe001pr005_ERP_total = ...
    load(strcat(SWSVM_in_pe001pr005, '\ERP_발생_total.txt'));
SWSVM_in_pe001pr005_ERP_decision = ...
    load(strcat(SWSVM_in_pe001pr005, '\decision.txt'));
SWSVM_in_pe001pr005_matrix = ...
    load(strcat(SWSVM_in_pe001pr005, '\SWLDA_hyperplane_value.txt'));
SWSVM_in_pe001pr005_selected = ...
    load(strcat(SWSVM_in_pe001pr005, '\Selected_Total.txt'));

%SWSVM_in_pe01pr02
SWSVM_in_pe01pr02_ERP_total = ...
    load(strcat(SWSVM_in_pe01pr02, '\ERP_발생_total.txt'));
SWSVM_in_pe01pr02_ERP_decision = ...
    load(strcat(SWSVM_in_pe01pr02, '\decision.txt'));
SWSVM_in_pe01pr02_matrix = ...
    load(strcat(SWSVM_in_pe01pr02, '\SWLDA_hyperplane_value.txt'));
SWSVM_in_pe01pr02_selected = ...
    load(strcat(SWSVM_in_pe01pr02, '\Selected_Total.txt'));

%SWSVM_in_pe005pr01
SWSVM_in_pe005pr01_ERP_total = ...
    load(strcat(SWSVM_in_pe005pr01, '\ERP_발생_total.txt'));
SWSVM_in_pe005pr01_ERP_decision = ...
    load(strcat(SWSVM_in_pe005pr01, '\decision.txt'));
SWSVM_in_pe005pr01_matrix = ...
    load(strcat(SWSVM_in_pe005pr01, '\SWLDA_hyperplane_value.txt'));
SWSVM_in_pe005pr01_selected = ...
    load(strcat(SWSVM_in_pe005pr01, '\Selected_Total.txt'));

%SWSVM_LDA_pe001pr005
SWSVM_LDA_pe001pr005_ERP_total = ...
    load(strcat(SWSVM_LDA_pe001pr005, '\ERP_발생_total.txt'));
SWSVM_LDA_pe001pr005_ERP_decision = ...
    load(strcat(SWSVM_LDA_pe001pr005, '\decision.txt'));
SWSVM_LDA_pe001pr005_matrix = ...
    load(strcat(SWSVM_LDA_pe001pr005, '\SWLDA_hyperplane_value.txt'));
SWSVM_LDA_pe001pr005_selected = ...
    load(strcat(SWSVM_LDA_pe001pr005, '\Selected_Total.txt'));

%SWSVM_LDA_pe01pr02
SWSVM_LDA_pe01pr02_ERP_total = ...
    load(strcat(SWSVM_LDA_pe01pr02, '\ERP_발생_total.txt'));
SWSVM_LDA_pe01pr02_ERP_decision = ...
    load(strcat(SWSVM_LDA_pe01pr02, '\decision.txt'));
SWSVM_LDA_pe01pr02_matrix = ...
    load(strcat(SWSVM_LDA_pe01pr02, '\SWLDA_hyperplane_value.txt'));
SWSVM_LDA_pe01pr02_selected = ...
    load(strcat(SWSVM_LDA_pe01pr02, '\Selected_Total.txt'));

%SWSVM_LDA_pe005pr01
SWSVM_LDA_pe005pr01_ERP_total = ...
    load(strcat(SWSVM_LDA_pe005pr01, '\ERP_발생_total.txt'));
SWSVM_LDA_pe005pr01_ERP_decision = ...
    load(strcat(SWSVM_LDA_pe005pr01, '\decision.txt'));
SWSVM_LDA_pe005pr01_matrix = ...
    load(strcat(SWSVM_LDA_pe005pr01, '\SWLDA_hyperplane_value.txt'));
SWSVM_LDA_pe005pr01_selected = ...
    load(strcat(SWSVM_LDA_pe005pr01, '\Selected_Total.txt'));

%SWSVM_New_in_pe001pr005
SWSVM_New_in_pe001pr005_ERP_total = ...
    load(strcat(SWSVM_New_in_pe001pr005, '\ERP_발생_total.txt'));
SWSVM_New_in_pe001pr005_ERP_decision = ...
    load(strcat(SWSVM_New_in_pe001pr005, '\decision.txt'));
SWSVM_New_in_pe001pr005_matrix = ...
    load(strcat(SWSVM_New_in_pe001pr005, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_in_pe001pr005_selected = ...
    load(strcat(SWSVM_New_in_pe001pr005, '\Selected_Total.txt'));

%SWSVM_New_in_pe01pr02
SWSVM_New_in_pe01pr02_ERP_total = ...
    load(strcat(SWSVM_New_in_pe01pr02, '\ERP_발생_total.txt'));
SWSVM_New_in_pe01pr02_ERP_decision = ...
    load(strcat(SWSVM_New_in_pe01pr02, '\decision.txt'));
SWSVM_New_in_pe01pr02_matrix = ...
    load(strcat(SWSVM_New_in_pe01pr02, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_in_pe01pr02_selected = ...
    load(strcat(SWSVM_New_in_pe01pr02, '\Selected_Total.txt'));

%SWSVM_New_in_pe005pr01
SWSVM_New_in_pe005pr01_ERP_total = ...
    load(strcat(SWSVM_New_in_pe005pr01, '\ERP_발생_total.txt'));
SWSVM_New_in_pe005pr01_ERP_decision = ...
    load(strcat(SWSVM_New_in_pe005pr01, '\decision.txt'));
SWSVM_New_in_pe005pr01_matrix = ...
    load(strcat(SWSVM_New_in_pe005pr01, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_in_pe005pr01_selected = ...
    load(strcat(SWSVM_New_in_pe005pr01, '\Selected_Total.txt'));

%SWSVM_New_LDA_pe001pr005
SWSVM_New_LDA_pe001pr005_ERP_total = ...
    load(strcat(SWSVM_New_LDA_pe001pr005, '\ERP_발생_total.txt'));
SWSVM_New_LDA_pe001pr005_ERP_decision = ...
    load(strcat(SWSVM_New_LDA_pe001pr005, '\decision.txt'));
SWSVM_New_LDA_pe001pr005_matrix = ...
    load(strcat(SWSVM_New_LDA_pe001pr005, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_LDA_pe001pr005_selected = ...
    load(strcat(SWSVM_New_LDA_pe001pr005, '\Selected_Total.txt'));

%SWSVM_New_LDA_pe01pr02
SWSVM_New_LDA_pe01pr02_ERP_total = ...
    load(strcat(SWSVM_New_LDA_pe01pr02, '\ERP_발생_total.txt'));
SWSVM_New_LDA_pe01pr02_ERP_decision = ...
    load(strcat(SWSVM_New_LDA_pe01pr02, '\decision.txt'));
SWSVM_New_LDA_pe01pr02_matrix = ...
    load(strcat(SWSVM_New_LDA_pe01pr02, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_LDA_pe01pr02_selected = ...
    load(strcat(SWSVM_New_LDA_pe01pr02, '\Selected_Total.txt'));

%SWSVM_New_LDA_pe005pr01
SWSVM_New_LDA_pe005pr01_ERP_total = ...
    load(strcat(SWSVM_New_LDA_pe005pr01, '\ERP_발생_total.txt'));
SWSVM_New_LDA_pe005pr01_ERP_decision = ...
    load(strcat(SWSVM_New_LDA_pe005pr01, '\decision.txt'));
SWSVM_New_LDA_pe005pr01_matrix = ...
    load(strcat(SWSVM_New_LDA_pe005pr01, '\SWLDA_hyperplane_value.txt'));
SWSVM_New_LDA_pe005pr01_selected = ...
    load(strcat(SWSVM_New_LDA_pe005pr01, '\Selected_Total.txt'));

%% reorder those array of length 24
target_revision = zeros(length,1);
FLDA_selected_revision = zeros(length,1);
BLDA_selected_revision = zeros(length,1);
SVM_selected_revision = zeros(length,1);
SWLDA_LDA_pe001pr005_selected_revision = zeros(length,1);
SWLDA_LDA_pe01pr02_selected_revision = zeros(length,1);
SWLDA_LDA_pe005pr01_selected_revision = zeros(length,1);
SWSVM_in_pe001pr005_selected_revision = zeros(length,1);
SWSVM_in_pe01pr02_selected_revision = zeros(length,1);
SWSVM_in_pe005pr01_selected_revision = zeros(length,1);
SWSVM_LDA_pe001pr005_selected_revision = zeros(length,1);
SWSVM_LDA_pe01pr02_selected_revision = zeros(length,1);
SWSVM_LDA_pe005pr01_selected_revision = zeros(length,1);
SWSVM_New_in_pe001pr005_selected_revision = zeros(length,1);
SWSVM_New_in_pe01pr02_selected_revision = zeros(length,1);
SWSVM_New_in_pe005pr01_selected_revision = zeros(length,1);
SWSVM_New_LDA_pe001pr005_selected_revision = zeros(length,1);
SWSVM_New_LDA_pe01pr02_selected_revision = zeros(length,1);
SWSVM_New_LDA_pe005pr01_selected_revision = zeros(length,1);

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
        SWLDA_LDA_pe001pr005_selected_revision(i) = SWLDA_LDA_pe001pr005_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWLDA_LDA_pe01pr02_selected_revision(i) = SWLDA_LDA_pe01pr02_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWLDA_LDA_pe005pr01_selected_revision(i) = SWLDA_LDA_pe005pr01_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_in_pe001pr005_selected_revision(i) = SWSVM_in_pe001pr005_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_in_pe01pr02_selected_revision(i) = SWSVM_in_pe01pr02_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_in_pe005pr01_selected_revision(i) = SWSVM_in_pe005pr01_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_LDA_pe001pr005_selected_revision(i) = SWSVM_LDA_pe001pr005_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_LDA_pe01pr02_selected_revision(i) = SWSVM_LDA_pe01pr02_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_LDA_pe005pr01_selected_revision(i) = SWSVM_LDA_pe005pr01_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_in_pe001pr005_selected_revision(i) = SWSVM_New_in_pe001pr005_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_in_pe01pr02_selected_revision(i) = SWSVM_New_in_pe01pr02_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_in_pe005pr01_selected_revision(i) = SWSVM_New_in_pe005pr01_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_LDA_pe001pr005_selected_revision(i) = SWSVM_New_LDA_pe001pr005_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_LDA_pe01pr02_selected_revision(i) = SWSVM_New_LDA_pe01pr02_selected(fix(i/6)+1);
    end        
end

for i = 1:length
    if (mod(i,6) == 1)
        SWSVM_New_LDA_pe005pr01_selected_revision(i) = SWSVM_New_LDA_pe005pr01_selected(fix(i/6)+1);
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
SWLDA_LDA_pe001pr005_ERP_total, SWLDA_LDA_pe001pr005_matrix, ...
SWLDA_LDA_pe001pr005_selected_revision, SWLDA_LDA_pe01pr02_ERP_total,...
SWLDA_LDA_pe01pr02_matrix, SWLDA_LDA_pe01pr02_selected_revision, ...
SWLDA_LDA_pe005pr01_ERP_total, SWLDA_LDA_pe005pr01_matrix, ...
SWLDA_LDA_pe005pr01_selected_revision, SWSVM_in_pe001pr005_ERP_total,...
SWSVM_in_pe001pr005_ERP_decision, SWSVM_in_pe001pr005_matrix, ...
SWSVM_in_pe001pr005_selected_revision, SWSVM_in_pe01pr02_ERP_total, ...
SWSVM_in_pe01pr02_ERP_decision, SWSVM_in_pe01pr02_matrix, ...
SWSVM_in_pe01pr02_selected_revision, SWSVM_in_pe005pr01_ERP_total, ...
SWSVM_in_pe005pr01_ERP_decision, SWSVM_in_pe005pr01_matrix, ...
SWSVM_in_pe005pr01_selected_revision, SWSVM_LDA_pe001pr005_ERP_total, ...
SWSVM_LDA_pe001pr005_ERP_decision, SWSVM_LDA_pe001pr005_matrix, ...
SWSVM_LDA_pe001pr005_selected_revision, SWSVM_LDA_pe01pr02_ERP_total, ...
SWSVM_LDA_pe01pr02_ERP_decision, SWSVM_LDA_pe01pr02_matrix, ...
SWSVM_LDA_pe01pr02_selected_revision, SWSVM_LDA_pe005pr01_ERP_total, ...
SWSVM_LDA_pe005pr01_ERP_decision, SWSVM_LDA_pe005pr01_matrix, ...
SWSVM_LDA_pe005pr01_selected_revision, SWSVM_New_in_pe001pr005_ERP_total,...
SWSVM_New_in_pe001pr005_ERP_decision, SWSVM_New_in_pe001pr005_matrix,...
SWSVM_New_in_pe001pr005_selected_revision,SWSVM_New_in_pe01pr02_ERP_total, ...
SWSVM_New_in_pe01pr02_ERP_decision,SWSVM_New_in_pe01pr02_matrix,...
SWSVM_New_in_pe01pr02_selected_revision,SWSVM_New_in_pe005pr01_ERP_total,...
SWSVM_New_in_pe005pr01_ERP_decision,SWSVM_New_in_pe005pr01_matrix,...
SWSVM_New_in_pe005pr01_selected_revision,SWSVM_New_LDA_pe001pr005_ERP_total, ...
SWSVM_New_LDA_pe001pr005_ERP_decision, SWSVM_New_LDA_pe001pr005_matrix,...
SWSVM_New_LDA_pe001pr005_selected_revision, SWSVM_New_LDA_pe01pr02_ERP_total, ...
SWSVM_New_LDA_pe01pr02_ERP_decision,SWSVM_New_LDA_pe01pr02_matrix,...
SWSVM_New_LDA_pe01pr02_selected_revision,SWSVM_New_LDA_pe005pr01_ERP_total,...
SWSVM_New_LDA_pe005pr01_ERP_decision,SWSVM_New_LDA_pe005pr01_matrix,...
SWSVM_New_LDA_pe005pr01_selected_revision];
