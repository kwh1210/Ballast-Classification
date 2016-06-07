function path = setPath
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
path.root = fileparts(fileparts(mfilename('fullpath')));
path.video = fullfile(path.root,'video');

end

