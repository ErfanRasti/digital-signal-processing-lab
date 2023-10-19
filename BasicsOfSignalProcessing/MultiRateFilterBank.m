%% *Multi Rate Filter Bank*
%% Clear the workspace
close all;
clear;
clc;

%% What is a multi rate filter bank?
% # A multi rate filter bank consists of a set of filters that are used to
% decompose a signal into a set of subbands.
% # The subbands are then downsampled to reduce the sampling rate.
% # Then some operations are performed on the subbands and then the
% subbands are upsampled and combined to form the original signal.
% # The operations performed on the subbands are usually
% different for different subbands.
% # The operations performed on the subbands are usually some kind of
% compression or expansion.
% # Filter banks are used in many applications like audio compression,
% image compression, video compression, etc.
% # Filter banks are highly related to wavelets. Wavelets are a special case of
% filter banks.
% # The only difference between analysis and synthesis filter banks is in
% phase shift.
% # The downsampling and upsampling operations are called the
% polyphase decomposition and polyphase reconstruction respectively.
% # The downsampling operation is necessary to prevent aliasing.
% If there is no downsampling, then the output of the filter bank will be
% aliased(because of the overlap between the subbands).
%% Load the excel file containing the filters
% # The excel file contains the filter coefficients for the filter bank
% The filter bank is a 32 channel filter bank.
% # There are 4 subbands in each channel. The subbands are obtained
% by downsampling the output of the filter bank.
% # There are 4 filters in each sheet of the excel file.
% # To read the excel file, we use the |readmatrix| function.
% # To specify the sheet number, we use the |'Sheet'| name-value pair.
%% Downsample the signal
% # The signal is downsampled by a factor of number of channels in the filter
% bank.
% # We use the |downsample| function to downsample the signal.
% # The |downsample| function takes the signal and the downsampling factor
% as input arguments.
%% Upsample the signal
% # The signal is upsampled by a factor of number of channels in the filter
% bank.
% # We use the |upsample| function to upsample the signal.
% # The |upsample| function takes the signal and the upsampling factor
% as input arguments.
