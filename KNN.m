load X_train.txt;
load y_train.txt;
trainInputs = X_train(:,:);
trainOutputs = y_train(:,:);
mdl = fitcknn(trainInputs,trainOutputs);
mdl.NumNeighbors = 7;
load X_test.txt;
load y_test.txt;
testInputs = X_test(:,:);
predictions = predict(mdl,testInputs);
actualOutputs = y_test(:,:);
count = 0;
for i = 1:2947
    if (actualOutputs(i,1) == predictions(i,1))
        count = count + 1;
    end
end
accuracy = (count/2947) * 100;
disp(accuracy)