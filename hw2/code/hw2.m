hAddress = '..//Training//Healthy//';
fAddress = '..//Training//Faulty//';

healthy = dir([hAddress, '*.txt']);
faulty = dir([fAddress, '*.txt']);

fs = 2560

hSize = size(healthy)
hData=[];
fData =[];

for k = 1:hSize(1)
    hSignal = importdata([hAddress, healthy(k).name]);
    fSignal = importdata([fAddress, faulty(k).name]);
    hData = [hData hSignal.data];
    fData = [fData fSignal.data];

end

hNData = normalize(hData, 'norm', 1);
fNData = normalize(fData, 'norm', 1);


% visualize
% for i = 1:20
%     hti = strcat("Healthy ", int2str(i));
%     fti = strcat("Faulty ", int2str(i));
%     tCombine = strcat('combine ', int2str(i));
%     bind_fft(hNData(:, i+6), fNData(:, i), tCombine);
% end

%% get top priority
[x, yH, yF] = getTopPriorSet(hNData, fNData, 3);
labels = [ones(size(yH,1),1)*0.95; ones(size(yF,1),1)*0.05];

%% split data
data = [yH ;yF];
cv = cvpartition(size(data,1),'HoldOut',0.3);
idx = cv.test;
% Separate to training and test data
dataTrain = data(~idx,:);
dataTest  = data(idx,:);
labelTrain = labels(~idx,:);
labelTest = labels(idx,:);

%% start training
model = glmfit(dataTrain, labelTrain,'binomial');
% [b,dev,stats] = glmfit(x,y,'normal');
CV_Test = glmval(model, dataTest, 'logit') ;  %Use LR Model

%% ploting
figure;
x = linspace(0,10,12);

plot(x,labelTest, 'r')
title('Predicition result numerical');

hold on

plot(x, CV_Test, 'b')

legend('real label','prediction label')

hold off

%% convert to discrete domain
predResult(CV_Test < 0.5) = 0;
predResult(CV_Test >= 0.5) = 1;

realResult(labelTest < 0.5) = 0;
realResult(labelTest >= 0.5) = 1;


