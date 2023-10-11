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
% $$X[k] = \sum_{n=0}^{N-1} x[n] e^{-j\frac{2\pi}{N}kn}$$
% where $N$ is the period of the signal.
%
% The inverse DFT is defined as
% $$x[n] = \frac{1}{N} \sum_{k=0}^{N-1} X[k] e^{j\frac{2\pi}{N}kn}$$
%
% The DFT is a linear operation. So, the DFT of a linear combination of
% signals is equal to the linear combination of DFTs of the signals.
%
% In MATLAB the DFT is implemented by the function |fft|. The inverse DFT
% is implemented by the function |ifft|.
% In MATLAB index of the first element of a vector is 1. So, the DFT formula
% in MATLAB is
% $$X[k] = \sum_{n=1}^{N} x[n] e^{-j\frac{2\pi}{N}kn}$$.
% also, the inverse DFT formula in MATLAB is
% $$x[n] = \frac{1}{N} \sum_{k=1}^{N} X[k] e^{j\frac{2\pi}{N}kn}$$.
% So, the DFT of a vector of length $N$ is computed by the command |fft(x, N)|.
% The inverse DFT is computed by the command |ifft(X, N)|.
% The DFT and inverse DFT commands can be used without specifying the length
% of the vector. In this case, the length of the vector is assumed to be the
% length of the vector given as input.
%
% Other Fourier operations in MATLAB should be implemented by using the DFT
% and inverse DFT commands. The FFT algorithm is used to compute the DFT.
% The FFT algorithm is a fast algorithm to compute the DFT.

%% Fourier Series of a discrete-time periodic signal
% The Fourier series of a discrete-time periodic signal $x[n]$ is defined as
% $$x[n] = \sum_{k=0}^{N-1} X[k] e^{j\frac{2\pi}{N}kn}$$
% where $N$ is the period of the signal.
%
% The inverse Fourier series is defined as
% $$X[k] = \frac{1}{N} \sum_{n=0}^{N-1} x[n] e^{-j\frac{2\pi}{N}kn}$$
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
2
ylabel('Amplitude');
title('Original Discrete Time Signal');
grid on;
subplot(2, 1, 2);
stem(n, real(x_reconstructed), 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstructed Discrete Time Signal');
grid on;
