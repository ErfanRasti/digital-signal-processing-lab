%% * Signal Enhancement And Noise Reduction *
%% Clear the workspace
close all;
clear;
clc;

% To Design an optimal filter for a communication system, we need to know
% the characteristics of the signal and noise. We should know the bandwidth
% of the input signal. According to the bandwidth of the input signal, we
% can design the filter. The filter should be designed in such a way that
% it should pass the signal and attenuate the noise. So there are two
% key factors to design the filter:
%
% # The filter should attenuate the noise as much as possible.
% # The input signal should be passed through the filter without any
% attenuation and distortion. The only possible change in the signal is
% the phase shift.
% # The passband of the filter should be flat and the stopband should
% be as steep as possible.
% # The bandwidth of the filter should be as narrow as possible.
% # The bandwith of the input signal should be less than the bandwidth
% of the filter.
% # The center frequency of the filter should be equal to the center
% frequency of the input signal.
%
% We usually consider the channel noise as additive white gaussian noise
% (AWGN). The noise is added to the signal at the receiver. The noise
% power is usually given in terms of noise power spectral density (PSD).
% The power of the noise is distributed uniformly over the entire
% frequency axis. The noise power spectral density is given by:
%
% $$N_0 = \frac{N}{2}$$
%
% where N is the noise power.
%
% *Note:* The total power of the noise should be reduced after passing
% through the filter; because the noise is attenuated by the filter and the
% only passed part of the noise is in the passband of the filter.

