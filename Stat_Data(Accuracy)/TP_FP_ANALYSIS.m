clc
clear

%% read inputs

TP_FP1  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\1\TP_FP.txt');
TP_FP2  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\2\TP_FP.txt');
TP_FP3  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\3\TP_FP.txt');
TP_FP4  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\4\TP_FP.txt');
TP_FP5  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\5\TP_FP.txt');
TP_FP6  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\6\TP_FP.txt');
TP_FP7  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\7\TP_FP.txt');
TP_FP8  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\8\TP_FP.txt');
TP_FP9  = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\9\TP_FP.txt');
TP_FP10 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\10\TP_FP.txt');
TP_FP11 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\11\TP_FP.txt');
TP_FP12 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\12\TP_FP.txt');
TP_FP13 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\13\TP_FP.txt');
TP_FP14 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\14\TP_FP.txt');
TP_FP15 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\15\TP_FP.txt');
TP_FP16 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\16\TP_FP.txt');
TP_FP17 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\17\TP_FP.txt');
TP_FP18 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\18\TP_FP.txt');
TP_FP19 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\19\TP_FP.txt');
TP_FP20 = load('C:\Users\Jaehong\Desktop\Classifiers\LabVIEW\Stat_Data(Accuracy)\20\TP_FP.txt');

%% Stat-Analysis (feature repetition = 20)

% rearrange accordingly to Classifiers
FLDA = TP_FP20(1,:); BLDA = TP_FP20(2,:); SWLDA = TP_FP20(3, :); SVM = TP_FP20(4,:)/100; SVM_SW = TP_FP20(5,:)/100;

mFLDA  = mean(FLDA);
mBLDA  = mean(BLDA);
mSWLDA = mean(SWLDA);
mSVM   = mean(SVM);
mSVM_SW= mean(SVM_SW);

stdFLDA   = std(FLDA);
stdBLDA   = std(BLDA);
stdSWLDA  = std(SWLDA);
stdSVM    = std(SVM);
stdSVM_SW = std(SVM_SW);

% test normality
[h_FLDA  , p_FLDA  ] = kstest((FLDA-mean(FLDA))./std(FLDA));
[h_BLDA  , p_BLDA  ] = kstest((BLDA-mean(BLDA))./std(BLDA));
[h_SWLDA , p_SWLDA ] = kstest((SWLDA-mean(SWLDA))./std(SWLDA));
[h_SVM   , p_SVM   ] = kstest((SVM-mean(SVM))./std(SVM));
[h_SVM_SW, p_SVM_SW] = kstest((SVM_SW-mean(SVM_SW))./std(SVM_SW));

% nonparametric ANOVA test
% KRUSKALWALLIS Nonparametric one-way analysis of variance (ANOVA)

X                  = [FLDA; BLDA; SWLDA; SVM; SVM_SW]';
group              = ['FLDA  '; 'BLDA  '; 'SWLDA '; 'SVM   '; 'SVM_SW'];
[P,ANOVATAB,STATS] = anova1(X, group);

% post-hoc with Mann-Whitney Test

[h1,p1,ci1,stats1]  = ttest2(FLDA,BLDA);
[h2,p2,ci2,stats2]  = ttest2(FLDA,SWLDA);
[h3,p3,ci3,stats3] = ttest2(FLDA,SVM);
[h4,p4,ci4,stats4]  = ttest2(FLDA,SVM_SW);
[h5,p5,ci5,stats5]  = ttest2(BLDA,SWLDA);
[h6,p6,ci6,stats6]  = ttest2(BLDA,SVM);
[h7,p7,ci7,stats7]  = ttest2(BLDA,SVM_SW);
[h8,p8,ci8,stats8]  = ttest2(SWLDA,SVM);
[h9,p9,ci9,stats9]  = ttest2(SWLDA,SVM_SW);
[h10,p10,ci10,stats10] = ttest2(SVM,SVM_SW);

