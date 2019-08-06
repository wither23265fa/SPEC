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
[x, yH, yF, topIndex] = getTopPriorSet(hNData, fNData, 3);
size(yF / 2)
labelAssign = categorical([ones(size(yH,1),1)*0; ones(size(yF,1) / 2,1)*1; ones(size(yF,1) / 2,1)*2]);

%% split data
splitData = [yH ;yF]; %40*3 data combine after feature extraction  
cv = cvpartition(size(splitData,1),'HoldOut',0.3);% split 70% train 30% test
idx = cv.test;
% Separate to training and test data
dataTrain = splitData(~idx,:);
dataTest  = splitData(idx,:);
labelTrain = labelAssign(~idx,:);
labelTest = labelAssign(idx,:);

data=[dataTrain];
labels=[labelTrain];

%% start training logistic regression 
[model ,dev,stats] = mnrfit(dataTrain, labelTrain);
% model
pihat = mnrval(model,dataTest)
[M, mIdx] = max(pihat');
result = mIdx' - 1
% CV_Test = glmval(model, dataTest, 'logit') ;  %Use LR Model

% %% Cross validation
% accuracy = [zeros(4,1)]
% indices = crossvalind('Kfold',labels,4);
% for i = 1:4
%     test = (indices == i); 
%     train = ~test;
%     dataTrain(test,:)
%     labelTrain(test,:)
%     relabel = labels(test,:) > 0.5
%     [b,dev,stats] = glmfit(data(train,:),labels(train),'binomial','logit'); % Logistic regression
%     yhat=glmval(b,data(test,:), 'logit' );
%     class_Healthy=yhat > 0.5;
%     acc = (relabel == class_Healthy)
%     accuracy(i) = sum(acc)/ size(acc,1) 
% end
% accuracy_per = (sum(accuracy)/ size(accuracy,1))*100
% fprintf('Accuracy = %d %% \n', accuracy_per)
% 
%% ploting
rs = size(result);
predResult = categorical(result);

figure;
x = linspace(0,rs(1),rs(1));

plot(x,labelTest, 'r')
hold on

plot(x, categorical(result), 'b')

title('Predicition result logical');
legend('real label','prediction label')

hold off
 
% predResult = predResult.';
% realResult = realResult.';

%% Confusion matrix 
% figure; 
plotconfusion(labelTest, predResult) 
 
%% ROC  
[X,Y,T,AUC] = perfcurve(labelTest, result, 1); 
 
AUC 
figure; 
plot(X,Y, 'LineWidth',8) 
xlabel('False positive rate')  
ylabel('True positive rate') 
title('ROC for Classification by Logistic Regression') 
 
%% Run testing data by model 
tSize = size(tNData);
testArr = [];
for i = 1:tSize(2)
    [xTest, fftTP1] = self_fft(tNData(:, i), fs);
    testArr = [testArr fftTP1];        
end

testTop = testArr(topIndex, :).'; 
% realTest = glmval(model, testTop, 'logit');   

tmpTest = mnrval(model,testTop) %Use LR Model multiclass
[M, mIdx] = max(tmpTest');
realTest = mIdx' - 1

%% plot have not seen testing result
% testLabelAssign = [ones(10,1)*0; ones(10,1); ones(10,1)*2];
% figure
% x = linspace(0, 30, 30);
% plot(x, testLabelAssign, 'b')
% hold on
% 
% plot(x, realTest, 'r')
% 
% legend('real label','prediction label')
% title('Prediction result logical in testing result');
% 
% hold off



