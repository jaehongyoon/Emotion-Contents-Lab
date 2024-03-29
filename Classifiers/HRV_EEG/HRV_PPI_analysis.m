clc
clear

%% read inputs

HRV_PPI = xlsread('HRV_data.xlsx');

%% Stat-Analysis (feature repetition = 20)

% nontarget data
N_VLF = HRV_PPI(:,1);
N_LF  = HRV_PPI(:,2);
N_HF  = HRV_PPI(:,3);
N_PPI = HRV_PPI(:,4);

% target data
T_VLF = HRV_PPI(:,5);
T_LF  = HRV_PPI(:,6);
T_HF  = HRV_PPI(:,7);
T_PPI = HRV_PPI(:,8);

% mean values
m_N_VLF = mean(N_VLF);
m_N_LF  = mean(N_LF);
m_N_HF  = mean(N_HF);
m_N_PPI = mean(N_PPI);

m_VLF   = mean(T_VLF);
m_LF    = mean(T_LF);
m_HF    = mean(T_HF);
m_PPI   = mean(T_PPI);

% std value
std_N_VLF = std(N_VLF);
std_N_LF  = std(N_LF);
std_N_HF  = std(N_HF);
std_N_PPI = std(N_PPI);

std_VLF   = std(T_VLF);
std_LF    = std(T_LF);
std_HF    = std(T_HF);
std_PPI   = std(T_PPI);

% test normality
[h_N_VLF, p_N_VLF]  = kstest((N_VLF-m_N_VLF)./std_N_VLF);
[h_N_LF,  p_N_LF ]  = kstest((N_LF-m_N_LF)./std_N_LF);
[h_N_HF,  p_N_HF ]  = kstest((N_HF-m_N_HF)./std_N_HF);
[h_N_PPI, p_N_PPI]  = kstest((N_PPI-m_N_PPI)./std_N_PPI);

[h_T_VLF, p_T_VLF]  = kstest((T_VLF-m_VLF)./std_VLF);
[h_T_LF,  p_T_LF ]  = kstest((T_LF-m_LF)./std_LF);
[h_T_HF,  p_T_HF ]  = kstest((T_HF-m_HF)./std_HF);
[h_T_PPI, p_T_PPI]  = kstest((T_PPI-m_PPI)./std_PPI);

% non-parametric test
stats_VLF   =   mwwtest(N_VLF, T_VLF);
stats_LF    =   mwwtest(N_LF,  T_LF);
stats_HF    =   mwwtest(N_HF,  T_HF);
stats_PPI   =   mwwtest(N_PPI, T_PPI);
