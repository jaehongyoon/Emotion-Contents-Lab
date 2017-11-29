clc
clear

%% Load data

kg = load('강병훈.txt');
kd = load('김다영.txt');
ks = load('김수미.txt');
ld = load('이동원.txt');
lj = load('이재호.txt');
lh = load('이현민.txt');
jd = load('정동욱.txt');
ch = load('조현지.txt');
cy = load('차예술.txt');
cd = load('최동환.txt');

%% test normality of data

%kang
[h_kang_VLF, p_kang_VLF] = kstest(kang(:,1));
[h_kang_LF,  p_kang_LF ] = kstest(kang(:,2));
[h_kang_HF,  p_kang_HF ] = kstest(kang(:,3));
[h_kang_PPI, p_kang_PPI] = kstest(kang(:,4));
[h_kang_HLR, p_kang_HLR] = kstest(kang(:,5));

%kim_da
[h_kim_da_VLF, p_kim_da_VLF] = kstest(kim_da(:,1));
[h_kim_da_LF,  p_kim_da_LF ] = kstest(kim_da(:,2));
[h_kim_da_HF,  p_kim_da_HF ] = kstest(kim_da(:,3));
[h_kim_da_PPI, p_kim_da_PPI] = kstest(kim_da(:,4));
[h_kim_da_HLR, p_kim_da_HLR] = kstest(kim_da(:,5));

%kim_su
[h_kim_su_VLF, p_kim_su_VLF] = kstest(kim_su(:,1));
[h_kim_su_LF,  p_kim_su_LF ] = kstest(kim_su(:,2));
[h_kim_su_HF,  p_kim_su_HF ] = kstest(kim_su(:,3));
[h_kim_su_PPI, p_kim_su_PPI] = kstest(kim_su(:,4));
[h_kim_su_HLR, p_kim_su_HLR] = kstest(kim_su(:,5));

%lee_dong
[h_lee_dong_VLF, p_lee_dong_VLF] = kstest(lee_dong(:,1));
[h_lee_dong_LF,  p_lee_dong_LF ] = kstest(lee_dong(:,2));
[h_lee_dong_HF,  p_lee_dong_HF ] = kstest(lee_dong(:,3));
[h_lee_dong_PPI, p_lee_dong_PPI] = kstest(lee_dong(:,4));
[h_lee_dong_HLR, p_lee_dong_HLR] = kstest(lee_dong(:,5));

%lee_jae
[h_lee_jae_VLF, p_lee_jae_VLF] = kstest(lee_jae(:,1));
[h_lee_jae_LF,  p_lee_jae_LF ] = kstest(lee_jae(:,2));
[h_lee_jae_HF,  p_lee_jae_HF ] = kstest(lee_jae(:,3));
[h_lee_jae_PPI, p_lee_jae_PPI] = kstest(lee_jae(:,4));
[h_lee_jae_HLR, p_lee_jae_HLR] = kstest(lee_jae(:,5));

%lee_hyun
[h_lee_hyun_VLF, p_lee_hyun_VLF] = kstest(lee_hyun(:,1));
[h_lee_hyun_LF,  p_lee_hyun_LF ] = kstest(lee_hyun(:,2));
[h_lee_hyun_HF,  p_lee_hyun_HF ] = kstest(lee_hyun(:,3));
[h_lee_hyun_PPI, p_lee_hyun_PPI] = kstest(lee_hyun(:,4));
[h_lee_hyun_HLR, p_lee_hyun_HLR] = kstest(lee_hyun(:,5));

%jung_dong
[h_jung_dong_VLF, p_jung_dong_VLF] = kstest(jung_dong(:,1));
[h_jung_dong_LF,  p_jung_dong_LF ] = kstest(jung_dong(:,2));
[h_jung_dong_HF,  p_jung_dong_HF ] = kstest(jung_dong(:,3));
[h_jung_dong_PPI, p_jung_dong_PPI] = kstest(jung_dong(:,4));
[h_jung_dong_HLR, p_jung_dong_HLR] = kstest(jung_dong(:,5));

%cho_hyun
[h_cho_hyun_VLF, p_cho_hyun_VLF] = kstest(cho_hyun(:,1));
[h_cho_hyun_LF,  p_cho_hyun_LF ] = kstest(cho_hyun(:,2));
[h_cho_hyun_HF,  p_cho_hyun_HF ] = kstest(cho_hyun(:,3));
[h_cho_hyun_PPI, p_cho_hyun_PPI] = kstest(cho_hyun(:,4));
[h_cho_hyun_HLR, p_cho_hyun_HLR] = kstest(cho_hyun(:,5));

