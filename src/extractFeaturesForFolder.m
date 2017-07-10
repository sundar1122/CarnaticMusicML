function [FeatureMatrix, CategoryList] = extractFeaturesForFolder(folder, params)
%   f = extractFeaturesForFolder Extracts data from several files in a folder
%   Input:
%      folder: folder containing all the song files
%          The folder should contain one sub-folder per raga, which
%          contains the music files.
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

% 1st step is to get the name of the ragas (folder names)
folders = ls(folder);
FeatureMatrix = [];
CategoryList = [];
keyValuePair = getRaagaKeyValuePair();
for i = 3: size(folders,1) 
    category = strtrim(folders(i,:));
    if isdir(category)
        path = strcat(folder, '/');
        path = strcat(path, category);
        categoryId = keyValuePair(category);
        [Features, Categories] = extractFeaturesForPath(path, categoryId, params);
        FeatureMatrix = [FeatureMatrix; Features];
        CategoryList = [CategoryList; Categories];
    end

end
f = reshape(FeatureMatrix, size(FeatureMatrix,1), size(FeatureMatrix,2)*size(FeatureMatrix,3));
s = [f,CategoryList];
[pathstr,name,ext] = fileparts(folder);
exportfile = strcat(name, '.csv');
dlmwrite(exportfile, s);
end


    