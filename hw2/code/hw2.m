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

hNData = normalize(hData);
fNData = normalize(fData);

% % visualize
% for i = 1:20
%     hti = strcat("Healthy ", int2str(i));
%     fti = strcat("Faulty ", int2str(i));
%     tCombine = strcat('combine ', int2str(i));
%     bind_fft(hNData(:, i), fNData(:, i), tCombine);
% end

%% get top priority
[x, yH, yF] = getTopPriorSet(hNData, fNData, 3);
labels = [ones(size(yH,1),1)*0.95; ones(size(yF,1),1)*0.05];% create label


%% split data
data = [yH ;yF];%40*3 data combine after feature extraction  
cv = cvpartition(size(data,1),'HoldOut',0.3);% split 70% train 30% test
idx = cv.test;
% Separate to training and test data
dataTrain = data(~idx,:);
dataTest  = data(idx,:);
labelTrain = labels(~idx,:);
labelTest = labels(idx,:);

data=[dataTrain]
labels=[labelTrain]
%% start training logistic regression 
model = glmfit(dataTrain, labelTrain,'binomial');
CV_Test = glmval(model, dataTest, 'logit') ;  %Use LR Model

%% Cross validation
accuracy = [zeros(4,1)]
indices = crossvalind('Kfold',labels,4);
for i = 1:4
    test = (indices == i); 
    train = ~test;
    dataTrain(test,:)
    labelTrain(test,:)
    relabel = labels(test,:) > 0.5
    [b,dev,stats] = glmfit(data(train,:),labels(train),'binomial','logit'); % Logistic regression
    yhat=glmval(b,data(test,:), 'logit' );
    class_Healthy=yhat > 0.5;
    acc = (relabel == class_Healthy)
    accuracy(i) = sum(acc)/ size(acc,1) 
end
accuracy_per = (sum(accuracy)/ size(accuracy,1))*100
fprintf('Accuracy = %d %% \n', accuracy_per)

 






