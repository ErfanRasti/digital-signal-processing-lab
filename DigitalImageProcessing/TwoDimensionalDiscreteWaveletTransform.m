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
