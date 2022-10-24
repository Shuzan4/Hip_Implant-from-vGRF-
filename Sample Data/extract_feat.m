function [feat, names] = extract_feat(Xs, FS)
%% Get sig
X = Xs(:)';
%% Initial Calc
cutoff = FS/10;
[pxx,f] = pwelch(X', [], [], [], FS);
[maxfreq, maxval, maxratio]=dominant_frequency_features(X',FS, cutoff, 0);
[~,~,~,descriptor]=signal_entropy(X);
[cD1,cD2,cD3,cD4,cD5,cD6,cD7,cD8,cA8,D1,D2,D3,D4,D5,D6,D7,D8,A8] = ...
    waveletFeatures(X);
[C, L] = wavedec(X, 6, 'db4');
A6 = appcoef(C, L, 'db4', 6);
%% Get feat
temp = TDD(X');
feat(1:5) = temp(2:end);
feat(6) = jMYOP(X, 0.016);
feat(7) =jEMAV(X);
feat(8) =skewness(pxx,0);
feat(9) =spectralEntropy(pxx,f);
feat(10) = spectralSlope(pxx,f);
feat(11) =maxval;
temp = getarfeat(X',4);
feat(12:13) = temp(1:2);
feat(14) = descriptor(1);
feat(15) = SMratio(f,pxx);
feat(16) = meanfreq(X,FS);
feat(17)=kurtosis(X,0);
feat(18)= jEWL(X);
feat(19)= maxratio;
feat(20)=quantile(X,0.25);
feat(21)=OHMratio(f,pxx);
feat(22)= skewness(X,0);
[~,PeakIndex]=max(X);
feat(23) = X(PeakIndex)/length(X);
feat(24:28) = [bandpower(cD1), bandpower(cD2),bandpower(cD4) ...
                ,bandpower(cD7),bandpower(cA8)]; 
feat(29:30) =[jMFL(cD1),jMFL(D4)];
feat(31:32)=[compute_WE(X,'db4', 6),compute_WE(X,'db4', 8)];
feat(33) = find_waveform_length(A8);
feat(34) =find_MAV(A6,length(A6));

%% Feat Names
n1 = {'Diff02rderMoments', 'Diff04OrderMoments', ...
    'Sparseness', 'IrregularityFactor', 'WaveformLengthRatio'};
n2 = {'MyoplusePercentageRate', 'EnhancedMAV','PsSkewness'};
n3 ={'SpectralEntropy','SpectralSlope','MaxValue','AutoRegressive1'...
    ,'AutoRegressive2'};
n4 = {'DescriptorSELowerBound','SignalToMotionArtifactRatio','MeanFeauency'};
n5 = {'SignalKurtosis','EnhancedWavLen','MaxRatio','FirstQuantile'...
    ,'SpectralDeformation','SignalSkewness','TimeToPeak'};
n6 = {'BandPowerCD1','BandPowerCD2','BandPowerCD4','BandPowerCD7','BandPowerCA8'};
n7 = {'MaxFractalLenCD1','MaxFractalLenD4'};
n8 = {'WaveletEntropy6', 'WaveletEntropy8'};
n9 ={'WaveformLenA8','MeanAbsValA6'};
names =[n1,n2,n3,n4,n5,n6,n7,n8,n9];
end