%cha_yae
[h_cha_yae_VLF, p_cha_yae_VLF] = kstest(cha_yae(:,1));
[h_cha_yae_LF,  p_cha_yae_LF ] = kstest(cha_yae(:,2));
[h_cha_yae_HF,  p_cha_yae_HF ] = kstest(cha_yae(:,3));
[h_cha_yae_PPI, p_cha_yae_PPI] = kstest(cha_yae(:,4));
[h_cha_yae_HLR, p_cha_yae_HLR] = kstest(cha_yae(:,5));

%choi_dong
[h_choi_dong_VLF, p_choi_dong_VLF] = kstest(choi_dong(:,1));
[h_choi_dong_LF,  p_choi_dong_LF ] = kstest(choi_dong(:,2));
[h_choi_dong_HF,  p_choi_dong_HF ] = kstest(choi_dong(:,3));
[h_choi_dong_PPI, p_choi_dong_PPI] = kstest(choi_dong(:,4));
[h_choi_dong_HLR, p_choi_dong_HLR] = kstest(choi_dong(:,5));

%% mean and standard deviation

%mean
mean_kang_VLF = mean(kang(~isnan(kang(:,1)),1));mean_kang_LF = mean(kang(~isnan(kang(:,2)),2));mean_kang_HF = mean(kang(~isnan(kang(:,3)),3));mean_kang_PPI = mean(kang(~isnan(kang(:,4)),4));mean_kang_HLR = mean(kang(~isnan(kang(:,5)),5));
mean_kim_da_VLF = mean(kim_da(~isnan(kim_da(:,1)),1));mean_kim_da_LF = mean(kim_da(~isnan(kim_da(:,2)),2));mean_kim_da_HF = mean(kim_da(~isnan(kim_da(:,3)),3));mean_kim_da_PPI = mean(kim_da(~isnan(kim_da(:,4)),4));mean_kim_da_HLR = mean(kim_da(~isnan(kim_da(:,5)),5));
mean_kim_su_VLF = mean(kim_su(~isnan(kim_su(:,1)),1));mean_kim_su_LF = mean(kim_su(~isnan(kim_su(:,2)),2));mean_kim_su_HF = mean(kim_su(~isnan(kim_su(:,3)),3));mean_kim_su_PPI = mean(kim_su(~isnan(kim_su(:,4)),4));mean_kim_su_HLR = mean(kim_su(~isnan(kim_su(:,5)),5));
mean_lee_dong_VLF = mean(lee_dong(~isnan(lee_dong(:,1)),1));mean_lee_dong_LF = mean(lee_dong(~isnan(lee_dong(:,2)),2));mean_lee_dong_HF = mean(lee_dong(~isnan(lee_dong(:,3)),3));mean_lee_dong_PPI = mean(lee_dong(~isnan(lee_dong(:,4)),4));mean_lee_dong_HLR = mean(lee_dong(~isnan(lee_dong(:,5)),5));
mean_lee_jae_VLF = mean(lee_jae(~isnan(lee_jae(:,1)),1));mean_lee_jae_LF = mean(lee_jae(~isnan(lee_jae(:,2)),2));mean_lee_jae_HF = mean(lee_jae(~isnan(lee_jae(:,3)),3));mean_lee_jae_PPI = mean(lee_jae(~isnan(lee_jae(:,4)),4));mean_lee_jae_HLR = mean(lee_jae(~isnan(lee_jae(:,5)),5));
mean_lee_hyun_VLF = mean(lee_hyun(~isnan(lee_hyun(:,1)),1));mean_lee_hyun_LF = mean(lee_hyun(~isnan(lee_hyun(:,2)),2));mean_lee_hyun_HF = mean(lee_hyun(~isnan(lee_hyun(:,3)),3));mean_lee_hyun_PPI = mean(lee_hyun(~isnan(lee_hyun(:,4)),4));mean_lee_hyun_HLR = mean(lee_hyun(~isnan(lee_hyun(:,5)),5));
mean_jung_dong_VLF = mean(jung_dong(~isnan(jung_dong(:,1)),1));mean_jung_dong_LF = mean(jung_dong(~isnan(jung_dong(:,2)),2));mean_jung_dong_HF = mean(jung_dong(~isnan(jung_dong(:,3)),3));mean_jung_dong_PPI = mean(jung_dong(~isnan(jung_dong(:,4)),4));mean_jung_dong_HLR = mean(jung_dong(~isnan(jung_dong(:,5)),5));
mean_cho_hyun_VLF = mean(cho_hyun(~isnan(cho_hyun(:,1)),1));mean_cho_hyun_LF = mean(cho_hyun(~isnan(cho_hyun(:,2)),2));mean_cho_hyun_HF = mean(cho_hyun(~isnan(cho_hyun(:,3)),3));mean_cho_hyun_PPI = mean(cho_hyun(~isnan(cho_hyun(:,4)),4));mean_cho_hyun_HLR = mean(cho_hyun(~isnan(cho_hyun(:,5)),5));
mean_cha_yae_VLF = mean(cha_yae(~isnan(cha_yae(:,1)),1));mean_cha_yae_LF = mean(cha_yae(~isnan(cha_yae(:,2)),2));mean_cha_yae_HF = mean(cha_yae(~isnan(cha_yae(:,3)),3));mean_cha_yae_PPI = mean(cha_yae(~isnan(cha_yae(:,4)),4));mean_cha_yae_HLR = mean(cha_yae(~isnan(cha_yae(:,5)),5));
mean_choi_dong_VLF = mean(choi_dong(~isnan(choi_dong(:,1)),1));mean_choi_dong_LF = mean(choi_dong(~isnan(choi_dong(:,2)),2));mean_choi_dong_HF = mean(choi_dong(~isnan(choi_dong(:,3)),3));mean_choi_dong_PPI = mean(choi_dong(~isnan(choi_dong(:,4)),4));mean_choi_dong_HLR = mean(choi_dong(~isnan(choi_dong(:,5)),5));

