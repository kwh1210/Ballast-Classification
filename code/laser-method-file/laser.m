clear all;

path = setPath;
%extract frame
opt.binary = 1;
path = extractFrame(path,opt);

%get the laser position, extract position from binary image
vidInfo = getLaserPos(path,opt);
    %plotPointsOnImage is used to testify if the position extracted is right or not
    %plotPointsOnImage(vidInfo,path)

%filling missing points
opt.fillingMethod = 'Mean';
vidInfo = fillingMissingPoints(vidInfo,path,opt);


%determine the start frame and end frame
vidInfo = getMovingFrame(vidInfo,path,opt);

%label the data
labels = [  16.26*ones(1,6),...
            11.34*ones(1,5),...
            20.79*ones(1,5),...
            20.07*ones(1,5),...
            8.87*ones(1,5),...
            10.6*ones(1,5),...
            17.25*ones(1,5),...
            13.71*ones(1,5),...
            20.11*ones(1,5),...
            20.81*ones(1,5),...
            17.78*ones(1,5),...
            22.98*ones(1,5),...
            16.9*ones(1,5),...
            14.19*ones(1,5),...
         ];           
vidInfo = labelData(vidInfo,labels,path,opt);
%%
% format imdb (format of matconvent)
testSet = [1 7 12 22 27 32 37 57 67];
opt.resizeCoeff = 0.5;
opt.normalization = 1;
%opt.feature = 'Raw Data';
%opt.feature = 'First Derivative of Raw Data'
opt.feature = 'DFT of Raw Data'
opt = formatData(vidInfo,opt,testSet,path);

% linear regression model trial
opt.model = 'SVM';
%opt.model = 'GP';
regressionModel(opt,path);






