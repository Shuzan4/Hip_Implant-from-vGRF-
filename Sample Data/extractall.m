function [features] = extractall(X, fs, axis)
    
    nSample = size(X, 1);
    grfFeatures = [];
    grfFeatureNames ={};
    
    % Progressbar setup (optional)
    f = waitbar(0, 'Extracting features ... ');
    
    for i = 1:nSample
        
        waitbar(i/nSample, f, ...
            sprintf('Extracting features ... %d/%d', i, nSample) ...
        );
        
        Xs = cell2mat(X(i, 1));
        try
            [grfFeatures(i, :), grfFeatureNames] = extract_feat(Xs,fs);
        catch
            grfFeatures(i, :) = nan(1,34);
        end
    end
    
    % delete progresspar
    delete(f);
    
    featuresArray = grfFeatures;
    names = strcat(grfFeatureNames, axis);    
    features = array2table(grfFeatures, 'VariableNames', names);

end