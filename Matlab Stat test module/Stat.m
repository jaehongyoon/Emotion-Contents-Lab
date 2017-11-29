clc
clear

%% Read Data

% read data (TP, TP_FP)
TP     = xlsread('RSVP_TP.xlsx');
TP_FP  = xlsread('RSVP_TP_FP.xlsx');

%% TP Analysis

TP_FLDA   = TP(1,:);
TP_BLDA   = TP(2,:);
TP_SWLDA  = TP(3,:);
TP_SVM    = TP(4,:);
TP_SVM_SW = TP(5,:);

TP_FLDA_hist    = hist(TP_FLDA,  linspace(0,100,20));
TP_BLDA_hist    = hist(TP_BLDA,  linspace(0,100,20));
TP_SWLDA_hist   = hist(TP_SWLDA, linspace(0,100,20));
TP_SVM_hist     = hist(TP_SVM,   linspace(0,100,20));
TP_SVM_SW_hist  = hist(TP_SVM_SW,linspace(0,100,20));

% histogram plot for each TP for different LDAs
figure(1)
subplot(3,2,1)
bar(linspace(0,100,20), TP_FLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of FLDA')
subplot(3,2,2)
bar(linspace(0,100,20), TP_BLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of BLDA')
subplot(3,2,3)
bar(linspace(0,100,20), TP_SWLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SWLDA')
subplot(3,2,4)
bar(linspace(0,100,20), TP_SVM_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SVM')
subplot(3,2,5)
bar(linspace(0,100,20), TP_SVM_SW_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SVM + SWLDA')

% test normality
[h_1, p_1] = kstest((TP_FLDA-mean(TP_FLDA))./std(TP_FLDA));
[h_2, p_2] = kstest((TP_BLDA-mean(TP_BLDA))./std(TP_BLDA));
[h_3, p_3] = kstest((TP_SWLDA-mean(TP_SWLDA))./std(TP_SWLDA));
[h_4, p_4] = kstest((TP_SVM-mean(TP_SVM))./std(TP_SVM));
[h_5, p_5] = kstest((TP_SVM_SW-mean(TP_SVM_SW))./std(TP_SVM_SW));

% h = 0 for all, follow normality assumption
X = [TP_FLDA; TP_BLDA; TP_SWLDA; TP_SVM; TP_SVM_SW];
group = ['FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';
        'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';
        'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';
        'SVM      ';'SVM      ';'SVM      ';'SVM      ';'SVM      ';'SVM      ';
        'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA'];
[P,ANOVATAB,STATS] = anova1(X, group);
% p > .05
% use student-t-test to do post hoc
[h1  p1 ] = ttest2(TP_FLDA,  TP_BLDA  );
[h2  p2 ] = ttest2(TP_FLDA,  TP_SWLDA );
[h3  p3 ] = ttest2(TP_FLDA,  TP_SVM   );
[h4  p4 ] = ttest2(TP_FLDA,  TP_SVM_SW);
[h5  p5 ]  = ttest2(TP_BLDA,  TP_SWLDA );
[h6  p6 ]  = ttest2(TP_BLDA,  TP_SVM   );
[h7  p7 ]  = ttest2(TP_BLDA,  TP_SVM_SW);
[h8  p8 ]  = ttest2(TP_SWLDA, TP_SVM   );
[h9  p9 ]  = ttest2(TP_SWLDA, TP_SVM_SW);
[h10 p10] = ttest2(TP_SVM,   TP_SVM_SW);



