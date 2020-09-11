function [I,dim] = preprocessImage(filename)
% Resize image according to network size
%
% Input: 
%   - filename: filename of the image to be resized
    
    I = imread(filename);
    dim = size(I); %original dimensions
    I = imresize(I, [360 640],'lanczos3'); %[numrows numcols]  
end