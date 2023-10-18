%% *Digital Filters*
%% Clear the workspace
close all;
clear;
clc;

%% Design FIR filters in the time domain
% # We can define differnet filters in time domain with finite impulse response (FIR).
% # The filter coefficients are the impulse response of the filter.
% # We cannot design IIR filters in time domain; because the impulse response of IIR filters are infinite.

%% Hamming window
% # The Hamming window is a taper formed by using a weighted cosine.
% # It was first proposed by Richard Hamming in 1950, when he was an employee of Bell Labs.
% # It is used to reduce the noise in the signal.
% # The Hamming window is defined as:
%
% $$ w(n) = \alpha - \beta \cos \left( \frac{2 \pi n}{N-1} \right) $$

%% Bandpass FIR filter
% The bandpass filter passes a band of frequencies between a lower cutoff
% frequency, $f_l$, and an upper cutoff frequency, $f_h$.
%
% In the following example, we design an ideal bandpass filter with the lower
% cutoff frequency of 0.15 and the upper cutoff frequency of 0.25.