%std
std_kang_VLF = std(kang(~isnan(kang(:,1)),1));std_kang_LF = std(kang(~isnan(kang(:,2)),2));std_kang_HF = std(kang(~isnan(kang(:,3)),3));std_kang_PPI = std(kang(~isnan(kang(:,4)),4));std_kang_HLR = std(kang(~isnan(kang(:,5)),5));
std_kim_da_VLF = std(kim_da(~isnan(kim_da(:,1)),1));std_kim_da_LF = std(kim_da(~isnan(kim_da(:,2)),2));std_kim_da_HF = std(kim_da(~isnan(kim_da(:,3)),3));std_kim_da_PPI = std(kim_da(~isnan(kim_da(:,4)),4));std_kim_da_HLR = std(kim_da(~isnan(kim_da(:,5)),5));
std_kim_su_VLF = std(kim_su(~isnan(kim_su(:,1)),1));std_kim_su_LF = std(kim_su(~isnan(kim_su(:,2)),2));std_kim_su_HF = std(kim_su(~isnan(kim_su(:,3)),3));std_kim_su_PPI = std(kim_su(~isnan(kim_su(:,4)),4));std_kim_su_HLR = std(kim_su(~isnan(kim_su(:,5)),5));
std_lee_dong_VLF = std(lee_dong(~isnan(lee_dong(:,1)),1));std_lee_dong_LF = std(lee_dong(~isnan(lee_dong(:,2)),2));std_lee_dong_HF = std(lee_dong(~isnan(lee_dong(:,3)),3));std_lee_dong_PPI = std(lee_dong(~isnan(lee_dong(:,4)),4));std_lee_dong_HLR = std(lee_dong(~isnan(lee_dong(:,5)),5));
std_lee_jae_VLF = std(lee_jae(~isnan(lee_jae(:,1)),1));std_lee_jae_LF = std(lee_jae(~isnan(lee_jae(:,2)),2));std_lee_jae_HF = std(lee_jae(~isnan(lee_jae(:,3)),3));std_lee_jae_PPI = std(lee_jae(~isnan(lee_jae(:,4)),4));std_lee_jae_HLR = std(lee_jae(~isnan(lee_jae(:,5)),5));
std_lee_hyun_VLF = std(lee_hyun(~isnan(lee_hyun(:,1)),1));std_lee_hyun_LF = std(lee_hyun(~isnan(lee_hyun(:,2)),2));std_lee_hyun_HF = std(lee_hyun(~isnan(lee_hyun(:,3)),3));std_lee_hyun_PPI = std(lee_hyun(~isnan(lee_hyun(:,4)),4));std_lee_hyun_HLR = std(lee_hyun(~isnan(lee_hyun(:,5)),5));
std_jung_dong_VLF = std(jung_dong(~isnan(jung_dong(:,1)),1));std_jung_dong_LF = std(jung_dong(~isnan(jung_dong(:,2)),2));std_jung_dong_HF = std(jung_dong(~isnan(jung_dong(:,3)),3));std_jung_dong_PPI = std(jung_dong(~isnan(jung_dong(:,4)),4));std_jung_dong_HLR = std(jung_dong(~isnan(jung_dong(:,5)),5));
std_cho_hyun_VLF = std(cho_hyun(~isnan(cho_hyun(:,1)),1));std_cho_hyun_LF = std(cho_hyun(~isnan(cho_hyun(:,2)),2));std_cho_hyun_HF = std(cho_hyun(~isnan(cho_hyun(:,3)),3));std_cho_hyun_PPI = std(cho_hyun(~isnan(cho_hyun(:,4)),4));std_cho_hyun_HLR = std(cho_hyun(~isnan(cho_hyun(:,5)),5));
std_cha_yae_VLF = std(cha_yae(~isnan(cha_yae(:,1)),1));std_cha_yae_LF = std(cha_yae(~isnan(cha_yae(:,2)),2));std_cha_yae_HF = std(cha_yae(~isnan(cha_yae(:,3)),3));std_cha_yae_PPI = std(cha_yae(~isnan(cha_yae(:,4)),4));std_cha_yae_HLR = std(cha_yae(~isnan(cha_yae(:,5)),5));
std_choi_dong_VLF = std(choi_dong(~isnan(choi_dong(:,1)),1));std_choi_dong_LF = std(choi_dong(~isnan(choi_dong(:,2)),2));std_choi_dong_HF = std(choi_dong(~isnan(choi_dong(:,3)),3));std_choi_dong_PPI = std(choi_dong(~isnan(choi_dong(:,4)),4));std_choi_dong_HLR = std(choi_dong(~isnan(choi_dong(:,5)),5));

