%% *Convolution Operator Implementation*
%% Clear the workspace
close all;
clear;
clc;

%% Discrete Convolution Operator
% The discrete convolution operator is defined as
%
% $$y[n] = \sum_{k=-\infty}^{\infty} x[k]h[n-k]$$
%
% where $x[n]$ is the input signal, $h[n]$ is the impulse response, and
% $y[n]$ is the output signal. The convolution operator is commutative,
% meaning that
%
% $$x[n]*h[n] = h[n]*x[n]$$
%
% The convolution operator is implemented in MATLAB using the |conv|
% function. The |conv| function takes two vectors as inputs and returns the
% convolution of the two vectors. The length of the output vector is equal
% to the sum of the lengths of the input vectors minus one.
%% Implementation
% # According to the formula of the convlution, we should flip one of the vectors.
% # To flip the vector in MATLAB, we use the |fliplr| function.
% # According to the final lengtyh of the output vector, we should pad two vectors
% with zeros to reach the same length of the output vector.
% # To shift the reversed vector, we use the |circshift| function.
% This function shifts the elements in the vector by a specified number of
% positions.
% # We should only use one for loop to calculate the convolution.

%% nth order derivative filter
% To generate the nth order derivative filter, we can use a for loop and repeat
% the convolution for n times. The result of the convolution is the nth order
% derivative filter.
