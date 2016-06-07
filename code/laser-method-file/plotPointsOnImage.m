function PlotPointsOnImage(vidInfo,path)
imHeight = 1088;
figure;
for i=1:vidInfo.vidNum
    vidName = ['video',num2str(i)];
	load(fullfile(path.processed,vidName));
	for k=1:length(frame)
		imshow(frame(k).imageData);
		hold on;
		plot(vidInfo.vid(i).frame(k).position(:,1),1:imHeight,'b.');
		hold off;
		title(['The',num2str(i),'th video',num2str(k),'th frame laser position']);
        pause(0.02);
	end
end

end