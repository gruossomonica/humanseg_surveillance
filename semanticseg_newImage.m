function [mask, overlay] = semanticseg_newImage(filename,net)
% Query the trained network
%
% Input: 
%   - net: trained neural network
%   - filename: filename of the image to be segmented
% Output:
%   - mask: network output (logical version)
%   - overlay: label overlay

    I = imread(filename);
    originalSize = size(I); %original dimensions
    I_resize = imresize(I, [360 640],'lanczos3');    
    result=semanticseg(I_resize,net);     % network result (categorical)
    mask = result == 'fg';              % mask is logical version of result
    resizedSize = size(I_resize);
    
    if originalSize(1)/originalSize(2) ~= resizedSize(1)/resizedSize(2)  %different aspect ratio
        mask=imresize(mask,[originalSize(1) originalSize(2)],'lanczos3');
        result=categorical(mask, [1 0], {'fg' 'bg'});
    end
    
    figure
    imshowpair(I, mask,'montage')
    title('Image vs. Prediction'); 
    saveas(gcf,[filename '_pred.jpg']);
    
    % Label Overlay:
        %if "result" is not a categorical matrix (e.g., it's a binary matrix)
        %result=categorical(result,[1 0],{'fg' 'bg'});
    cmap=myColorMap();
    overlay = labeloverlay(I,result,'Colormap',cmap,'Transparency',0.5);
    figure
    imshow(overlay)
    title('Label overlay');
    classNames = ["foreground","background"];
    pixelLabelColorbar(cmap,classNames);
    saveas(gcf,[filename '_labelOverlay.jpg']);
end