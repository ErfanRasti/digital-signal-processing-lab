%% *Short-time Fourier Transform*
%% Clear the workspace
close all;
clear;
clc;
%% |chirp| function
% The |chirp| function generates samples of a linear swept-frequency
% cosine signal. The |chirp| function is used to simulate a radar pulse.
% The |chirp| function is defined as follows:
%
% $$x(t) = \cos(2\pi f_0 t + \pi \beta t^2 + \phi_0)$$
%
% where
%
% * $f_0$ is the instantaneous frequency at time $t=0$.
% * $\beta$ is the rate of change of the instantaneous frequency.
% * $\phi_0$ is the initial phase of the signal.
%
% We can also define the chirp signal as a function of frequency:
%
% $$x(t) = \cos(\Phi(t))$$
%
% where
% $f(t) = f_0 + \beta t$ is the instantaneous frequency at time $t$.
%
% and
%
% $\Phi(t) = \Phi_0 + 2\pi \int_0^t f(\tau) d\tau$ is the instantaneous phase at time $t$.
%
% where
%
% * $f(t) = f_0 + \beta t$ is the instantaneous frequency at time $t$.
% * $\beta = \frac{f_1 - f_0}{T}$ is the rate of change of the instantaneous frequency.
% * $\phi_0$ is the initial phase of the signal.
% * $f_0$ is the initial frequency of the signal.
% * $f_1$ is the final frequency of the signal.
% * $T$ is the duration of reaching from $f_0$ to $f_1$.
%
% To implement the chirp signal, we use the |chirp| function. The |chirp|
% function is defined as follows:
%
% |y = chirp(t,f_0,t_1,f_1)|
%
% where
%
% * $t$ is the time vector.
% * $f_0$ is the initial frequency of the signal.
% * $f_1$ is the final frequency of the signal.
% * $t_1$ is the time for reaching the final frequency.
%
%% Short-time Fourier Transform
% The short-time Fourier transform (STFT) is a Fourier-related transform
% used to determine the sinusoidal frequency and phase content of local
% sections of a signal as it changes over time. In practice, the procedure
% for computing STFTs is to divide a longer time signal into shorter
% segments of equal length and then compute the Fourier transform
% separately on each shorter segment. This reveals the Fourier spectrum on
% each shorter segment. One then usually plots the changing spectra as a
% function of time, as this will reveal frequency content that is varying
% with time. The STFT is used in many areas of engineering, especially for
% analyzing signals that change over time. It is a type of time-frequency
% analysis.
%
% The STFT of a discrete-time signal $x[n]$ is defined as follows:
%
% $$X[m,k] = \sum_{n=0}^{N-1} x[n] w[n-m] e^{-j\frac{2\pi}{N}kn}$$
%
% where
%
% * $x[n]$ is the discrete-time signal.
% * $w[n]$ is the window function.
% * $N$ is the length of the window.
% * $m$ is the index of the window.
% * $k$ is the index of the frequency.
%
% The STFT of a continuous-time signal $x(t)$ is defined as follows:
%
% $$X(m,\omega) = \int_{-\infty}^{\infty} x(t) w(t-mT) e^{-j\omega t} dt$$
%
% where
%
% * $x(t)$ is the continuous-time signal.
% * $w(t)$ is the window function.
% * $T$ is the sampling period.
% * $m$ is the index of the window.
% * $\omega$ is the frequency.
%
% *Note:* The STFT is a Fourier-related transform, not a Fourier transform.
%
%% |stft| function
% The |stft| function computes the STFT of a discrete-time signal. The
% |stft| function is defined as follows:
%
% |[s, t, f] = stft(x, fs, Window, OverlapLength, FFTLength)|
%
% where
%
% * $x$ is the discrete-time signal.
% * $fs$ is the sampling frequency.
% * $Window$ is the window function.
% * $OverlapLength$ is the overlap length.
% * $FFTLength$ is the FFT length.
% * $FrequencyRange$ is the frequency range.
% * $s$ is the STFT of the signal.
% * $t$ is the time vector.
% * $f$ is the frequency vector.
%
% The following code computes the STFT of a chirp signal.
%
% *Note:* The |stft| function uses the |fft| function to compute the STFT.
N = 2 ^ 11;
t = linspace(0, 1, N);
Ts = t(2) - t(1);
fs = 1 / Ts;
f0 = 100;
f1 = 500;
c = chirp(t, f0, t(end), f1);
[s, t, f] = stft( ...
    c, ...
    fs, ...
    Window = hamming(512), ...
    OverlapLength = 511, ...
    FFTLength = 512, ...
    FrequencyRange = "centered" ...
);
figure('Name', 'Short-time Fourier Transform');
surf(f, t, abs(s), 'EdgeColor', 'none');
axis tight;
colormap(jet);
cb = colorbar;
view([-1, -0.5, 1]);
ylabel(cb, 'Magnitude(Volts/Hz)');
xlabel('Time (Seconds)');
ylabel('Frequency (Hz)');
title('STFT of a Chirp Signal');
%%%
% For a better visualization, we can use the |imagesc| function.
figure('Name', 'Short-time Fourier Transform');
imagesc(f, t, abs(s));
axis xy;
colormap(jet);
cb = colorbar;
ylabel(cb, 'Magnitude(Volts/Hz)');
xlabel('Time (Seconds)');
ylabel('Frequency (Hz)');
title('STFT of a Chirp Signal');
%%%
% For more information check the
% <https://www.mathworks.com/help/signal/ref/stft.html
% stft function documentation>.
%% Spectrogram
%
% To calculate the STFT of a signal, we can use the |spectrogram| function.
% The |spectrogram| function is defined as follows:
%
% |[s, f, t] = spectrogram(x, window, noverlap, nfft, fs, freqrange)|
%
% where
%
% * $x$ is the discrete-time signal.
% * $window$ is the window function.
% * $noverlap$ is the overlap length.
% * $nfft$ is the FFT length.
% * $fs$ is the sampling frequency.
% * $freqrange$ is the frequency range.
% * $s$ is the STFT of the signal.
% * $f$ is the frequency vector.
% * $t$ is the time vector.
%
% *Note:* The |spectrogram| function uses the |stft| function to compute
% the STFT.
N = 2 ^ 12;
t = linspace(0, 1, N);
Ts = t(2) - t(1);
fs = 1 / Ts;
x = exp(1j * pi * 100 * (cos(2 * pi * 2 * t)));
figure('Name', 'Spectrogram of a Chirp Signal');
spectrogram( ...
    x, ...
    hamming(128), ...
    127, ...
    128, ...
    fs, ...
    "centered", ...
    "yaxis" ...
);
%%%
% We can also use the |spectrogram| function in 3D mode.
figure('Name', 'Spectrogram of a Chirp Signal in 3D');
spectrogram( ...
    x, ...
    hamming(128), ...
    127, ...
    128, ...
    fs, ...
    "centered", ...
    "yaxis" ...
);
view(-45, 50);
colormap bone;
%%%
% This is the spectrogram of a signal that the frequency content of the
% signal diverges with time(Why?).
N = 2 ^ 14;
t = linspace(0, 5, N);
Ts = t(2) - t(1);
fs = 1 / Ts;
x = cos(2 * pi * (750 + 10 * cos(2 * pi * 2 * t)) .* t);
figure('Name', 'Spectrogram of a  Signal');
spectrogram( ...
    x, ...
    hamming(128), ...
    127, ...
    128, ...
    fs, ...
    "centered", ...
    "yaxis" ...
);

%%%
% For more information check the
% <https://www.mathworks.com/help/signal/ref/spectrogram.html
% spectrogram function documentation>.
