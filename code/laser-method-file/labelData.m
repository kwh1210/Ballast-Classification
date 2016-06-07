function vidInfo = labelData( vidInfo,labels,path,opt,varargin )
% This function is used to label data
%   
for i=1:vidInfo.vidNum
    vidInfo.vid(i).labels = labels(i);
end
saveInfo(vidInfo,path,opt,'labelData');
end


