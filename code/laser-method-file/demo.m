vid = dir(fullfile(path.video,'./*MOV'));
vidNum = numel(vid);
path.processed = fullfile(path.root,'processedData');

i=10;
    vidObj = VideoReader(vid(i).name);
	vidName = ['video',num2str(i)];
	k=1;
	if exist('frame','var')
        clear('frame');
    end
    k=1;
    filename = [vidName,'.mat'];
    
        while hasFrame(vidObj)
            im = readFrame(vidObj);
            frame(k).imageData = im;
           
            k = k + 1;
            pause(0);
        end
        save(fullfile(path.processed,filename),'frame','-v7.3');






