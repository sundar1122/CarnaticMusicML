function [ FeatureMatrix, CategoryList ] = testFeatureExtraction()
%params = struct('frameLength', 1, 'hopFactor', 0.5, 'overlap', 1, 'frames', 7);
% [FeatureMatrix, CategoryList] = extractFeaturesForFile('D:\Documents\documents\Personal\MachineLearningMusic\evaluateData', 'carnatic_song-sabhapathikku-abhogi-rupakam-gopalakrishna-bharathi.mp3', 1, params);
% [FeatureMatrix, CategoryList] = extractFeaturesForPath('D:\Documents\documents\Personal\MachineLearningMusic\data\thodi', 25, params);
% [FeatureMatrix, CategoryList] = extractFeaturesForFolder('D:\Documents\documents\Personal\MachineLearningMusic\data', params);

% Prashant Set Params
params = struct('frameLength', 1, 'hopFactor', 0.5, 'overlap', 1, 'frames', 7);
[FeatureMatrix, CategoryList] = extractFeaturesForFile('D:\Documents\documents\Personal\MachineLearningMusic\evaluateData', 'carnatic_song-sabhapathikku-abhogi-rupakam-gopalakrishna-bharathi.mp3', 1, params);


end