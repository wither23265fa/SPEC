close all;
hAddress = '..//Training//Healthy//';
u1Address = '..//Training//Faulty//Unbalance 1//';
u2Address = '..//Training//Faulty//Unbalance 2//';
tAddress = '..//Testing//';

healthy = dir([hAddress, '*.txt']);
unbalance1 = dir([u1Address, '*.txt']);
unbalance2 = dir([u2Address, '*.txt']);
testShaft = dir([tAddress, '*.txt']);

fs = 2560
hSize = size(healthy)
tSize = size(testShaft)

hData = [];
u1Data = [];
u2Data = [];
tData = [];

for k = 1:hSize(1)
    hSignal = importdata([hAddress, healthy(k).name]);
    u1Signal = importdata([u1Address, unbalance1(k).name]);
    u2Signal = importdata([u2Address, unbalance2(k).name]);
    hData = [hData hSignal.data];
    u1Data = [u1Data u1Signal.data];
    u2Data = [u2Data u2Signal.data];
end

for i = 1:tSize(1)
    signal = importdata([tAddress, testShaft(i).name]);
    tData = [tData signal.data];
end

hNData = normalize(hData, 'norm', 1);
u1NData = normalize(u1Data, 'norm', 1);
u2NData = normalize(u2Data, 'norm', 1);
tNData = normalize(tData, 'norm', 1);

% visualize
for i = 1:1
    tCombine = strcat('combine ', int2str(i));
%     show_fft(hNData(:, i), u1NData(:, i), u2NData(:, i), tCombine, fs);
end

fNData = horzcat(u1NData, u2NData);

%% get top priority
mergeData = [hNData fNData];
[x, yFFT, topIndex] = getTopPriorSet(mergeData, 3);
labelAssign = categorical([ones(20,1)*0; ones(20,1)*1; ones(20,1)*2]);
% labelAssign = ['Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';
%     'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';
%     'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';
%     'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';
%     'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';
%     'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2']
%% 

X = [yFFT(1:60,1),yFFT(1:60,3)]
%y = [ones(20,1)*0; ones(20,1)*1]
Y =  {'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';
    'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';'Healthy';
    'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';
    'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';'Unbalance 1';
    'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';
    'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2';'Unbalance 2'}
SVMModel = fitcsvm(X,y)