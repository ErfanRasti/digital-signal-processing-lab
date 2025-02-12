%% 2-Dimensional Discrete Wavelet Transform
%% Clear the workspace and the command window
close all;
clear;
clc;
%% Derivation of the 2-D DWT
% The 2-D DWT is derived from the 1-D DWT by applying the 1-D DWT to the
% rows of the image, and then to the columns of the resulting image. The
% 2-D DWT is a separable transform, which means that it can be expressed as
% a product of two 1-D DWTs. The 2-D DWT is a lossy compression technique
% that is used for image compression. The 2-D DWT is used in JPEG2000
% image compression. The 2-D DWT is also used in the SPIHT, EZW, and
% SPECK image compression algorithms.
%
% The 2-D DWT can be expressed as a product of two 1-D DWTs as follows:
%
% $$\mathbf{W} = \mathbf{W}_1 \mathbf{W}_2$$
%
% where $\mathbf{W}_1$ is the 1-D DWT applied to the rows of the image, and
% $\mathbf{W}_2$ is the 1-D DWT applied to the columns of the image.
%
% The 2-D DWT can be expressed as a matrix multiplication as follows:
%
% $$\mathbf{W} = \mathbf{H} \mathbf{X} \mathbf{H}^T$$
%
% where $\mathbf{H}$ is the 2-D DWT matrix, $\mathbf{X}$ is the image
% matrix, and $\mathbf{W}$ is the 2-D DWT of the image matrix.
%
%% 2-D DWT Algorithm
% The 2-D DWT algorithm is as follows:
%
% # Apply the 1-D DWT to the rows of the image.
% # Apply the 1-D DWT to the columns of the resulting images
%
% The Algorithm is shown in the following figure:
%
imshow('images/2d_dwt_algorithm.png');
%%%
% # Apply low pass filter and high pass filter to the rows of the image and
% create two branches of the image.
% # Downsample the two branches of the image by a factor of 2 across the
% columns(keep only the even columns).
% # Apply low pass filter and high pass filter to the columns of the image
% and create four branches of the image.
% # Downsample the four branches of the image by a factor of 2 across the
% rows(keep only the even rows).
%
% According to the above algorithm, number of pixels of each of the
% coefficients of final decomposed image is quarter of the original image.
% So the total number of pixels of all coefficients is equal to the number of
% pixels of the original image.
%
% The final output consists of four subbands: LL, LH, HL, and HH.
%
% * The LL subband is the approximation coefficients of the original image.
% * The LH subband is the horizontal detail coefficients of the original
% image.
% * The HL subband is the vertical detail coefficients of the original
% image.
% * The HH subband is the diagonal detail coefficients of the original
% image.
%
% LH subband can be used to reconstruct the horizontal edges of the image.
% HL subband can be used to reconstruct the vertical edges of the image.
%
% The above explanations contain one level of decomposition. The 2-D DWT
% can be applied recursively to the LL subband to obtain more levels of
% decomposition.
%
%% |dwt2| function
% The |dwt2| function in MATLAB is used to perform the 2-D DWT. The
% |dwt2| function is used as follows:
%
% |[cA,cH,cV,cD] = dwt2(X,wname)|
%
% where |X| is the input image, |wname| is the wavelet name, |cA| is the
% approximation coefficients, |cH| is the horizontal detail coefficients,
% |cV| is the vertical detail coefficients, and |cD| is the diagonal detail
% coefficients.
%

