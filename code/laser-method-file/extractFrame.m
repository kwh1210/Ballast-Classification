function  path = extractFrame(path,opt,varargin)
% this function is to extract frames from video
% one of the field in opt is binary which is either "0" or "1", representing for whether
% converting rgb image to binary image
% this function only needs to be run once. 
% extra note for this function: because I name the video by order in one specific
% file, like video1 video2... so it would be quite inconvenient to add new data
% to existing processed data.
vid = dir(fullfile(path.video,'./*MOV'));
vidNum = numel(vid);
path.processed = fullfile(path.root,'processedData');
mk(path.processed);
save(fullfile(path.processed,'vidNum.mat'),'vidNum');

for i=1:vidNum
    vidObj = VideoReader(vid(i).name);
	vidName = ['video',num2str(i)];
	k=1;
	if exist('frame','var')
        clear('frame');
    end
    k=1;
    filename = [vidName,'.mat'];
    if ~exist(fullfile(path.processed,'video',filename),'file')
        while hasFrame(vidObj)
            im = readFrame(vidObj);
            if mean(im(:))>10
                continue;
            end
            info.vidth = i;
            info.frameth = k;
            info.path = path;
            frame(k).imageData = im;
            writeImage(im,'frameRGB',info);
            if opt.binary
                frame(k).imageDataBi = getBinaryImage(frame(k).imageData);
                writeImage(frame(k).imageDataBi,'frameBinary',info);
            end
            k = k + 1;
            pause(0);
        end
        save(fullfile(path.processed,'video',filename),'frame','-v7.3');
    end
end


end

% ----------------
function mk(dir)
% ----------------
if ~exist(dir)
	mkdir(dir)
end
end


% -----------------------------------
function imBinary = getBinaryImage(im)
%------------------------------------
% converting to binary image using default threshold
% and remove the small spot
bw = im2bw(im);
imBinary = bwareaopen(bw,100);
end

% ------------------------------
function writeImage(im,type,info)
% ------------------------------
writePath = fullfile(info.path.processed,type);
mk(writePath);
vidName = ['video',num2str(info.vidth)];
writePath = fullfile(writePath,vidName);
mk(writePath);
filename = ['video',num2str(info.vidth),'frame',num2str(info.frameth),'.png'];
imwrite(im,fullfile(writePath,filename));
end



	
