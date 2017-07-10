function [FeatureMatrix, CategoryList] = extractFeaturesForFile(path, file, category, params)
%   f = extractFeaturesForFile extracts data from a particular in a folder
%   Input:
%      path: folder containing all the song files
%          The folder should contain one sub-folder per raga, which
%          contains the music files.
%      file: Name of the file to extract the features from
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
    cd (path);
    audio = mirframe(file,'Length', params.frameLength, 'Hop', params.hopFactor);
    chroma = mirchromagram(audio);
    data = mirgetdata(chroma);
% get key to adjust - change keyval to 1 
 %   key = mirkey(file);
 %   keyval = mirgetdata(key);
    
    FeatureMatrix = [];
    CategoryList = [];
    cols = size(data, 2);
    features = zeros(cols-params.frames, size(data,1),params.frames);
    categories = repmat(category, cols-params.frames, 1);
    for i = 1: cols - params.frames
        x = data(:, i:i-1+params.frames);
        
%        y = [x(keyval:size(x,1),:);x(1:keyval-1,:)];
 %       x = y;
        
        features(i,:,:) = x;
    end
    FeatureMatrix = features;
    CategoryList = categories;
    f = reshape(features, size(features,1), size(features,2)*size(features,3));
    s = [f,categories];
    [pathstr,name,ext] = fileparts(file);
    exportfile = strcat(name, '.csv');
    dlmwrite(exportfile, s);
    cd(currentDir);
end

