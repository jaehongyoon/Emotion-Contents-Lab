% This program caculates normailty of given distribution.
% if each group does not follow noramilty, then non-parametric test is 
% performed for 2-way test. If follow normailty, we apply 2-way ANOVA.
% 
% Author: Jaehong Yoon
% Date: 20140826
% 
% Do not use for commerical reasons

clc
clear

%% Read Excel File
Negative_Latency   = xlsread('Negative_Latency_犁备己.xlsx');
Negative_Amplitude = xlsread('Negative_Amplitude_犁备己.xlsx');
Positive_Latency   = xlsread('Positive_Latency_犁备己.xlsx');
Positive_Amplitude = xlsread('Positive_Amplitude_犁备己.xlsx');

%% set basic matrix
%Matrix naming: N/P(negative or positive)_L/A(Latency or Amplitude)_...
%W/I(Word or Icon)_150/300/500(ISI number)

N_L_W_150 = []; N_L_I_150 = []; P_L_W_150 = []; P_L_I_150 = [];
N_L_W_300 = []; N_L_I_300 = []; P_L_W_300 = []; P_L_I_300 = [];
N_L_W_500 = []; N_L_I_500 = []; P_L_W_500 = []; P_L_I_500 = [];
N_A_W_150 = []; N_A_I_150 = []; P_A_W_150 = []; P_A_I_150 = [];
N_A_W_300 = []; N_A_I_300 = []; P_A_W_300 = []; P_A_I_300 = [];
N_A_W_500 = []; N_A_I_500 = []; P_A_W_500 = []; P_A_I_500 = [];

%% Divide Arrays

[row column] = size(Negative_Latency);

for i = 1:row
    if Negative_Latency(i, 1) == 150
        if Negative_Latency(i, 2) == 1
             N_L_I_150(end+1) = Negative_Latency(i,3);
        else N_L_W_150(end+1) = Negative_Latency(i,3);
        end
    elseif Negative_Latency(i, 1) == 300
        if Negative_Latency(i, 2) == 1
             N_L_I_300(end+1) = Negative_Latency(i,3);
        else N_L_W_300(end+1) = Negative_Latency(i,3);
        end
    else
        if Negative_Latency(i, 2) == 1
             N_L_I_500(end+1) = Negative_Latency(i,3);
        else N_L_W_500(end+1) = Negative_Latency(i,3);
        end
    end    
end

for i = 1:row
    if Negative_Amplitude(i, 1) == 150
        if Negative_Amplitude(i, 2) == 1
             N_A_I_150(end+1) = Negative_Amplitude(i,3);
        else N_A_W_150(end+1) = Negative_Amplitude(i,3);
        end
    elseif Negative_Amplitude(i, 1) == 300
        if Negative_Amplitude(i, 2) == 1
             N_A_I_300(end+1) = Negative_Amplitude(i,3);
        else N_A_W_300(end+1) = Negative_Amplitude(i,3);
        end
    else
        if Negative_Amplitude(i, 2) == 1
             N_A_I_500(end+1) = Negative_Amplitude(i,3);
        else N_A_W_500(end+1) = Negative_Amplitude(i,3);
        end
    end    
end

for i = 1:row
    if Positive_Latency(i, 1) == 150
        if Positive_Latency(i, 2) == 1
             P_L_I_150(end+1) = Positive_Latency(i,3);
        else P_L_W_150(end+1) = Positive_Latency(i,3);
        end
    elseif Positive_Latency(i, 1) == 300
        if Positive_Latency(i, 2) == 1
             P_L_I_300(end+1) = Positive_Latency(i,3);
        else P_L_W_300(end+1) = Positive_Latency(i,3);
        end
    else
        if Positive_Latency(i, 2) == 1
             P_L_I_500(end+1) = Positive_Latency(i,3);
        else P_L_W_500(end+1) = Positive_Latency(i,3);
        end
    end    
end

for i = 1:row
    if Positive_Amplitude(i, 1) == 150
        if Positive_Amplitude(i, 2) == 1
             P_A_I_150(end+1) = Positive_Amplitude(i,3);
        else P_A_W_150(end+1) = Positive_Amplitude(i,3);
        end
    elseif Positive_Amplitude(i, 1) == 300
        if Positive_Amplitude(i, 2) == 1
             P_A_I_300(end+1) = Positive_Amplitude(i,3);
        else P_A_W_300(end+1) = Positive_Amplitude(i,3);
        end
    else
        if Positive_Amplitude(i, 2) == 1
             P_A_I_500(end+1) = Positive_Amplitude(i,3);
        else P_A_W_500(end+1) = Positive_Amplitude(i,3);
        end
    end    
end

%% test normality of each group

[h_NLI150, p_NLI150] = kstest(N_L_I_150);
[h_NLI300, p_NLI300] = kstest(N_L_I_300);
[h_NLI500, p_NLI500] = kstest(N_L_I_500);
[h_NLW150, p_NLW150] = kstest(N_L_W_150);
[h_NLW300, p_NLW300] = kstest(N_L_W_300);
[h_NLW500, p_NLW500] = kstest(N_L_W_500);