%% ITR ANALYSIS
FLDA20 = mean(TP_FP20(1,:)); BLDA20 = mean(TP_FP20(2,:)); SWLDA20 = mean(TP_FP20(3, :)); SVM20 = mean(TP_FP20(4,:))/100; SVM_SW20 = mean(TP_FP20(5,:))/100;
FLDA19 = mean(TP_FP19(1,:)); BLDA19 = mean(TP_FP19(2,:)); SWLDA19 = mean(TP_FP19(3, :)); SVM19 = mean(TP_FP19(4,:))/100; SVM_SW19 = mean(TP_FP19(5,:))/100;
FLDA18 = mean(TP_FP18(1,:)); BLDA18 = mean(TP_FP18(2,:)); SWLDA18 = mean(TP_FP18(3, :)); SVM18 = mean(TP_FP18(4,:))/100; SVM_SW18 = mean(TP_FP18(5,:))/100;
FLDA17 = mean(TP_FP17(1,:)); BLDA17 = mean(TP_FP17(2,:)); SWLDA17 = mean(TP_FP17(3, :)); SVM17 = mean(TP_FP17(4,:))/100; SVM_SW17 = mean(TP_FP17(5,:))/100;
FLDA16 = mean(TP_FP16(1,:)); BLDA16 = mean(TP_FP16(2,:)); SWLDA16 = mean(TP_FP16(3, :)); SVM16 = mean(TP_FP16(4,:))/100; SVM_SW16 = mean(TP_FP16(5,:))/100;
FLDA15 = mean(TP_FP15(1,:)); BLDA15 = mean(TP_FP15(2,:)); SWLDA15 = mean(TP_FP15(3, :)); SVM15 = mean(TP_FP15(4,:))/100; SVM_SW15 = mean(TP_FP15(5,:))/100;
FLDA14 = mean(TP_FP14(1,:)); BLDA14 = mean(TP_FP14(2,:)); SWLDA14 = mean(TP_FP14(3, :)); SVM14 = mean(TP_FP14(4,:))/100; SVM_SW14 = mean(TP_FP14(5,:))/100;
FLDA13 = mean(TP_FP13(1,:)); BLDA13 = mean(TP_FP13(2,:)); SWLDA13 = mean(TP_FP13(3, :)); SVM13 = mean(TP_FP13(4,:))/100; SVM_SW13 = mean(TP_FP13(5,:))/100;
FLDA12 = mean(TP_FP12(1,:)); BLDA12 = mean(TP_FP12(2,:)); SWLDA12 = mean(TP_FP12(3, :)); SVM12 = mean(TP_FP12(4,:))/100; SVM_SW12 = mean(TP_FP12(5,:))/100;
FLDA11 = mean(TP_FP11(1,:)); BLDA11 = mean(TP_FP11(2,:)); SWLDA11 = mean(TP_FP11(3, :)); SVM11 = mean(TP_FP11(4,:))/100; SVM_SW11 = mean(TP_FP11(5,:))/100;
FLDA10 = mean(TP_FP10(1,:)); BLDA10 = mean(TP_FP10(2,:)); SWLDA10 = mean(TP_FP10(3, :)); SVM10 = mean(TP_FP10(4,:))/100; SVM_SW10 = mean(TP_FP10(5,:))/100;
FLDA9 = mean(TP_FP9(1,:)); BLDA9 = mean(TP_FP9(2,:)); SWLDA9 = mean(TP_FP9(3, :)); SVM9 = mean(TP_FP9(4,:))/100; SVM_SW9 = mean(TP_FP9(5,:))/100;
FLDA8 = mean(TP_FP8(1,:)); BLDA8 = mean(TP_FP8(2,:)); SWLDA8 = mean(TP_FP8(3, :)); SVM8 = mean(TP_FP8(4,:))/100; SVM_SW8 = mean(TP_FP8(5,:))/100;
FLDA7 = mean(TP_FP7(1,:)); BLDA7 = mean(TP_FP7(2,:)); SWLDA7 = mean(TP_FP7(3, :)); SVM7 = mean(TP_FP7(4,:))/100; SVM_SW7 = mean(TP_FP7(5,:))/100;
FLDA6 = mean(TP_FP6(1,:)); BLDA6 = mean(TP_FP6(2,:)); SWLDA6 = mean(TP_FP6(3, :)); SVM6 = mean(TP_FP6(4,:))/100; SVM_SW6 = mean(TP_FP6(5,:))/100;
FLDA5 = mean(TP_FP5(1,:)); BLDA5 = mean(TP_FP5(2,:)); SWLDA5 = mean(TP_FP5(3, :)); SVM5 = mean(TP_FP5(4,:))/100; SVM_SW5 = mean(TP_FP5(5,:))/100;
FLDA4 = mean(TP_FP4(1,:)); BLDA4 = mean(TP_FP4(2,:)); SWLDA4 = mean(TP_FP4(3, :)); SVM4 = mean(TP_FP4(4,:))/100; SVM_SW4 = mean(TP_FP4(5,:))/100;
FLDA3 = mean(TP_FP3(1,:)); BLDA3 = mean(TP_FP3(2,:)); SWLDA3 = mean(TP_FP3(3, :)); SVM3 = mean(TP_FP3(4,:))/100; SVM_SW3 = mean(TP_FP3(5,:))/100;
FLDA2 = mean(TP_FP2(1,:)); BLDA2 = mean(TP_FP2(2,:)); SWLDA2 = mean(TP_FP2(3, :)); SVM2 = mean(TP_FP2(4,:))/100; SVM_SW2 = mean(TP_FP2(5,:))/100;
FLDA1 = mean(TP_FP1(1,:)); BLDA1 = mean(TP_FP1(2,:)); SWLDA1 = mean(TP_FP1(3, :)); SVM1 = mean(TP_FP1(4,:))/100; SVM_SW1 = mean(TP_FP1(5,:))/100;

