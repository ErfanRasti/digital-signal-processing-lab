%% * Signal Enhancement And Noise Reduction *
%% Clear the workspace
close all;
clear;
clc;
%% IIR Filter Design
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
%
%% Filter Design Considerations for Single Tone Signal
% We will design an IIR filter for a single tone signal. The single tone
% signal is given by:
%
% $$s(n) = A\cos(w_0n)$$
%
% where $A$ is the amplitude of the signal and $w_0$ is the angular frequency
% of the signal.
%
% We consider
%
% $$A = 1, w_0=2\pi f_0/f_s$$
%
% where $f_0$ is the frequency of the signal and $f_s$ is the sampling
% frequency.
% We add AWGN to the signal. The signal is given by:
% $$x(n) = s(n) + v(n)$$
%
% where $v(n)$ is the AWGN.
%
% The signal is passed through the filter. The output of the filter is
% given by:
%
% $$y(n) = h(n)*x(n)$$
%
% where $h(n)$ is the impulse response of the filter.
%
% # To design a filter that amplifies the signal and attenuates the noise, we
% should design a resonator.
% # The resonator is a bandpass filter.
% # The resonator should have a narrow bandwidth.
% # The resonator should have a flat passband.
% # The resonator should have a steep stopband.
% # The resonator should have a center frequency equal to the frequency of
% the input signal($f_0$).
% # The resonator should have a gain of 1 at the center frequency.
% # The resonator should have a gain of 0 at the stopband.