[h_NAI150, p_NAI150] = kstest(N_A_I_150);
[h_NAI300, p_NAI300] = kstest(N_A_I_300);
[h_NAI500, p_NAI500] = kstest(N_A_I_500);
[h_NAW150, p_NAW150] = kstest(N_A_W_150);
[h_NAW300, p_NAW300] = kstest(N_A_W_300);
[h_NAW500, p_NAW500] = kstest(N_A_W_500);

[h_PLI150, p_PLI150] = kstest(P_L_I_150);
[h_PLI300, p_PLI300] = kstest(P_L_I_300);
[h_PLI500, p_PLI500] = kstest(P_L_I_500);
[h_PLW150, p_PLW150] = kstest(P_L_W_150);
[h_PLW300, p_PLW300] = kstest(P_L_W_300);
[h_PLW500, p_PLW500] = kstest(P_L_W_500);

[h_PAI150, p_PAI150] = kstest(P_A_I_150);
[h_PAI300, p_PAI300] = kstest(P_A_I_300);
[h_PAI500, p_PAI500] = kstest(P_A_I_500);
[h_PAW150, p_PAW150] = kstest(P_A_W_150);
[h_PAW300, p_PAW300] = kstest(P_A_W_300);
[h_PAW500, p_PAW500] = kstest(P_A_W_500);

%% report
fprintf('\n Negative Latency Icon 150ms p-value: %d \n',p_NLI150);
fprintf('\n Negative Latency Icon 300ms p-value: %d \n',p_NLI300);
fprintf('\n Negative Latency Icon 500ms p-value: %d \n',p_NLI500);
fprintf('\n Negative Latency Word 150ms p-value: %d \n',p_NLW150);
fprintf('\n Negative Latency Word 300ms p-value: %d \n',p_NLW300);
fprintf('\n Negative Latency Word 500ms p-value: %d \n',p_NLW500);

fprintf('\n Negative Amplitude Icon 150ms p-value: %d \n',p_NAI150);
fprintf('\n Negative Amplitude Icon 300ms p-value: %d \n',p_NAI300);
fprintf('\n Negative Amplitude Icon 500ms p-value: %d \n',p_NAI500);
fprintf('\n Negative Amplitude Word 150ms p-value: %d \n',p_NAW150);
fprintf('\n Negative Amplitude Word 300ms p-value: %d \n',p_NAW300);
fprintf('\n Negative Amplitude Word 500ms p-value: %d \n',p_NAW500);

fprintf('\n Positive Latency Icon 150ms p-value: %d \n',p_PLI150);
fprintf('\n Positive Latency Icon 300ms p-value: %d \n',p_PLI300);
fprintf('\n Positive Latency Icon 500ms p-value: %d \n',p_PLI500);
fprintf('\n Positive Latency Word 150ms p-value: %d \n',p_PLW150);
fprintf('\n Positive Latency Word 300ms p-value: %d \n',p_PLW300);
fprintf('\n Positive Latency Word 500ms p-value: %d \n',p_PLW500);

fprintf('\n Positive Amplitude Icon 150ms p-value: %d \n',p_PAI150);
fprintf('\n Positive Amplitude Icon 300ms p-value: %d \n',p_PAI300);
fprintf('\n Positive Amplitude Icon 500ms p-value: %d \n',p_PAI500);
fprintf('\n Positive Amplitude Word 150ms p-value: %d \n',p_PAW150);
fprintf('\n Positive Amplitude Word 300ms p-value: %d \n',p_PAW300);
fprintf('\n Positive Amplitude Word 500ms p-value: %d \n',p_PAW500);

%% non-parametric test

%result shows that for all group normality assumption fails. Therefore
%non-parametric 2-way test will be applied
%we apply Friedman's test
%reference:http://www-rohan.sdsu.edu/doc/matlab/toolbox/stats/linear25.html

%rearrange matrix

Negative_Latency   = Negative_Latency(:,3);
Negative_Amplitude = Negative_Amplitude(:,3);
Positive_Latency   = Positive_Latency(:,3);
Positive_Amplitude = Positive_Amplitude(:,3);

NL_reshape = reshape(Negative_Latency,[3,2,36]);
NA_reshape = reshape(Negative_Amplitude,[3,2,36]);
PL_reshape = reshape(Positive_Latency,[3,2,36]);
PA_reshape = reshape(Positive_Amplitude,[3,2,36]);

NL_reshape = permute(NL_reshape, [2 3 1]);
NA_reshape = permute(NA_reshape, [2 3 1]);
PL_reshape = permute(PL_reshape, [2 3 1]);
PA_reshape = permute(PA_reshape, [2 3 1]);

NL_reshape = reshape(Negative_Latency,[108,2]);
NA_reshape = reshape(Negative_Amplitude,[108,2]);
PL_reshape = reshape(Positive_Latency,[108,2]);
PA_reshape = reshape(Positive_Amplitude,[108,2]);

NL_P_Val = friedman(NL_reshape, 3);
NA_P_Val = friedman(NA_reshape, 3);
PL_P_Val = friedman(PL_reshape, 3);
PA_P_Val = friedman(PA_reshape, 3);


















