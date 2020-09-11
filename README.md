# Human Segmentation in Surveillance Video with Deep Learning
---
![teaser](images/teaser.png)

## Usage
---

The implementation of our work is built on MATLAB R2018a and the Deep Learning Toolbox is requested.
Note that this tutorial assumes that your root folder is `/human-segmentation/`. 

Please modify the commands where appropriate if you choose to use different directories.
Download the dataset and the source code. Your file structure should look like this:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ C
/human-segmentation/
    dataset/
        imageDataset/
            train/
            test/
            val/
        pixelLabelDataset/
            train/
            test/
            val/
    myColorMap.m
    pixelLabelColorbar.m
    preprocessImage.m
    semanticseg_newImage.m
    testMySegnet.m
    trainMySegnet.m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Train

Run the code in `trainMySegnet.m` to train the network.

### Test

Run the code in `testMySegnet.m` to test the trained network.

### Query trained network

Run the code in `semanticseg_newImage.m` to query the trained network and get the network output and the label overlay, which is an overlap of input and output based on a colormap. 
The colormap is defined in `myColorMap.m`. 

The function `pixelLabelColorbar.m` is useful to add a colorbar to the current axis. 
The colorbar is formatted to display the class names with the color.

The function `preprocessImage.m` is used to resize the input image before getting it to the network, according to the image input size defined in the first layer.

### Pretrained models

Please download `trainedNetwork_indoor.mat` and `trainedNetwork_outdoor.mat` to use our trained networks for indoor and outdoor areas that we chose.
You have to load the appropriate model into the MATLAB command window and then query the network with images in the "photos" folder, which contains real photos taken directly with a camera.
