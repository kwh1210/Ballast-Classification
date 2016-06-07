function vidInfo = fillingMissingPoints(vidInfo,path,opt,varargin)
% this function is to fill the missing points
%   the method I use here is using the mean value of the occupied position
%   to fill the missing points

for i=1:vidInfo.vidNum
    vidInfo.vid(i).posMatFilled = vidInfo.vid(i).posMat;
    for k=1:size(vidInfo.vid(i).posMat,2)
        vac = find(vidInfo.vid(i).posMat(:,k)==1);
        nonvac = find(vidInfo.vid(i).posMat(:,k)>1);
        vidInfo.vid(i).posMatFilled(vac,k) = mean(vidInfo.vid(i).posMatFilled(nonvac,k));
    end
end
saveInfo(vidInfo,path,opt,'fillingMissingPoints');
end