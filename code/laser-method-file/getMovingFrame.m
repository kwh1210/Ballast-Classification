function vidInfo = getMovingFrame(vidInfo,path,opt,varargin)
%this function is to determine the start frame and end frame of a video
% the algorithm is get the first derivative of the vector position in each
% frame and sum up the absolute value of the first derivative. Then set a threshold 
% to determine whether the cart starts or stops moving
% feel free to change the threshold


% get the sum of derivative 
for i=1:vidInfo.vidNum
	for k=1:size(vidInfo.vid(i).posMatFilled,2)
        vidInfo.vid(i).derSum(k) = sum(abs((diff(vidInfo.vid(i).posMatFilled(:,k)))));
	end
end

% get moving frame
startUpThresh = 1000;
startDownThresh = 1000;

for i=1:vidInfo.vidNum
	for k=1:size(vidInfo.vid(i).posMatFilled,2)-1
		if vidInfo.vid(i).derSum(k)<startDownThresh ...
			&& vidInfo.vid(i).derSum(k+1)>startUpThresh 
            cur = vidInfo.vid(i).derSum(k);
            vidInfo.vid(i).startFrame = k+2;
            break;
		end
	end
end

 endUpThresh = 300;
 endDownThresh = 300;

for i=1:vidInfo.vidNum
	for k=size(vidInfo.vid(i).posMatFilled,2):-1:2
		 if vidInfo.vid(i).derSum(k)<endDownThresh ...
			&& vidInfo.vid(i).derSum(k-1)>endUpThresh 
            vidInfo.vid(i).endFrame = k-2;
            break;
		end
	end
end
saveInfo(vidInfo,path,opt,'getMovingFrame');
end