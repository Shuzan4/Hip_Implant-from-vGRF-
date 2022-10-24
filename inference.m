function pred = inference(sig, FS)
%% Extract Features
addpath('Sample Data')
addpath('Sample Data/time_domain/');
addpath('Sample Data/frequency_domain/');
addpath('Sample Data/timefrequency_domain/');
feat = extractall(sig, FS, '_Z');
%% Load Model
warning('off')
fold = 1; % Choose any of the model from five-fold cross-validation
model_name = sprintf("Model/Fold%d_KNN_model.mat",fold);
load(model_name)
load 'Sample Data/mean_Std.mat'
load 'Sample Data/ranked.mat'
%% Sort according to feature rank and normalize
f1 = feat(:,f_names); % Reorder features according to importance
% Normalize
allfeat = f1.Variables;
allfeat = (allfeat - f_mean)./f_std;
f1.Variables = allfeat;
%% Predict on new data
[pred, score, ~] = predict(model.clf, f1);
end