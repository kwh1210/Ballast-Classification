function opt = formatData(vidInfo,opt,testSet,path,varargin)
% it is the format of matconvnet
% there are many options, and you can add other features to the function as you like
% note: opt.resizeCoeff must be 1/n (n is the integer)


train = [];
for i=1:vidInfo.vidNum
	train = [train, ...
        vidInfo.vid(i).posMatFilled(:,vidInfo.vid(i).startFrame:vidInfo.vid(i).endFrame)];
end
imdbName = ['normalized',...
			'filledBy',opt.fillingMethod,...
			'-',opt.feature,...
			'-size',num2str(size(train,1)*opt.resizeCoeff)];
opt.imdbName = imdbName;
train = train(1:1/opt.resizeCoeff:end,:);

feature = opt.feature;
switch feature
	case 'Raw data'
		;
	case 'First Der of Raw Data'
		train = diff(train);
	case 'FT of Raw Data'
		train = abs(fft(train));
end

if opt.normalization
	for i=1:length(train(1,:))
		train(:,i) = train(:,i) - mean(train(:,i));
		train(:,i) = train(:,i)/norm(train(:,i));
	end
end

labels = [];
for i=1:vidInfo.vidNum
	frames = vidInfo.vid(i).endFrame - vidInfo.vid(i).startFrame + 1;
	labels(end+1:end+frames) = vidInfo.vid(i).labels;
end

set = [];
for i=1:vidInfo.vidNum
	frames = vidInfo.vid(i).endFrame - vidInfo.vid(i).startFrame + 1;
	if any(testSet==i)
		set(end+1:end+frames) = 3;
	else
		set(end+1:end+frames) = 1;
	end
end
[a,b] = size(train);
imdb.images.data = single(reshape(train,[a,1,1,b]));
imdb.images.data_mean = mean(train,2);
imdb.images.labels = labels;
imdb.images.set = set;
imdb.meta.sets = {'train','val','test'};
imdb.meta.classes = []; % I did not include classfication case here
                        % if using classfication, the labels and classes
                        % needs to be changed


mk(fullfile(path.processed,'formattedData'));
mk(fullfile(path.processed,'formattedData',imdbName));
save(fullfile(path.processed,'formattedData',imdbName,'imdb.mat'),'-struct','imdb');
saveInfo(vidInfo,path,opt,'formattedData');	
end

% ----------------
function mk(dir)
% ----------------
if ~exist(dir)
	mkdir(dir)
end

end



		
