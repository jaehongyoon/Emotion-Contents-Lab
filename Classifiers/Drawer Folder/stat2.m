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

%% test normality

h_result = zeros(10,24);

for i = 1:24
    
    cols  = find(~isnan(kg(:,i)));
    data  = kg(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(1,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(kd(:,i)));
    data  = kd(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(2,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(ks(:,i)));
    data  = ks(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(3,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(ld(:,i)));
    data  = ld(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(4,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(lj(:,i)));
    data  = lj(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(5,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(lh(:,i)));
    data  = lh(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(6,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(jd(:,i)));
    data  = jd(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(7,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(ch(:,i)));
    data  = ch(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(8,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(cy(:,i)));
    data  = cy(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(9,i) = h;
    
end

for i = 1:24
    
    cols  = find(~isnan(cd(:,i)));
    data  = cd(cols,i);
    data  = (data-mean(data)./std(data));
    [h,p] =  kstest(data);
    
    h_result(10,i) = h;
    
end

%no data follow normality

%% mean

mean_result = zeros(10,24);

for i = 1:24
    
    cols  = find(~isnan(kg(:,i)));
    data  = kg(cols,i);        
    mean_result(1,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(kd(:,i)));
    data  = kd(cols,i);
    mean_result(2,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(ks(:,i)));
    data  = ks(cols,i);
    mean_result(3,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(ld(:,i)));
    data  = ld(cols,i);
    mean_result(4,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(lj(:,i)));
    data  = lj(cols,i);
    mean_result(5,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(lh(:,i)));
    data  = lh(cols,i);
    mean_result(6,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(jd(:,i)));
    data  = jd(cols,i);
    mean_result(7,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(ch(:,i)));
    data  = ch(cols,i);
    mean_result(8,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(cy(:,i)));
    data  = cy(cols,i);
    mean_result(9,i) = mean(data);
    
end

for i = 1:24
    
    cols  = find(~isnan(cd(:,i)));
    data  = cd(cols,i);
    mean_result(10,i) = mean(data);
    
end

%% histogram

cols  = find(~isnan(kg(:,21)));
data_HLR_P3  = kg(cols,21);
cols  = find(~isnan(kg(:,23)));
data_ERP_P3  = kg(cols,23);       
cols  = find(~isnan(kg(:,22)));
data_HLR_N1  = kg(cols,22);       
cols  = find(~isnan(kg(:,24)));
data_ERP_N1  = kg(cols,24);       

figure(1)
hist(data_HLR_N1, 5)

figure(2)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS1 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(kd(:,21)));
data_HLR_P3  = kd(cols,21);
cols  = find(~isnan(kd(:,23)));
data_ERP_P3  = kd(cols,23);       
cols  = find(~isnan(kd(:,22)));
data_HLR_N1  = kd(cols,22);       
cols  = find(~isnan(kd(:,24)));
data_ERP_N1  = kd(cols,24);       

figure(3)
hist(data_HLR_N1, 5)

figure(4)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS2 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(ks(:,21)));
data_HLR_P3  = ks(cols,21);
cols  = find(~isnan(ks(:,23)));
data_ERP_P3  = ks(cols,23);       
cols  = find(~isnan(ks(:,22)));
data_HLR_N1  = ks(cols,22);       
cols  = find(~isnan(ks(:,24)));
data_ERP_N1  = ks(cols,24);       

figure(5)
hist(data_HLR_N1, 5)

figure(6)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS3 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(ld(:,21)));
data_HLR_P3  = ld(cols,21);
cols  = find(~isnan(ld(:,23)));
data_ERP_P3  = ld(cols,23);       
cols  = find(~isnan(ld(:,22)));
data_HLR_N1  = ld(cols,22);       
cols  = find(~isnan(ld(:,24)));
data_ERP_N1  = ld(cols,24);       

figure(7)
hist(data_HLR_N1, 5)

figure(8)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS4 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(lj(:,21)));
data_HLR_P3  = lj(cols,21);
cols  = find(~isnan(lj(:,23)));
data_ERP_P3  = lj(cols,23);       
cols  = find(~isnan(lj(:,22)));
data_HLR_N1  = lj(cols,22);       
cols  = find(~isnan(lj(:,24)));
data_ERP_N1  = lj(cols,24);       

figure(9)
hist(data_HLR_N1, 5)

figure(10)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS5 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(lh(:,21)));
data_HLR_P3  = lh(cols,21);
cols  = find(~isnan(lh(:,23)));
data_ERP_P3  = lh(cols,23);       
cols  = find(~isnan(lh(:,22)));
data_HLR_N1  = lh(cols,22);       
cols  = find(~isnan(lh(:,24)));
data_ERP_N1  = lh(cols,24);       

figure(11)
hist(data_HLR_N1, 5)

figure(12)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS6 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(jd(:,21)));
data_HLR_P3  = jd(cols,21);
cols  = find(~isnan(jd(:,23)));
data_ERP_P3  = jd(cols,23);       
cols  = find(~isnan(jd(:,22)));
data_HLR_N1  = jd(cols,22);       
cols  = find(~isnan(jd(:,24)));
data_ERP_N1  = jd(cols,24);       

figure(13)
hist(data_HLR_N1, 5)

figure(14)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS7 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(ch(:,21)));
data_HLR_P3  = ch(cols,21);
cols  = find(~isnan(ch(:,23)));
data_ERP_P3  = ch(cols,23);       
cols  = find(~isnan(ch(:,22)));
data_HLR_N1  = ch(cols,22);       
cols  = find(~isnan(ch(:,24)));
data_ERP_N1  = ch(cols,24);       

figure(15)
hist(data_HLR_N1, 5)

figure(16)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS8 = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(cy(:,21)));
data_HLR_P3  = cy(cols,21);
cols  = find(~isnan(cy(:,23)));
data_ERP_P3  = cy(cols,23);       
cols  = find(~isnan(cy(:,22)));
data_HLR_N1  = cy(cols,22);       
cols  = find(~isnan(cy(:,24)));
data_ERP_N1  = cy(cols,24);       

figure(17)
hist(data_HLR_N1, 5)

figure(18)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS = mwwtest(data_HLR_N1,data_ERP_N1)

cols  = find(~isnan(cd(:,21)));
data_HLR_P3  = cd(cols,21);
cols  = find(~isnan(cd(:,23)));
data_ERP_P3  = cd(cols,23);       
cols  = find(~isnan(cd(:,22)));
data_HLR_N1  = cd(cols,22);       
cols  = find(~isnan(cd(:,24)));
data_ERP_N1  = cd(cols,24);       

figure(19)
hist(data_HLR_N1, 5)

figure(20)
hist(data_ERP_N1,5)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')

STATS10 = mwwtest(data_HLR_N1,data_ERP_N1)











