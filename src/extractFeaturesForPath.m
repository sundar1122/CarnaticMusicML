function [FeatureMatrix, CategoryList] = extractFeaturesForPath(path, category, params)
%   f = extractFeaturesForPath extracts data from several files in a path
%   Input:
%      folder: folder containing all the song files
%          The folder should contain one sub-folder per raga, which
%          contains the music files.
%      category: category for feature - 'none' if not known. eg. 'Kalyani'
%      or 'Sankarabharanam'.
%      params: a structure that contains the following
%          parmams.frameLength = number of seconds in each frame (default =
%          1)
%          params.hopFactor = hop factor for frame (default = 0.5)
%          params.overlap = number of seconds of frame overlaps for
%          contiguous frames
%          params.frames = number of frames per record of data (default 7)
%   Output:
%      FeatureMatrix = Each row of X will contain data for params.frames sets of 12 features.
%          Each set represents 1 second of music data
%      CategoryList : Name of the raaga 
%          Kalyani, Sankarabharanam, Kapi, Hindolam, ... This is the same
%          as the sub-folder name.
%
    currentDir = pwd();
    cd(path);
    files = ls('*.mp3');
    
    FeatureMatrix = [];
    CategoryList = [];
    for i = 1, size(files,1); 
        file = strtrim(files(i,:));
        fprintf('... ... Processing file %s\n', file);
        [features, categories] = extractFeaturesForFile(path, file, category, params);
        FeatureMatrix = [FeatureMatrix;features];
        CategoryList = [CategoryList; categories];  
    end
    fprintf('... ... Finished For loop\n');
    cd (currentDir);
    f = reshape(FeatureMatrix, size(FeatureMatrix,1), size(FeatureMatrix,2)*size(FeatureMatrix,3));
    s = [f,CategoryList];
    [pathstr,name,ext] = fileparts(path);
    exportfile = strcat(name, '.csv');
    dlmwrite(exportfile, s);
end
