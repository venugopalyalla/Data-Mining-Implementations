load X_train.txt;
load y_train.txt;
load X_test.txt;
load y_test.txt;
trainInputs = X_train(:,:);
trainOutputs = y_train(:,:);
c = 10000;
t = templateSVM('KernelFunction','polynomial','PolynomialOrder',2);
Mdl = fitcecoc(trainInputs,transpose(trainOutputs),'Learners',t);
testInputs = X_test(:,:);
predictions = predict(Mdl,testInputs);
actualOutputs = transpose(y_test(:,:));
count = 0;
for i = 1:1000
    if (actualOutputs(1,i) == predictions(i,1))
        count = count + 1;
    end
end
accuracy = (count/1000) * 100;
disp(accuracy);