%% *Fourier Series and Transforms*
%% Clear the workspace
close all;
clear;
clc;

%% Discrete Fourier Transform
% In MATLAB, both time and frequency axes are discrete. So we cannot use
% transforms which are defined for continuous time or frequency.
% The only operation that can be performed discretely in both time and
% frequency domains is Fourier coefficients of discrete time periodic signals.
% The more general form of Fourier series for discrete time periodic signals
% is called Discrete Fourier Transform (DFT).
% The DFT of a discrete time signal $x[n]$ is defined as
% $$X[k] = \sum_{n=0}^{N-1} x[n] e^{-j\frac{2\pi}{N}kn}$$
% where $N$ is the period of the signal.
%
% The inverse DFT is defined as
% $$x[n] = \frac{1}{N} \sum_{k=0}^{N-1} X[k] e^{j\frac{2\pi}{N}kn}$$
%
% The DFT is a linear operation. So, the DFT of a linear combination of
% signals is equal to the linear combination of DFTs of the signals.
%
% In MATLAB the DFT is implemented by the function |fft|. The inverse DFT
% is implemented by the function |ifft|.
% In MATLAB index of the first element of a vector is 1. So, the DFT formula
% in MATLAB is
% $$X[k] = \sum_{n=1}^{N} x[n] e^{-j\frac{2\pi}{N}kn}$$.
% also, the inverse DFT formula in MATLAB is
% $$x[n] = \frac{1}{N} \sum_{k=1}^{N} X[k] e^{j\frac{2\pi}{N}kn}$$.
% So, the DFT of a vector of length $N$ is computed by the command |fft(x, N)|.
% The inverse DFT is computed by the command |ifft(X, N)|.
% The DFT and inverse DFT commands can be used without specifying the length
% of the vector. In this case, the length of the vector is assumed to be the
% length of the vector given as input.
