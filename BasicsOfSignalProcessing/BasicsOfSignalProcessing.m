%% *Basics of Signal Processing in Time and frequency domains*
%% Pre-requirements
% * Matlab R2018b or later
% * Signal Processing Toolbox
% * Filter Designer Toolbox
% * <https://code.visualstudio.com/Download Visual Studio Code> (optional)
% * <https://marketplace.visualstudio.com/items?itemName=MathWorks.language-matlab Matlab Official Release Extension for Visual Studio Code> (optional)
% * <https://marketplace.visualstudio.com/items?itemName=AffenWiesel.matlab-formatter Matlab Formatter Extension for Visual Studio Code> (optional)
% * <https://git-scm.com/downloads Git> (optional)

%% Clear the workspace
close all;
clear;
clc;

%% Time axis definition
% Time axis can be defined in two methods.
% (In these methods we consider fixed time interval.)
%
% # Define the time axis based on the sampling frequency or sampling time
% # Define the time axis based on the number of samples
%
% *Time axis based on the sampling frequency or sampling time*
fs = 1000; % Sampling frequency
Ts = 1 / fs; % Sampling time
t = 0:Ts:2; % Time axis
xt = cos(2 * pi * 10 * t); %#ok<NASGU> Signal
%%%
% *Time axis based on the number of samples*
N = 1000; % Number of samples
t = linspace(0, 2, N); % Time axis
Ts = t(2) - t(1); % Sampling time
fs = 1 / Ts; %#ok<NASGU> Sampling frequency

%% Frequency axis definition
% Frequency axis can be defined based on time axis.
% # The sampling frequency should satisfy Nyquist theorem to prevent aliasing.
fs = 100; % Sampling frequency
Ts = 1 / fs; % Sampling time
t = 0:Ts:5; % Time axis
N = length(t); % Number of samples
f_axis = linspace(-fs / 2, fs / 2, N); % Frequency axis
