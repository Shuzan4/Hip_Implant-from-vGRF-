# Classification of Gait Cycle Abnormalities due to Hip Surgery and Implanted Hip using Machine Learning Techniques

This repo contains the inference code for the paper titled **"Classification of Gait Cycle Abnormalities due to Hip Surgery and Implanted Hip using Machine Learning Techniques"** which is submitted to Diagonastic.

This repo has two parts: Result Evaluation and Inference on New Data.

The calculation of classification metrics have been done using `statsOfMeasure.m` from [Mathwork File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/86158-precision-specificity-sensitivity-accuracy-f1-score).

## Result Evaluation

In this part, we will load the test data from `Data` folder and get the prediction by using the models saved in `Model` folder. The Matlab script `result_evaluation.m` performs this task.

This snippet of code performs the prediction:

```Matlab
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
```

Note that we have provided test data and model for each fold.

## Inference on New Data

In this part, we will show how to use the new vGRF signals (like those in `Sample Data` folder) and get predictions using our model.

The script `inference_on_new_data.m` will perform the inference. This script is a wrapper around `inference.m` which does the feature extraction and prediction.

The following snippet performs the inference:

```Matlab
%% Test on New Data
% sig: GRF signals in cells of shape (N,1) where each row has signals of
% shape (101,1)
% FS: Sampling Frequency
tic
pred = inference(sig, FS);
toc
```
