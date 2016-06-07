function regressionModel(opt,path,varargin)
% use MATLAB built-in function to train a regression model
% I use two models here, Supported Vector Machine(SVM) regression and 
% Gaussian Process(GP) regression. And in the plot, the fitting function
% of the curve os 9-degree. I want to use higher degree function, but it
% seems that is the MATLAB's limit.
% note:I use all default parameters. Feel free to change them.
%

load(fullfile(path.processed,'formattedData',opt.imdbName,'imdb.mat'));
trainSet = find(images.set==1);
trainOutput = zeros(length(trainSet),1);

testSet = find(images.set==3);
testOutput = zeros(length(testSet),1);

trainLabels = images.labels(trainSet)';
testLabels = images.labels(testSet)';

feature = opt.feature;
switch feature
    case 'Raw Data' 
       train = squeeze(images.data(:,:,1,trainSet))';
       test = squeeze(images.data(:,:,1,testSet))';
    case 'DFT of Raw Data'
         train = abs(fft(squeeze(images.data(:,:,1,trainSet))'));
         test = abs(fft(squeeze(images.data(:,:,1,testSet))'));
    case 'First Derivative of Raw Data'
        train = diff(squeeze(images.data(:,:,1,trainSet)))';
        test = diff(squeeze(images.data(:,:,1,testSet)))';
end


modelName = opt.model;
switch modelName
    case 'SVM'
        model = fitrsvm(train,trainLabels);
    case 'GP'
%         model = fitrgp(train,trainLabels,...
%             'FitMethod','fic','KernelFunction','ardsquaredexponential');
          model = fitrgp(train,trainLabels);
        %fit = resubPredict(model);
end

% predict value
testOutput = predict(model,test);
trainOutput = predict(model,train);

% plot
fitTruth = fit([1:size(test,1)]',testLabels,'poly9');
figure,plot(fitTruth,'b',[1:size(test,1)]',testLabels,'r.');
hold on;
fitTestOut = fit([1:size(test,1)]',testOutput,'poly9');
plot(fitTestOut,'g',[1:size(test,1)]',testOutput,'m.');


hold off;

title([modelName,' test output',' using ',feature]);
xlabel('samples');
ylabel('lables');
ylim([5,25]);
legend('groundTruthLablesData','groundTruthLablesFit','testOutput Data',...
    'testOutput Fit','location','southeast');

fitTruth = fit([1:size(train,1)]',trainLabels,'poly9');
figure,plot(fitTruth,'b',[1:size(train,1)]',trainLabels,'r.');
hold on;
fitTrainOut = fit([1:size(train,1)]',trainOutput,'poly9');
plot(fitTrainOut,'g',[1:size(train,1)]',trainOutput,'m.');

title([modelName,' train output',' using ',feature]);
xlabel('samples');
ylabel('lables');
ylim([5,25])
legend('groundTruthLablesData','groundTruthLablesFit','trainOutput Data',...
    'trainOutput Fit','location','southeast');      
end

