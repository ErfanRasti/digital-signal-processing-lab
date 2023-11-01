%% *Digital Filters*
%% Clear the workspace
close all;
clear;
clc;
%% Why do we need filters?
% STFT is a powerful tool for analyzing non-stationary signals. However, it
% is not always the best tool for the job. STFT has two main drawbacks:
% # The choice of the window length is not obvious. If the window is too
% short, the resolution in the frequency domain is poor(It won't detect any
% special pattern). If the window is too long, the resolution in the time
% domain is poor(It won't distinguish between different events in time).
% # The STFT has the term complex exponential in it. This terms is a priodic
% function and time unlimited. However, in real life signals, we are interested
% in the signal only for a finite time interval. This property of STFT causes
% the spectrum of time limited signals to be unbounded in a wide range of
% frequencies.
%
% This two drawbacks leads to the need of a new tool for analyzing
% non-stationary signals. We should use different window lengths for
% different parts of the signal. We should also use a time limited term
% instead of the complex exponential. This is where the wavelet transform
% comes in.