FLDA = [FLDA20 FLDA19 FLDA18 FLDA17 FLDA16 FLDA15 FLDA14 FLDA13 FLDA12 FLDA11...
    FLDA10 FLDA9 FLDA8 FLDA7 FLDA6 FLDA5 FLDA4 FLDA3 FLDA2 FLDA1];
BLDA = [BLDA20 BLDA19 BLDA18 BLDA17 BLDA16 BLDA15 BLDA14 BLDA13 BLDA12 BLDA11...
    BLDA10 BLDA9 BLDA8 BLDA7 BLDA6 BLDA5 BLDA4 BLDA3 BLDA2 BLDA1];
SVM = [SVM20 SVM19 SVM18 SVM17 SVM16 SVM15 SVM14 SVM13 SVM12 SVM11...
    SVM10 SVM9 SVM8 SVM7 SVM6 SVM5 SVM4 SVM3 SVM2 SVM1];
SWLDA = [SWLDA20 SWLDA19 SWLDA18 SWLDA17 SWLDA16 SWLDA15 SWLDA14 SWLDA13 SWLDA12 SWLDA11...
    SWLDA10 SWLDA9 SWLDA8 SWLDA7 SWLDA6 SWLDA5 SWLDA4 SWLDA3 SWLDA2 SWLDA1];
SVM_SW = [SVM_SW20 SVM_SW19 SVM_SW18 SVM_SW17 SVM_SW16 SVM_SW15 SVM_SW14 SVM_SW13 SVM_SW12 SVM_SW11...
    SVM_SW10 SVM_SW9 SVM_SW8 SVM_SW7 SVM_SW6 SVM_SW5 SVM_SW4 SVM_SW3 SVM_SW2 SVM_SW1];

FLDA   = fliplr(FLDA);
BLDA   = fliplr(BLDA);
SWLDA  = fliplr(SWLDA);
SVM    = fliplr(SVM);
SVM_SW = fliplr(SVM_SW);

ITR = @(x, n) log(n)/log(2) + x*log(x)/log(2) + (1-x)*log((1-x)/(n-1))/log(2);

ITR_FLDA   = zeros(1,20);
ITR_BLDA   = zeros(1,20);
ITR_SWLDA  = zeros(1,20);
ITR_SVM    = zeros(1,20);
ITR_SVM_SW = zeros(1,20);

for i = 1:20;
    ITR_FLDA(i)  = ITR(FLDA(i), 6);
    ITR_BLDA(i)  = ITR(BLDA(i), 6);
    ITR_SWLDA(i) = ITR(SWLDA(i), 6);
    ITR_SVM(i)   = ITR(SVM(i), 6);
    ITR_SVM_SW(i)= ITR(SVM_SW(i), 6);    
end

x = 0:1:20;

figure(3)
plot(x, [0 FLDA], 'k-')
hold on
plot(x, [0 BLDA], 'b-', x, [0 SWLDA], 'r-', x, [0 SVM], 'y-', x, [0 SVM_SW], 'g-')
hold off
legend('FLDA', 'BLDA', 'SWLDA','SVM','SVM+SWLDA')
title('Detection rate of each Classifiers')
xlabel('Flash repetition number')
ylabel('Detection accuracy')

