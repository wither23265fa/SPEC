function mdl = SVM(X,Y)   
  %% split training and testing data
    cv = cvpartition(size(X,1),'HoldOut',0.3);% split 70% train 30% test
    idx = cv.test;
    
    % Separate to training and test data
    dataTrain  = X(~idx,:);
    dataTest   = X(idx,:);
    labelTrain = Y(~idx, :);
    labelTest  = Y(idx, :);
    
    %% Training
    mdl = fitcsvm(dataTrain,labelTrain); 
    %Test is data that you want to predict.
    [labelpredict] = predict(mdl,dataTest);
    table(labelTest,labelpredict,'VariableNames',{'TrueLabel','PredictedLabel'})
    TestSize= size(labelTest)
    Accuracy = sum(labelTest==labelpredict)/TestSize(1,1)*100
    
    sv = mdl.SupportVectors;
    figure
    gscatter(X(:,1),X(:,2),Y)
    hold on
    plot(sv(:,1),sv(:,2),'ko','MarkerSize', 5)
    legend('healthy','faulty','Support Vector')
    hold off
    
end
