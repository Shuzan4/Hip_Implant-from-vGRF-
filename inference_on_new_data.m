clc; clear all; close all;
%% Load
load 'Sample Data/samples.mat'
FS = 250;
load 'Sample Data/mean_Std.mat'
load 'Sample Data/ranked.mat'
%% Test on New Data
% sig: GRF signals in cells of shape (N,1) where each row has signals of
% shape (101,1)
% FS: Sampling Frequency
tic
pred = inference(sig, FS);
toc
%% If labels are present do result analysis
cm = confusionmat(labels,pred);
[stats] = statsOfMeasure(cm, 0);
disp("Result for New Data:")
disp(stats)