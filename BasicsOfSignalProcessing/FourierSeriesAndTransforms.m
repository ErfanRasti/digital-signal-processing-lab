%% *Fourier Series and Transforms*
%% Clear the workspace
close all;
clear;
clc;

%% Discrete Fourier Transform
% In MATLAB, both time and frequency axes are discrete. So we cannot use
% transforms which are defined for continuous time or frequency.
% The only operation that can be performed discretely in both time and
% frequency domains is Fourier coefficients of discrete-time periodic signals.
% The more general form of Fourier series for discrete-time periodic signals
% is called Discrete Fourier Transform (DFT).
% The DFT of a discrete-time signal $x[n]$ is defined as
%
% $$X[k] = \sum_{n=0}^{N-1} x[n] e^{-j\frac{2\pi}{N}kn}$$
%
% where $N$ is the period of the signal.
%
% The inverse DFT is defined as
%
% $$x[n] = \frac{1}{N} \sum_{k=0}^{N-1} X[k] e^{j\frac{2\pi}{N}kn}$$
%
% The DFT is a linear operation. So, the DFT of a linear combination of
% signals is equal to the linear combination of DFTs of the signals.
%
% In MATLAB the DFT is implemented by the function |fft|. The inverse DFT
% is implemented by the function |ifft|.
% In MATLAB index of the first element of a vector is 1. So, the DFT formula
% in MATLAB is
%
% $$X[k] = \sum_{n=1}^{N} x[n] e^{-j\frac{2\pi}{N}kn}.$$
%
% Also, the inverse DFT formula in MATLAB is
%
% $$x[n] = \frac{1}{N} \sum_{k=1}^{N} X[k] e^{j\frac{2\pi}{N}kn}.$$
%
% So, the DFT of a vector of length $N$ is computed by the command |fft(x, N)|.
% The inverse DFT is computed by the command |ifft(X, N)|.
% The DFT and inverse DFT commands can be used without specifying the length
% of the vector. In this case, the length of the vector is assumed to be the
% length of the vector given as input.
%
% *Note:* In computing the |fft(x, N)| command, the length of the vector $x$ is
% assumed to be $N$. If the length of the vector $x$ is less than $N$, the
% vector is padded with zeros. If the length of the vector $x$ is greater
% than $N$, the vector is truncated.
%
% Other Fourier operations in MATLAB should be implemented by using the DFT
% and inverse DFT commands. The FFT algorithm is used to compute the DFT.
% The FFT algorithm is a fast algorithm to compute the DFT.

