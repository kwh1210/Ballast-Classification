function vidInfo = getLaserPos(path,opt,varargin)
% this function is to get the laser position
%   the output would be a matrix, the nth columns of which is the nth frame
%   row is the image height
load(fullfile(path.processed,'vidNum.mat'));
vidInfo.vidNum = vidNum;
for i=1:vidNum
    filename = ['video',num2str(i),'.mat'];
	load(fullfile(path.processed,'video',filename));
	for k=1:length(frame)
		vidInfo.vid(i).posMat(:,k) = getLaserPosFun(frame(k).imageDataBi);
	end
end	
saveInfo(vidInfo,path,opt,'getLaserPos');
end

% -----------------------------------------------
function position = getLaserPosFun(imageDataBi)
% -----------------------------------------------
[Y position] = max(imageDataBi,[],2);
end
