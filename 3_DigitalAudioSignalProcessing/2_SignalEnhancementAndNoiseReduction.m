%% *Signal Enhancement And Noise Reduction*
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
%
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
%
%% Resonator Design
% We will design a resonator for a single tone signal. Resonator should
% two poles and two zeros. The resonator is given by:
%
% $$H(z) = \frac{G}{(1-Re^{j\omega_0}z^{-1})(1-Re^{-j\omega_0}z^{-1})}$$
%
% where $G$ is the gain of the resonator and $R$ is the radius of the
% resonator. The radius of the resonator should be less than 1; otherwise
% the resonator will be unstable.
%
% The resonator should have a gain of 1 at the center frequency
% ($H(e^{j\omega_0})=1$)). The gain of the resonator is given by:
%
% $$G = (1-R)\dot(1-2Rcos(\omega_0)+R^2)^{0.5}$$
%
% We can write the Z-transform of the resonator as:
%
% $$H(z) = \frac{G}{1+\alpha_1z^{-1}+\alpha_2z^{-2}}$$
%
% which
%
% $$\alpha_1 = -2Rcos(\omega_0)$$
%
% $$\alpha_2 = R^2$$
%
% According to this fact the set of alpha values is real, the impulse response
% of the resonator is real. The impulse response of the resonator is given
% by:
%
% $$h(n) = \frac{G}{\sin(\omega_0)}\dot R^n\dot sin(\omega_0n+\omega_0), n=0,1,2,\dots$$
%
% The resonator can be expressed as a difference equation as:
%
% $$y(n) = Gx(n) + \alpha_1y(n-1) + \alpha_2y(n-2)$$
%
% # The resonator is a second order filter.
% # The resonator has two poles and two zeros.
% #The resonator is a recursive filter. The resonator is a IIR filter.
%
% So, we can compute the output of the resonator by using the input and
% previous two outputs. To implement a difference equation using recursive
% formula, we act as follows:
% # Store the previous outputs in registers.
% # Multiply the input with the gain of the resonator and add the previous
% outputs.
% #Update the registers with the new outputs.(Save the new output in the
% first register and shift the previous outputs to the next registers.)
% # Repeat the process for the next input element.
%
%
%% Noise Reduction Ratio(NRR)
% * The noise reduction ratio is a ratio that shows the reduction in the
% noise power after passing through the filter.
% * The noise reduction ratio is calculated by the power of the digital filter.
% Because the power of the filter is equal to the noise power after passing
% through the filter.
% * NRR also can be calculated by the ratio of the noise variance before
% and after passing through the filter.
%
% NRR is defined as:
%
% $$NRR = \frac{\sigma_{y_v}^2}{\sigma_v^2}$$
%
% where $\sigma_{y_v}^2$ is the noise variance after passing through the
% filter and $\sigma_v^2$ is the noise variance before passing through the
% filter.
%
% It also can be written as:
%
% $$NRR = \sum_{k=0}^{N-1}h(k)^2$$
%
% where $h(k)$ is the impulse response of the filter.
%
% *Proof*
% According to the properties of AWGN, the noise variance:
%
% $$\mu_v = 0$$
% $$\mathbb{E}[y(n)] = \mathbb{E}[h(n)*v(n)] = h(n)*\mathbb{E}[v(n)] =
% h(n)*\mathbb{E}[v(n)] = 0$$
%
% $$\sigma_{y_v}^2 = \mathbb{E}[y^2(n)]-
% \underbrace{\mathbb{E}[y(n)]^2}$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \mathbb{E}[(h(n)*v(n))^2]$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \mathbb{E}[\sum_{k=0}^{N-1}h(k)v(n-k)\sum_{l=0}^{N-1}h(l)v(n-l)]$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \mathbb{E}[\sum_{k=0}^{N-1}\sum_{l=0}^{N-1}h(k)h(l)v(n-k)xv(n-l)]$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \sum_{k=0}^{N-1}\sum_{l=0}^{N-1}h(k)h(l)\mathbb{E}[v(n-k)v(n-l)]$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \sum_{k=0}^{N-1}\sum_{l=0}^{N-1}h(k)h(l)\sigma_v^2\delta(k-l)$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \sigma_v^2\sum_{k=0}^{N-1}h(k)\sum_{l=0}^{N-1}h(l)\delta(k-l)$$
%
% $$ \Rightarrow \sigma_{y_v}^2 = \sigma_v^2\sum_{k=0}^{N-1}h(k)^2$$
%
% $$NRR = \frac{\sigma_{y_v}^2}{\sigma_v^2}$$
%
% $$ \Rightarrow NRR = \sum_{k=0}^{N-1}h(k)^2$$
%