%% Fourier Series of a Discrete-time Periodic Signal
% The Fourier series of a discrete-time periodic signal $x[n]$ is defined as
%
% $$x[n] = \sum_{k=0}^{N-1} X[k] e^{j\frac{2\pi}{N}kn}$$
%
% where $N$ is the period of the signal.
%
% The inverse Fourier series is defined as
%
% $$X[k] = \frac{1}{N} \sum_{n=0}^{N-1} x[n] e^{-j\frac{2\pi}{N}kn}.$$
%
% The Fourier series of a discrete-time periodic signal is the DFT of the
% signal. So, the Fourier series of a discrete-time periodic signal can be
% computed by the command |fft|.
% The inverse Fourier series is the inverse DFT of the signal. So, the
% inverse Fourier series of a discrete-time periodic signal can be computed
% by the command |ifft|.
% The following example shows the Fourier series of a discrete-time periodic
% signal.
% The input signal is defined as follows:
N = 1e1;
n = -N:N;
N0 = 5;
M0 = 3;
w0 = 2 * pi / N0;
w = M0 * w0;
x = sin(w * n);
figure('Name', 'Discrete Time Signal');
stem(n, x, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete Time Signal');
grid on;
%%%
% The Fourier series of the of the signal is calculated as follows:
a_k = fft(x(1:N0)) / N0;
k = n(1:N0);
figure('Name', 'Fourier Series of Discrete Time Signal');
stem(k, imag(a_k), 'LineWidth', 1.5);
xlabel('k');
ylabel('Amplitude');
title('Fourier Series of Discrete Time Signal');
grid on;
%%%
% We can construct the signal from its Fourier series as follows:
kernel = exp(1j * w0 * k' * n);
x_reconstructed = a_k * kernel;
figure('Name', 'Reconstructed Discrete Time Signal');
subplot(2, 1, 1);
stem(n, x, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Discrete Time Signal');
grid on;
subplot(2, 1, 2);
stem(n, real(x_reconstructed), 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstructed Discrete Time Signal');
grid on;

%% Fourier Transform of a Discrete-time Signal(DTFT)
% The Fourier transform of a discrete-time signal $x[n]$ is defined as
%
% $$X(e^{j\omega}) = \sum_{n=-\infty}^{\infty} x[n] e^{-j\omega n}.$$
%
% The inverse Fourier transform is defined as
%
% $$x[n] = \frac{1}{2\pi} \int_{-\pi}^{\pi} X(e^{j\omega}) e^{j\omega n} d\omega.$$
%
% We can compute the Fourier transform of a discrete-time signal by using
% the DFT. The Fourier transform of a discrete-time signal is a periodic
% signal with period $2\pi$. We define the Fourier transform of a
% discrete-time signal  in the interval $[-\pi, \pi)$.
%
% The following example shows the Fourier transform of a discrete-time
% signal.
%
% The input signal is defined as follows:
N = 1e3;
n = 0:N;
a = 0.5;
x = a .^ n;
figure('Name', 'Discrete Time Signal');
stem(n, x, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete Time Signal');
grid on;
xlim([-10, 10]);
%%%
% The DTFT of the of the signal is calculated as follows:
N_freq = 1e3;
w_axis = linspace(-pi, pi, N_freq);
DTFT_x = x * exp(-1j * n' * w_axis);
figure('Name', 'DTFT of Discrete Time Signal');
subplot(2, 1, 1);
plot(w_axis, abs(DTFT_x), 'LineWidth', 1.5);
xlabel('Frequency (rad/s)');
ylabel('Amplitude');
title('Absolute Value of DTFT');
xlim([-pi pi]);
xticks([-pi, -pi / 2, 0, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
grid on;
subplot(2, 1, 2);
plot(w_axis, angle(DTFT_x), 'LineWidth', 1.5);
xlabel('Frequency (rad/s)');
ylabel('Phase');
xlim([-pi pi]);
xticks([-pi, -pi / 2, 0, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
title('Phase of DTFT');
grid on;
%%%
% We can calculate the DTFT of a signal using the command |fft| as follows:
DTFT_x = fftshift(fft(x, N_freq));
figure('Name', 'DTFT of Discrete Time Signal');
subplot(2, 1, 1);
plot(w_axis, abs(DTFT_x), 'LineWidth', 1.5);
xlabel('Frequency (rad/s)');
ylabel('Amplitude');
title('Absolute Value of DTFT');
xlim([-pi pi]);
xticks([-pi, -pi / 2, 0, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
grid on;
subplot(2, 1, 2);
plot(w_axis, angle(DTFT_x), 'LineWidth', 1.5);
xlabel('Frequency (rad/s)');
ylabel('Phase');
xlim([-pi pi]);
xticks([-pi, -pi / 2, 0, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});
title('Phase of DTFT');
grid on;
%%%
%% Fourier Transform of Continuous-time Signal
% The Fourier transform of a continuous-time signal $x(t)$ is defined as
%
% $$X(j\Omega) = \int_{-\infty}^{\infty} x(t) e^{-j\Omega t} dt.$$
%
% The inverse Fourier transform is defined as
%
% $$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(j\Omega) e^{j\Omega t} d\Omega.$$.
%
% We can compute the Fourier transform of a continuous-time signal by using
% the DFT.
%
% There are some important points to be considered:
%
% #  In periodic signals, at least one period of the signal should be included in the time axis.
% #   Nyquist theorem should be considered
% (The time axis should be sampled densely enough to avoid aliasing.).
% # The main part of the signal should be included in the time axis
% (For periodic signals, the main part is the period of the signal.).
% # Increasing the sampling frequency $\rightarrow$  Detecting higher frequencies
% # Increasing time axis interval $\rightarrow$ higher resolution in frequency axis
% # The scale of amplitude of the frequency spectrum is not that important.
% # Period of the lowest non-zero frequency $\rightarrow$ Interval of time axis
% # Total number of frequency spectrum samples $\rightarrow$ Total number of time domain samples
% In the formula of FT we have $dt$ in the integral. So, we should multiply
% the result of the DFT by $dt$ to obtain the FT. In MATLAB, $dt$ is the smallest
% difference between two consecutive time samples which is equal to the
% sampling time(or $1 / fs$ where $fs$ is the sampling frequency).
%
% The following example shows the Fourier transform of a continuous-time
% signal but the frequency spectrum is not correct.
fs = 1e3;
t = -1:1 / fs:1;
f0 = 10;
x = cos(2 * pi * f0 * t);
FT_x = fft(x) / fs;
f_axis = linspace(-fs / 2, fs / 2, length(FT_x));
figure('Name', 'Fourier Transform of Continuous Time Signal');
plot(f_axis, abs(FT_x), 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Fourier Transform of Continuous Time Signal');
grid on;
%%%
%
% # |fft| function in matlab is not the same as the definition of FT formula;
% The |fft| in matlab calculated the frequency spectrum from frequency $0$
% to $fs$(according to the |fft| formula).
% But we want to calculate the frequency spectrum from $-f_s / 2$ to
% $fs / 2$. So, we should move the the frequency interval of $f_s/2 \rightarrow f_s$
% to $-f_s/2 \rightarrow 0$. We can do this by using the command |fftshift|.
% #  DFT of a signal is a periodic signal with the period of the sampling
% frequency $f_s$.
% # |fft| function in matlab calculates the DFT of a signal in the interval 0 to fs.
% # |fftshift| function in matlab shifts the frequency spectrum of a signal
% from the interval $0 \rightarrow fs$ to $-fs/2 \rightarrow fs/2$.
% # The amplitude of the frequency spectrum is dependent on the time axis
% interval.
%
% For more accurate results in the frequency spectrum, we should increase
% time axis interval. The following example shows the Fourier transform of
% a continuous-time signal with a longer time axis interval.
fs = 1e3;
t_max = 1e3;
t = -t_max:1 / fs:t_max;
f0 = 10;
x = cos(2 * pi * f0 * t);
FT_x = (1 / fs) * fftshift(fft(x));
f_axis = linspace(-fs / 2, fs / 2, length(FT_x));
figure('Name', 'Fourier Transform of Continuous Time Signal');
plot(f_axis, abs(FT_x), 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Fourier Transform of Continuous Time Signal');
xlim([-20, 20]);
grid on;
%% Fourier Series of Continuous Time Signals
% The Fourier series of a continuous-time periodic signal $x(t)$ is defined as
%
% $$x(t) = \sum_{k=-\infty}^{\infty} X(k\Omega_0) e^{jk\Omega_0 t}$$
%
% where $\Omega_0$ is the fundamental frequency of the signal.
%
% The Fourier coefficients of a continuous-time periodic signal are defined as
%
% $$X(k\Omega_0) = \frac{1}{T_0} \int_{T_0} x(t) e^{-jk\Omega_0 t} dt$$
%
% where $T_0$ is the period of the signal.
%
% There are some important points to be considered:
%
% # 1(Sec.) time interval $\rightarrow$ $f_s$ samples $\Rightarrow$
% $T_0(Sec.)$ time interval $\rightarrow$ $f_s \times T_0$ samples
% # For more terms of Fourier series, we should increase the sampling frequency
% to extend the terms of fft output.
% #  To maximize the number of FS terms, we should take N equal with half
% of the number of fft terms. The ratio of Nyquist boundary is maximum at 1/2.
fs = 1e4;
T_eq = 1;
t = -T_eq:1 / fs:T_eq;
T0 = 0.5;
duty_cycle = 0.25;
square_wave = square(2 * pi * t / T0, duty_cycle * 100);

FT_square_wave = fftshift(fft(square_wave(1:fs * T0))) / (fs * T0); % Consider one period

m0 = 1 + floor((fs * T0) / 2); % Center of the frequency spectrum
ratio_Nyq_boundary = 1/2; % maximum ratio: 0.5
N = floor(T0 * fs * ratio_Nyq_boundary) - 1; % Number of Fourier series terms
a_n = FT_square_wave(m0 - N:m0 + N); % Fourier series coefficients
n = -N:N;
figure('Name', 'Fourier Series of Square Wave');
subplot(211);
stem(n, real(a_n), 'LineWidth', 1.5);
xlabel('n');
ylabel('Amplitude');
title('Real Part of Fourier Series of Square Wave');
xlim([-10 10]);
grid on;
subplot(212);
stem(n, imag(a_n), 'LineWidth', 1.5);
xlabel('n');
ylabel('Amplitude');
title('Imaginary Part of Fourier Series of Square Wave');
xlim([-10 10]);
grid on;
%%%
% *Reconstruction of the square wave from the Fourier series*
t1 = -1:1 / (2 * fs):1; % Why 2*fs?
kernel = exp(1j * 2 * pi * n' * t1 / T0);
x = a_n * kernel;
figure('Name', 'Reconstructed Square Wave');
plot(t, square_wave, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstructed Square Wave');
grid on;
hold on;
plot(t1, real(x), 'LineWidth', 1);
legend('Original Square Wave', 'Reconstructed Square Wave');
xlim([-0.5, 0.5]);
%%%
% *Reconstruction of the square wave directly from the $\textbf a_n$ coefficients*
% According to the following script, we can reconstruct the square wave
% directly from the $a_n$ coefficients.
%
% There are some important points to be considered:
%
% # Increasing the N value will increase the accuracy of the reconstruction.
% However, increasing the N value will also increase the computational
% complexity of the reconstruction.
% # Increasing N will increase the higher frequency components of the signal.
% # We can use the Nyquist-Shannon sampling theorem to determine
% the value of fs.($f_s >= 2 \times N$)
% # If N is not high enough, the reconstruction will not be accurate and
% the Gibbs phenomenon won't be observed.
% # At frequency fs = 2 * N, the signal is sampled at the Nyquist frequency.
% All of the oscillations of the signal are captured. but the signal is not
% very smooth.
T0 = 1;
fs = 1e4;
t = 0:1 / fs:1;
tau = 0.5;
N = 100;
n = -N:N;
a_n = (tau / T0) * sinc(n * tau / T0);
kernel = exp(1j * 2 * pi * n' * t / T0);
x = a_n * kernel;
figure('Name', 'Reconstruction of a continuous time periodic signal using coefficients');
plot(t, real(x), 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstruction of a continuous time periodic signal using coefficients');
grid on;
