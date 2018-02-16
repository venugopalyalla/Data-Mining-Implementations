clear;
load X_test.mat;
load X_train.mat;
load y_test.mat;
load y_train.mat;
trainInputs = X_train(:,:);
trainOutputs = y_train(:,:);
testInputs = X_test;
actualOutputs = y_test(:,:);
overallPredictions(3251,1) = 0;

mdl = fitcknn(trainInputs,trainOutputs);
mdl.NumNeighbors = 7;
knnPredictions = predict(mdl,testInputs);


inputs = (X_train(:,:)');
targets = full(ind2vec((y_train)'));
net = feedforwardnet(25);
net = train(net,(inputs),targets);
testIp = transpose(X_test);
testOp = net(testIp);
neuralnwPredictions = (vec2ind(testOp)');

t = templateSVM('KernelFunction','polynomial','PolynomialOrder',2);
svmMdl = fitcecoc(trainInputs,transpose(trainOutputs),'Learners',t);
svmPredictions = predict(svmMdl,testInputs);

knnCount = 0;
for i = 1:3251
    if (actualOutputs(i,1) == knnPredictions(i,1))
        knnCount = knnCount + 1;
    end
end
knnAccuracy = (knnCount/3251) * 100;

neuralnwCount = 0;
for i = 1:3251
    if (actualOutputs(i,1) == neuralnwPredictions(i,1))
        neuralnwCount = neuralnwCount + 1;
    end
end
neuralnwAccuracy = (neuralnwCount/3251) * 100;

svmCount = 0;
for i = 1:3251
    if (actualOutputs(i,1) == svmPredictions(i,1))
        svmCount = svmCount + 1;
    end
end
svmAccuracy = (svmCount/3251) * 100;


vote = 0;
A(1:10,1:1) = 0;
for i = 1:3251
    for j = 1:10
        if (knnPredictions(i,1) == j)
            A(j,1) = A(j,1) + 1;
        end
        if (neuralnwPredictions(i,1) == j)
            A(j,1) = A(j,1) + 1;
        end
        if (svmPredictions(i,1) == j)
            A(j,1) = A(j,1) + 1;
        end
    end
    vote = max(A);
    for n = 1:10
        if(A(n,1) == vote)
            overallPredictions(i,1) = n;
        end
    end
    A(1:10,1:1) = 0;
    vote = 0;
end


count = 0;
for i = 1:3251
    if (actualOutputs(i,1) == overallPredictions(i,1))
        count = count + 1;
    end
end
ensembleAccuracy = (count/3251) * 100;


knnOutput = sprintf('KNN Accuracy is %f',knnAccuracy);
neuralnwOutput = sprintf('Neural Network Accuracy is %f',neuralnwAccuracy);
svmOutput = sprintf('SVM Accuracy is %f',svmAccuracy);
ensembleOutput = sprintf('Ensemble Accuracy is %f',ensembleAccuracy);
disp(knnOutput);
disp(neuralnwOutput);
disp(svmOutput);
disp(ensembleOutput);