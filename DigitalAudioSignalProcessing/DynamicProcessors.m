%% *Dynamic Processors*
%% Clear the workspace and the command window
close all;
clear;
clc;

%% Dynamic Interval of The Signal
% It is the ratio of the maximum amplitude of the signal to the maximum
% amplitude of the signal. It is a dimensionless quantity. It also can be
% shown in dB.
%%
%% Diagram of Dynamic Processor
% * It consists of a level detector and gain processor.
% * The level detector measures the level of the input signal and the gain
% processor adjusts the gain of the signal according to the level detector.
% * The gain processor can be a compressor or an expander.
% * The compressor reduces the gain of the signal and the expander increases
% the gain of the signal.
% * The compressor is used to reduce the dynamic range of the signal and the
% expander is used to increase the dynamic range of the signal.
imshow('./images/DynamicProcessor.png');
%% Level Detector
% The level detector measures the level of the input signal.
% The level detector have 3 different types:
% # Peak detector
% # Envelope detector
% # RMS detector
%
% The related equations are as below:
%
% $$Peak Detector: y(n) = |x(n)|$$
%
% $$Envelope Detector: y(n) = \lambda y(n-1) + (1-\lambda)|x(n)|$$
%
% $$RMS Detector: y(n) = \lambda y(n-1) + (1-\lambda)|x(n)|^2$$
%
