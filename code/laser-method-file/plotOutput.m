function plotOutput(imdbName,modelName,varargin)
% built-in MATLAB regression model,
% here I give two examples: SVM regression and GP regression
clear all
load(imdbName);

trainSet = find(images.set==1);
trainOutput = zeros(length(trainSet),1);

testSet = find(images.set==3);
testOutput = zeros(length(testSet),1);

trainLabels = images.labels(trainSet)';
testLabels = images.labels(testSet)';

train = squeeze(images.data(:,:,1,trainSet))';
test = squeeze(images.data(:,:,1,testSet))';


switch modelName
    case 'SVM'
        model = fitrsvm(train,trainLabels);
    case 'GP'
%         model = fitrgp(train,trainLabels,...
%             'FitMethod','fic','KernelFunction','ardsquaredexponential');
          model = fitrgp(train,trainLabels);
end

testOutput = predict(model,test);
trainOutput = predict(model,train);

fitTruth = fit(1:length(test),testLabels,'poly9');
figure,plot(fitTruth,'b',1:length(test),testLabels,'r.');
hold on;
fitTestOut = fit(1:length(test),testOutput,'poly9');
plot(fitTestOut,'g',1:length(test),testOutput,'m.');


hold off;

title([modelName,' test output',' using ',imdbName]);
xlabel('samples');
ylabel('lables');
ylim([5,25]);
legend('groundTruthLablesData','groundTruthLablesFit','testOutput Data','testOutput Fit','location','southeast');


fitTruth = fit(1:length(train),trainLabels,'poly9');
figure,plot(fitTruth,'b',1:length(train),trainLabels,'r.');
hold on;
fitTrainOut = fit(1:length(train),trainOutput,'poly9');
plot(fitTrainOut,'g',1:length(train),trainOutput,'m.');

title([modelName,' train output',' using ',imdbName]);
xlabel('samples');
ylabel('lables');
ylim([5,25])
legend('groundTruthLablesData','groundTruthLablesFit','trainOutput Data','trainOutput Fit','location','southeast');


end
