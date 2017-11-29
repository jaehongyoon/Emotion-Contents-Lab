clc
clear

%% Read Data

% read data (TP_FP, TP_FP_FP)
TP     = xlsread('RSVP_TP.xlsx');
TP_FP  = xlsread('RSVP_TP_FP.xlsx');

%% TP_FP Analysis

TP_FP_FLDA   = TP_FP(1,:);
TP_FP_BLDA   = TP_FP(2,:);
TP_FP_SWLDA  = TP_FP(3,:);
TP_FP_SVM    = TP_FP(4,:);
TP_FP_SVM_SW = TP_FP(5,:);

TP_FP_FLDA_hist    = hist(TP_FP_FLDA,  linspace(0,100,20));
TP_FP_BLDA_hist    = hist(TP_FP_BLDA,  linspace(0,100,20));
TP_FP_SWLDA_hist   = hist(TP_FP_SWLDA, linspace(0,100,20));
TP_FP_SVM_hist     = hist(TP_FP_SVM,   linspace(0,100,20));
TP_FP_SVM_SW_hist  = hist(TP_FP_SVM_SW,linspace(0,100,20));

% histogram plot for each TP_FP for different LDAs
figure(1)
subplot(3,2,1)
bar(linspace(0,100,20), TP_FP_FLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of FLDA')
subplot(3,2,2)
bar(linspace(0,100,20), TP_FP_BLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of BLDA')
subplot(3,2,3)
bar(linspace(0,100,20), TP_FP_SWLDA_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SWLDA')
subplot(3,2,4)
bar(linspace(0,100,20), TP_FP_SVM_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SVM')
subplot(3,2,5)
bar(linspace(0,100,20), TP_FP_SVM_SW_hist);
axis([-0.01 100.1 0 5])
xlabel('range')
ylabel('#')
title('histogram of SVM + SWLDA')

% test normality
[h_1, p_1] = kstest((TP_FP_FLDA-mean(TP_FP_FLDA))./std(TP_FP_FLDA));
[h_2, p_2] = kstest((TP_FP_BLDA-mean(TP_FP_BLDA))./std(TP_FP_BLDA));
[h_3, p_3] = kstest((TP_FP_SWLDA-mean(TP_FP_SWLDA))./std(TP_FP_SWLDA));
[h_4, p_4] = kstest((TP_FP_SVM-mean(TP_FP_SVM))./std(TP_FP_SVM));
[h_5, p_5] = kstest((TP_FP_SVM_SW-mean(TP_FP_SVM_SW))./std(TP_FP_SVM_SW));

% h = 0 for all, follow normality assumption
X = [TP_FP_FLDA; TP_FP_BLDA; TP_FP_SWLDA; TP_FP_SVM; TP_FP_SVM_SW];
group = ['FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';'FLDA     ';
        'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';'BLDA     ';
        'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';'SWLDA    ';
        'SVM      ';'SVM      ';'SVM      ';'SVM      ';'SVM      ';'SVM      ';
        'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA';'SVM+SWLDA'];
[P,ANOVATAB,STATS] = anova1(X, group);
% p > .05
% use student-t-test to do post hoc
[h1  p1 ] = ttest2(TP_FP_FLDA,  TP_FP_BLDA  );
[h2  p2 ] = ttest2(TP_FP_FLDA,  TP_FP_SWLDA );
[h3  p3 ] = ttest2(TP_FP_FLDA,  TP_FP_SVM   );
[h4  p4 ] = ttest2(TP_FP_FLDA,  TP_FP_SVM_SW);
[h5  p5 ] = ttest2(TP_FP_BLDA,  TP_FP_SWLDA );
[h6  p6 ] = ttest2(TP_FP_BLDA,  TP_FP_SVM   );
[h7  p7 ] = ttest2(TP_FP_BLDA,  TP_FP_SVM_SW);
[h8  p8 ] = ttest2(TP_FP_SWLDA, TP_FP_SVM   );
[h9  p9 ] = ttest2(TP_FP_SWLDA, TP_FP_SVM_SW);
[h10 p10] = ttest2(TP_FP_SVM,   TP_FP_SVM_SW);



