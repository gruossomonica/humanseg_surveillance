function testMySegnet(net)
    % net: trained neural network
    
    %path_save='.\testResults\';
	path_save='.\';

    imTestDir = '.\dataset_aulaMagna_new\imageDataset\test'; 
    imdsTest = imageDatastore(imTestDir);
%     imdsTest.ReadFcn = @preprocessImage;   % if test images have different dimensions from those requested by the network
    pxTestDir = '.\dataset_aulaMagna_new\pixelLabelDataset\test';
    classNames = ["fg","bg"];
    pixelLabelID   = [1 0];
    pxdsTruth = pixelLabelDatastore(pxTestDir,classNames,pixelLabelID);
%     pxdsTruth.ReadFcn = @preprocessImage;   % if test images have different dimensions from those requested by the network
   
    pxdsResults = semanticseg(imdsTest,net,'WriteLocation',tempdir,'MiniBatchSize',1);

    metrics = evaluateSemanticSegmentation(pxdsResults,pxdsTruth);
    metrics.ClassMetrics
    save('myMetrics', 'metrics'); 
    disp('Metrics saved!')

    % Display normalized confusion matrix
    normConfMatData = metrics.NormalizedConfusionMatrix.Variables;
    figure
    h = heatmap(classNames, classNames, 100 * normConfMatData);
    h.XLabel = 'Predicted Class';
    h.YLabel = 'True Class';
    h.Title  = 'Normalized Confusion Matrix (%)';
    saveas(h,[path_save 'NormConfusionMatrix.jpg'])
    disp('Norm Confusion Matrix saaved!')

    % Display the worst and the best prediction for mean IoU
    imageIoU = metrics.ImageMetrics.MeanIoU;
    [minIoU, worstImageIndex] = min(imageIoU);
    minIoU = minIoU(1);
    worstImageIndex = worstImageIndex(1);
    worstTestImage = readimage(imdsTest, worstImageIndex);
    worstPredictedLabels = readimage(pxdsResults, worstImageIndex);
    worstPredictedLabelImage = im2uint8(worstPredictedLabels == classNames(1));
    figure
    imshowpair(worstTestImage, worstPredictedLabelImage,'montage')
    title(['Test image vs. Prediction. IoU = ' num2str(minIoU)])
    saveas(gcf,[path_save 'worst_meanIoU.jpg'])
    disp('worst_meanIoU saved!')

    [maxIoU, bestImageIndex] = max(imageIoU);
    maxIoU = maxIoU(1);
    bestImageIndex = bestImageIndex(1);
    bestTestImage = readimage(imdsTest, bestImageIndex);
    bestPredictedLabels = readimage(pxdsResults, bestImageIndex);
    bestPredictedLabelImage = im2uint8(bestPredictedLabels == classNames(1));
    figure
    imshowpair(bestTestImage, bestPredictedLabelImage,'montage')
    title(['Test image vs. Prediction. IoU = ' num2str(maxIoU)])
    saveas(gcf,[path_save 'best_meanIoU.jpg'])
    disp('best_meanIoU saved!')

    % Display the worst and the best prediction for mean accuracy
    imageAccuracy = metrics.ImageMetrics.MeanAccuracy;
    [minAccuracy, worstImageIndex] = min(imageAccuracy);
    minAccuracy = minAccuracy(1);
    worstImageIndex = worstImageIndex(1);
    worstTestImage = readimage(imdsTest, worstImageIndex);
    worstPredictedLabels = readimage(pxdsResults, worstImageIndex);
    worstPredictedLabelImage = im2uint8(worstPredictedLabels == classNames(1));
    figure
    imshowpair(worstTestImage, worstPredictedLabelImage,'montage')
    title(['Test image vs. Prediction. Accuracy = ' num2str(minAccuracy)])
    saveas(gcf,[path_save 'worst_meanAccuracy.jpg'])
    disp('worst_meanAccuracy saved!')

    [maxAccuracy, bestImageIndex] = max(imageAccuracy);
    maxAccuracy = maxAccuracy(1);
    bestImageIndex = bestImageIndex(1);
    bestTestImage = readimage(imdsTest, bestImageIndex);
    bestPredictedLabels = readimage(pxdsResults, bestImageIndex);
    bestPredictedLabelImage = im2uint8(bestPredictedLabels == classNames(1));
    figure
    imshowpair(bestTestImage, bestPredictedLabelImage,'montage')
    title(['Test image vs. Prediction. Accuracy = ' num2str(maxAccuracy)])
    saveas(gcf,[path_save 'best_meanAccuracy.jpg'])
    disp('best_meanAccuracy saved!')

end