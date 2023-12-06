%% *Image Analyzing*
%% Clear the workspace and the command window
close all;
clear;
clc;

%% Read the image
% The first step to analyze an image is to read it.
% The |imread| function reads the image from the file specified by the
% string filename, inferring the format of the file from its contents.
% |imread| supports a variety of graphics file formats and returns the
% image.
img = imread('coins.png');

%% Display the image
% The |imshow| function displays the image in the current axes. The image
% is displayed at the resolution of the screen. The image is automatically
% scaled to fit the screen if its size is larger than the screen.
figure('Name', 'Original Image');
imshow(img);

%% Convert the image to scaled double precision
% The |im2double| function converts the image to double precision, scaling
% the data to the range [0, 1]. If the input image is of class double, the
% output image is identical to it.
img = im2double(img);
