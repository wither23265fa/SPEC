hAddress = '..//Training//Healthy//';
fAddress = '..//Training//Faulty//';

healthy = dir([hAddress, '*.txt']);
faulty = dir([fAddress, '*.txt']);
% healthy.name
% faulty.name

hSize = size(healthy)
hData=[];
fData =[];

for k = 1:hSize(1)
    hSignal = importdata([hAddress, healthy(k).name]);
    fSignal = importdata([fAddress, faulty(k).name]);
    hData = [hData hSignal.data];
    fData = [fData fSignal.data];
end


hNData = normalize(hData, 'zscore');
fNData = normalize(fData, 'zscore');

for i = 1:1
    hti = strcat("Healthy ", int2str(i));
    fti = strcat("Faulty ", int2str(i));
    tCombine = strcat('combine ', int2str(i));
%     self_fft(hNData(:, i), hti);
%     self_fft(fNData(:, i), fti);
    bind_fft(hNData(:, i+6), fNData(:, i), tCombine);
end


