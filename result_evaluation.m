clc; clear all; close all;
%% Load Test Data and Model; Predict on Test Data
warning('off')
cm = zeros(3,3);
for fold = 1:5
model_name = sprintf("Model/Fold%d_KNN_model.mat",fold);
data_name = sprintf("Data/Fold%d_Data.mat",fold);
load(model_name)
load(data_name)

[pred, score, ~] = predict(model.clf, testX);
cm = cm + confusionmat(testY,pred);
end
%% Result Evaluation
[stats] = statsOfMeasure(cm, 0);
disp("Result for Five Fold Cross Validation")
disp(stats)