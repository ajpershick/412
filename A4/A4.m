digitDatasetPath = fullfile('/home/alec/Documents/412/A4', 'orl_faces');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% imds.ReadFcn = @smoothImage;
imds.ReadFcn = @contrastImage;
% imds.ReadFcn = @normalizeImage;
% imds.ReadFcn = @SmoothAndContrastImage;




close all;

figure;
perm = randperm(400,20);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end

labelCount = countEachLabel(imds);

img = readimage(imds,1);
size(img)

numTrainFiles = 5;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

layers = [
    imageInputLayer([112 92 1])
    
    convolution2dLayer(2,8,'Padding',1)
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(2,16,'Padding',1)
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(2,32,'Padding',1)
    reluLayer

    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(40)
    softmaxLayer
    classificationLayer];

% options = trainingOptions('sgdm', ...
%     'MaxEpochs',100, ...
%     'InitialLearnRate',0.0001, ...
%     'ValidationData',imdsValidation, ...
%     'ValidationFrequency',40, ...
%     'Verbose',false, ...
%     'InitialLearnRate',0.01, ...
%     'Plots','training-progress');

    options = trainingOptions('sgdm', ...
    'LearnRateSchedule','piecewise', ...
    'InitialLearnRate',0.01, ...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',5, ...
    'MaxEpochs',30, ...
    'MiniBatchSize',60, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',15, ...
    'Plots','training-progress')
    

net = trainNetwork(imdsTrain,layers,options);

YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)

function image = smoothImage(filename)
    img = imread(filename);
    image = imgaussfilt(img, 4);
end

function image = normalizeImage(filename)
    img = imread(filename);
    img = mat2gray(img);
    image = im2double(img);
end

function image = contrastImage(filename)
    img = imread(filename);
    image = imadjust(img);
end

function image = SmoothAndContrastImage(filename)
    img = imread(filename);
    img = imgaussfilt(img, 4);
    image = imadjust(img);
end

