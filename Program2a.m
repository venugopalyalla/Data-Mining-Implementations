load X_train.mat;
load y_train.mat;
load X_test.mat;
load y_test.mat;
trainInputs = X_train(:,:);
trainOutputs = y_train(:,:);
mdl = fitcknn(trainInputs,trainOutputs);
mdl.NumNeighbors = 7;
testInputs = X_test(:,:);
predictions = predict(mdl,testInputs);
actualOutputs = (y_test(:,:))';
count = 0;
for i = 1:1000
    if(actualOutputs(i,1) == predictions(i,1))
        count = count + 1;
    end
end
accuracy = (count/1000) * 100;
disp(accuracy);