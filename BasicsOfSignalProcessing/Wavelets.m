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
% different parts of the signal. We should also use a time limited basis
% function instead of the complex exponential. This is where the wavelet
% transform comes in.
%
%% Replacement of frequency domain
% According to the second drawback of STFT, we need to use a time limited
% basis function instead of the complex exponential. This means that the new
% basis function is not periodic which means that we can't use the
% frequency domain to analyze the signal(Because the frequency domain is
% based on the complex exponential and periodicity).
% We should analyze what interesting features are captured by the complex
% exponential. The complex exponential is a basis function for the
% frequency domain. If thee signal is periodic with the frequency of
% $f_0$, then the complex exponential will have a peak at $f_0$. the second
% harmonic will have a peak at $2f_0$ and so on. The relations between
% different harmonics is the concept that we should capture in the new
% basis function.
%
% Warping the time axis is the key to capture the relations between
% different harmonics. The new basis function should be a time limited
% function that is warped in time. For example if we replace $t$ with
% $2t$ in the original signal $x(t)$, then the second harmoinc will be
% captured in the new signal.
%
% We claim that the main characteristic of harmonic frequencies can be drawn
% from a more general concept that we call "scale". The interesting part is that
% unlike frequency that is defined only for periodic signals, scale is equally
% applicable to nonperiodic signals. This proves that we have found a new
% concept, i.e., scale, to replace frequency.
% Using scale as a variable, the new transform, which will be based on
% time-limited basis function, can be meaningfully applied to both
% time-unlimited and time-limited signals.
%
%% One-dimensional Continuous Wavelet Transform
% The one-dimensional continuous wavelet transform (CWT) of a signal $x(t)$
% is defined as:
%
% $$W_{\Psi, X}(a,b)=\frac{1}{\sqrt{|a|}}\int_{-\infty}^{\infty}x(t)\Psi^*\left(\frac{t-b}{a}\right)dt,a\neq0$$
%
% where $a$ is the scale parameter, $b$ is the translation parameter, and
% $\Psi^*(t)$ is the complex conjugate of the mother wavelet $\Psi(t)$.
%
% A closer look at the definition of the mother wavelet tells that this function
% must be limited in duration and therefore looks like a decaying small wave.
% This is why we call this transform the wavelet transform.
%
% The synthesis equation is:
%
% $$x(t)=\frac{C^{-1}_{\Psi}}{a^2}\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}W_{\Psi, X}(a,b)\Psi\left(\frac{t-b}{a}\right)dadb$$
%
% where $C^{-1}_{\Psi}$ is a constant whose value depends on the exact choice
% of the mother wavelet $\Psi(t)$.
%
% Every choice of the mother wavelet gives a particular CWT, and as a result, we
% are dealing with infinite number of transformations under the same name CWT.
%
%% Mother wavelets
% the mexican hat wavelet is a good choice for the mother wavelet. It is
% defined as:
%
% $$\Psi(t)=\frac{2}{\sqrt{3a}\pi^{1/4}}\left(1-\frac{t^2}{a^2}\right)e^{-t^2/2a^2}$$
%
% The mexican hat wavelet is also known as the Ricker wavelet.
%
% The waveform of the mexican hat wavelet is shown below:
t = -2:0.01:2;
a = 0.5;
Psi = (2 / (sqrt(3 * a) * pi ^ (1/4))) * (1 - (t .^ 2 / a ^ 2)) ...
    .* exp(-t .^ 2 / (2 * a ^ 2));
figure('Name', 'Mexican Hat Wavelet');
plot(t, Psi, 'LineWidth', 1.5);
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% There are many other mother wavelets. The most important ones are:
% # Morlet wavelet
% # Haar wavelet
% # Daubechies wavelet
% # Symlet wavelet
% # Coiflet wavelet
% # Meyer wavelet
% # Gaussian wavelet
% # Mexican hat wavelet
% # Shannon wavelet
%
% Daubechies wavelets are the most popular wavelets. They are orthogonal
% wavelets. Orthogonal wavelets are used in image compression.
% They are indicated by dbX, where X is the number of vanishing moments.
% The number of vanishing moments is the number of derivatives of the
% wavelet function that are zero at the origin.
% The more complex the signal, the more vanishing moments are needed to
% capture its features.
%
% To choose the best wavelet for a specific application, we should consider
% the following factors:
% # complex mother wavelets are needed for complex signals
% # the mother wavelet that resembles the general shape of the signal to be
% analyzed would be a more suitable choice.
%
%% One-dimensional Discrete Wavelet Transform
% A closer look at the CWT revealsthat thistransformation requiresthe
% calculations based on all continuous shifts and all continuous scales.
% This obviously makes the computational complexity of the CWT and the ICWT
% unsuitable for many practically important applications.
% This leads us to the discrete version of this transform.
% We define sampled versions of the scale and translation parameters as:
%
% $$a_{jk}=a_0^j,k=0,1,...,M-1,j=0,1,...,N-1$$
%
% $$b_jk=ka_0^jT,k=0,1,...,M-1,j=0,1,...,N-1$$
%
% where $T$ is the sampling time and $a_0$ is a positive nonzero constant.
%
% Also we define mother wavelet as:
%
% $$\Psi_{jk}(t)=\frac{1}{\sqrt{a_{jk}}}\Psi\left(\frac{t-b_{jk}}{a_{jk}}\right)=a_0^{-j/2}\Psi(a_0^{-j}t-kT)$$
%
% Then the coefficients of the discrete wavelet transform (DWT) are defined as:
%
% $$W_{\Psi, X}(j,k)=\int_{-\infty}^{\infty}x(t)\Psi_{jk}^*\left(t\right)dt$$
%
% This makes the DWT somewhat different from the DFT that accepts only discrete
% signals as its input. The synthesis equation is:
%
% $$x(t)=c\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}W_{\Psi, X}(j,k)\Psi_{jk}(t)$$
%
% where $c$ is a constant that depends on the exact choice of the mother wavelet.
%
% The interesting thing about this equation is the fact that we can reconstruct
% the continuous signal directly from a set of discrete coefficients.
%
%% Minimal set of basis functions
% A relevant question at this point is how to choose the number of basis
% functions for a given signal.
% A frame is a set of basis functions that can be used to decompose a signal.
% This set can be minimal or nonminimal, i.e., if the number of basis functions
% in the frame is minimal and any other frame would need the same
% number or more basis functions, the frame is called a basis.
%
% Consider the energy of the signal $x(t)$:
%
% $$E_x=\int_{-\infty}^{\infty}|x(t)|^2dt$$
%
% It can be proved that there exist some bounded positive values A and B such that:
%
% $$A\int_{-\infty}^{\infty}|x(t)|^2dt\leq\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}|W_{\Psi, X}(j,k)|^2\leq B\int_{-\infty}^{\infty}|x(t)|^2dt$$
%
% This relation intuitively means that the energy of the wavelet coefficients for a frame
% is bounded on both upper and lower sides by the true energy of the signal.
% In the case of a basis (i.e., a minimal frame), the values A and B in the
% aforementioned inequality become the same, i.e., $A = B$.
% This means that for a basis we have
%
% $$\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}|W_{\Psi, X}(j,k)|^2=E_x$$
% This indicates the energy of the coefficients is exactly the same as the energy of the
% signal.
% This is a very important property of the wavelet transform.
%
