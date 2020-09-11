clear;clc

%% SegNet Layers
imageSize = [360 640 3]; 
numClasses = 2; %background and foreground
lgraph = segnetLayers(imageSize,numClasses,'vgg16') 
%figure;plot(lgraph) 
%Pretrained network model, specified as 'vgg16' and 'vgg19', have an encoder depth of 5.
%Convolution layer weights in the encoder and decoder subnetworks are initialized using the 'MSRA' weight initialization method. 
%For 'vgg16' or 'vgg19' models, only the decoder subnetwork is initialized using MSRA.

% NOTE: put the dataset in the same directory of this script

%% Training datastore:
imTrainDir = '.\dataset\imageDataset\train';  % Replace "dataset" with the name of dataset directory
imdsTrain = imageDatastore(imTrainDir);
pxTrainDir = '.\dataset\pixelLabelDataset\train';  % Replace "dataset" with the name of dataset directory
classNames = ["fg","bg"];
pixelLabelID   = [1 0];  %foregroud (fg) = 1; background (bg) = 0
pxdsTrain = pixelLabelDatastore(pxTrainDir,classNames,pixelLabelID);

%% Data augmentation:
augmenter = imageDataAugmenter('RandXReflection',true,'RandRotation',[-30,30]);

%% Training dataset (with augmenter):
datasource = pixelLabelImageDatastore(imdsTrain,pxdsTrain,'DataAugmentation',augmenter);

%% Weight balance: 
tbl = countEachLabel(datasource)
totalNumberOfPixels = sum(tbl.PixelCount);
frequency = tbl.PixelCount / totalNumberOfPixels
inverseFreq = 1./frequency

figure; bar(1:numel(classNames),frequency)
xticks(1:numel(classNames))
xticklabels(classNames)
xtickangle(45)
ylabel('Frequency')
% saveas(gcf,'frequency.jpg')

figure;
bar(1:numel(classNames),inverseFreq)
xticks(1:numel(classNames))
xticklabels(classNames)
xtickangle(45)
ylabel('Inverse Frequency')
% saveas(gcf,'inverseFrequency.jpg')

%% New pixel classification layer:
pxLayer = pixelClassificationLayer('Name','labels','ClassNames', tbl.Name, 'ClassWeights', inverseFreq)

%% Update SegNet layers
lgraph = removeLayers(lgraph, 'pixelLabels');
lgraph = addLayers(lgraph, pxLayer);
lgraph = connectLayers(lgraph, 'softmax' ,'labels');
lgraph.Layers

%% Validation dataset:
imValDir = '.\dataset\imageDataset\val';  % Replace "dataset" with the name of dataset directory
imdsVal = imageDatastore(imValDir);
pxValDir = '.\dataset\pixelLabelDataset\val';  % Replace "dataset" with the name of dataset directory
pxdsVal = pixelLabelDatastore(pxValDir,classNames,pixelLabelID);
datasourceVal = pixelLabelImageDatastore(imdsVal,pxdsVal);

%% Train network
diary('commandWindow')
numTrainImg = numel(imdsTrain.Files)   % example: 29873
miniBatchSize = 1  
valFreq=floor(numTrainImg/miniBatchSize) 
% numTrainImg2 = numel(pxdsTrain.Files)   % must be the same of numTrainImg
opts = trainingOptions('adam','InitialLearnRate',0.00001,'MaxEpochs',40,'MiniBatchSize',miniBatchSize,'ValidationData',datasourceVal,'ValidationPatience',Inf,'ValidationFrequency',valFreq,'Shuffle','every-epoch','Plots','training-progress');
net = trainNetwork(datasource, lgraph, opts);
save('mySegnet_trained.mat', 'net')
disp('Network saved!')
diary off
% manually capture or save training plot
