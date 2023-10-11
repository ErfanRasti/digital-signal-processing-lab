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
