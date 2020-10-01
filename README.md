# Human Segmentation in Surveillance Video with Deep Learning

![teaser](images/teaser.png)

This repo contains the official training and testing code for Human Segmentation in Surveillance Video with Deep Learning (_Multimedia Tools and Applications, 2020_).

Please, refer to the [paper](https://link.springer.com/article/10.1007/s11042-020-09425-0) for technical details.

A video demo of our project is available on the [project page](http://graphics.unibas.it/www/HumanSegmentation/index.md.html).

## Usage


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

Run the code in `testMySegnet.m` to test the trained network and compute metrics.

### Pretrained models

- Download the [pretrained models](https://drive.google.com/drive/folders/1SZ-o2a0VBJTlzp6MzsbLA05MX1hjT1UD?usp=sharing). Please, note that they can only be used for non-commercial uses.
- Choose the suitable network: `trainedNetwork_indoor.mat` and `trainedNetwork_outdoor.mat` are the trained networks for indoor and outdoor areas that we chose.
- Load the appropriate model into the MATLAB command window and then [query the network](#query-trained-network) with images in the "photos" folder, which contains real photos taken directly with a camera.

### Query trained network

Run the code in `semanticseg_newImage.m` to query the trained network and get the network output and the label overlay, which is an overlap of input and output based on a colormap. 
The colormap is defined in `myColorMap.m`. 

The function `pixelLabelColorbar.m` is useful to add a colorbar to the current axis. 
The colorbar is formatted to display the class names with the colors.

The function `preprocessImage.m` is used to resize the input image before passing it to the network, according to the image size defined in the input layer.

## Dataset

We will release our dataset for encouraging future research on human segmentation. 
Please send an email to monica.gruosso@unibas.it if you need it for academic research and non-commercial purposes.

Before requesting our data, please verify that you understand and agree to comply with the following:
- This data may ONLY be used for non-commercial uses (This also means that it cannot be used to train models for commercial use).
- You may NOT redistribute the dataset. This includes posting it on a website or sending it to others.
- You may include images from our dataset in academic papers.
- Any publications utilizing this dataset have to reference our paper.
- These restrictions include not just the images in their current form but any images created from these images (i.e. “derivative” images).
- Models trained using our data may only be distributed (posted on the internet or given to others) under the condition that the model can only be used for non-commercial uses.


## Citation

If you use the code or the data for your research, please cite the paper:

```
@article{gruosso2020human,
  title={Human segmentation in surveillance video with deep learning},
  author={Gruosso, Monica and Capece, Nicola and Erra, Ugo},
  journal={Multimedia Tools and Applications},
  pages={1--25},
  year={2020},
  publisher={Springer}
}
```
