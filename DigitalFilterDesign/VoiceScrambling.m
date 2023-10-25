%% *Voice Scrambing*
%% Clear the workspace
close all;
clear;
clc;
%% Load the audio file
% # Too load the audio file, use the |audioread| function.
% # The audio file is stored in the variable |y| and the sampling frequency
% is stored in the variable |fs|.
% # We can specify the start and end points of the audio file to be read
% using the |audioread| function. It takes the start and end points as
% a vector in the form |[start end]|. The second argument is the samples range.
%  # |y| is an column vector of size |N x 1|, where |N| is the number of samples.
% So, we should use the transpose operator |'| to convert it to a row vector.
% # To define the time axis, we use the |linspace| function. It takes the
% start and end points as well as the number of points to be generated.
% The start point is |0| and the end point is |N/fs|, where |N| is the number
% of samples and |fs| is the sampling frequency. The number of points is |N|.
%
% The following code loads the audio file and defines the time axis.
% |[x_t, fs] = audioread('Audio01.wav');|
%
% |x_t = x_t';|
%
% |t_axis = linspace(0, length(x_t) / fs, length(x_t));|

%% Sound the audio file
% # To sound the audio file, use the |sound| function. It takes the audio
% signal and the sampling frequency as arguments.
% # To prevent the sound from being cut, we should wait until the sound
% finishes. We can do this using the |pause| function. It takes the time
% to wait in seconds as an argument.
%
% The following code sounds the audio file.
% |sound(x_t, fs);|
%
% |pause(length(x_t) / fs);|