%non of the data follow normal distribution
%non-parametric analysis should be held.
%reshape accordingly to data types
%VLF/LF/HF/PPI/HF_LF ratio

%% VLF, LF, HF, PPI, HLR stat analysis

% VLF, LF, HF, PPI, HLR array
% all normal-distribution

VLF = [mean_kang_VLF, mean_kim_da_VLF, mean_kim_su_VLF, mean_lee_dong_VLF, mean_lee_jae_VLF, mean_lee_hyun_VLF, mean_jung_dong_VLF, mean_cho_hyun_VLF, mean_cha_yae_VLF, mean_choi_dong_VLF];
LF = [mean_kang_LF, mean_kim_da_LF, mean_kim_su_LF, mean_lee_dong_LF, mean_lee_jae_LF, mean_lee_hyun_LF, mean_jung_dong_LF, mean_cho_hyun_LF, mean_cha_yae_LF, mean_choi_dong_LF];
HF = [mean_kang_HF, mean_kim_da_HF, mean_kim_su_HF, mean_lee_dong_HF, mean_lee_jae_HF, mean_lee_hyun_HF, mean_jung_dong_HF, mean_cho_hyun_HF, mean_cha_yae_HF, mean_choi_dong_HF];
PPI = [mean_kang_PPI, mean_kim_da_PPI, mean_kim_su_PPI, mean_lee_dong_PPI, mean_lee_jae_PPI, mean_lee_hyun_PPI, mean_jung_dong_PPI, mean_cho_hyun_PPI, mean_cha_yae_PPI, mean_choi_dong_PPI];
HLR = [mean_kang_HLR, mean_kim_da_HLR, mean_kim_su_HLR, mean_lee_dong_HLR, mean_lee_jae_HLR, mean_lee_hyun_HLR, mean_jung_dong_HLR, mean_cho_hyun_HLR, mean_cha_yae_HLR, mean_choi_dong_HLR];

group = ['VLF';'VLF';'VLF';'VLF';'VLF';'VLF';'VLF';'VLF';'VLF';'VLF';
         'LF ';'LF ';'LF ';'LF ';'LF ';'LF ';'LF ';'LF ';'LF ';'LF ';
         'HF ';'HF ';'HF ';'HF ';'HF ';'HF ';'HF ';'HF ';'HF ';'HF ';
         'PPI';'PPI';'PPI';'PPI';'PPI';'PPI';'PPI';'PPI';'PPI';'PPI';
         'HLR';'HLR';'HLR';'HLR';'HLR';'HLR';'HLR';'HLR';'HLR';'HLR'];
[P,ANOVATAB,STATS] = anova1([VLF; LF; HF; PPI; HLR], group);

[h1  p1 ]  = ttest2(VLF,  LF  );
[h2  p2 ]  = ttest2(VLF,  HF );
[h3  p3 ]  = ttest2(VLF,  PPI);
[h4  p4 ]  = ttest2(VLF,  HLR);
[h5  p5 ]  = ttest2(LF ,  HF );
[h6  p6 ]  = ttest2(LF ,  PPI);
[h7  p7 ]  = ttest2(LF ,  HLR);
[h8  p8 ]  = ttest2(HF ,  PPI);
[h9  p9 ]  = ttest2(HF ,  HLR);
[h10 p10]  = ttest2(PPI,  HLR);