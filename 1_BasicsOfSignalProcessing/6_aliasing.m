%% *Aliasing*
%% Clear the workspace
close all;
clear;
clc;

%% What is aliasing?
% *Nyquist-Shannon sampling theorem:* If a function $x(t)$ contains no frequencies
% higher than $B$ Hz, it is completely determined by giving its ordinates at a
% series of points spaced $1/(2B)$ seconds apart.
%
% *Proof:* Let $x(t)$ be a bandlimited function with Fourier transform $X(f)$.
% Then $X(f)$ is zero for $|f| > B$. $x_s(t) = x(t) \cdot s(t)$ is the sampled
% version of $x(t)$, where $s(t)$ is a train of impulses spaced $T_s$ seconds
% apart. The Fourier transform of $x_s(t)$ is $X_s(f) = X(f) * S(f)$, where $S(f)$
% is the Fourier transform of $s(t)$. $S(f)$ is a train of impulses spaced
% $1/T_s Hz$ apart. As log as the $X(f)$ is zero for $|f| > B$, $X_s(f)$ is
% a train of $X(f)$ spaced $1/T_s$ Hz apart. If $T_s = 1/(2B)$, then the $X(f)$s in
% $X_s(f)$ are spaced $1/(2B)$ Hz apart, and $X_s(f)$ contains all the information
% in $X(f)$. Therefore, $x_s(t)$ contains all the information in $x(t)$.
%
% *Aliasing:* If $x(t)$ is not bandlimited, then $X(f)$ is not zero for $|f| > B$ or
% $T_s > 1/(2B)$. In this case, $X_s(f)$ is not a train of $X(f)$ spaced $1/T_s$
% Hz apart. The $X(f)s$ in $X_s(f)$ overlap, and $X_s(f)$ does not contain all
% the information in $X(f)$. Therefore, $x_s(t)$ does not contain all the
% information in $x(t)$. This is called aliasing.
%
% *Reconstruction:* If $x(t)$ is bandlimited, then $x(t)$ can be reconstructed
% from $x_s(t)$ by passing $x_s(t)$ through a lowpass filter with cutoff
% frequency $B$ Hz. This is called reconstruction.
%
% The filter only filters one period of the sampled signal in the frequency
% domain. The filter is a sinc function in the time domain. The sinc function
% has infinite duration. Therefore, the filter cannot be implemented in practice.
% Instead, a practical filter is used. The practical filter is a windowed sinc
% function. The windowed sinc function has finite duration. The windowed sinc
% function is called a *reconstruction filter*.

%% Aliasing in the time domain
% In time domain we sample the signal at a rate $f_s$ and we get the sampled
% signal $x_s(t)$. The sampled signal is a train of impulses spaced $1/f_s$
% seconds apart. The sampled signal is a multiplication of the original signal
% $x(t)$ and the train of impulses $s(t)$.
%
% We don't need to multiply the signal with the train of impulses. We just need
% to sample the signal at a rate $f_s$ and we get the sampled signal $x_s(t)$.
%
% In this example, we sample a sinusoid at a rate $f_s = 1$ Hz. The sinusoid
% frequency is $f = 0.5$ Hz. The sampled signal is a train of impulses spaced
% $1/f_s = 1$ seconds apart.

fs = 100;
t = 0:1/fs:2;
f0 = 0.5;
x_original = cos(2*pi*f0*t);

fs_low = 0.5;
t_sampled = 0:1/fs_low:2;
x_sampled = cos(2*pi*f0*t_sampled);

figure('Name', 'Aliasing in the time domain');
plot(t, x_original, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original signal');
grid on;
hold on;
plot(t_sampled, x_sampled, 'o','LineWidth', 2);
legend('Original signal', 'Sampled signal');
%%%
% To reconstruct the signal with higher resolution, we need to add more samples.
% we add some zero samples between the |x_sampled|. we define a variable called
% |prc_rate| which is the rate of precision. The higher the |prc_rate|
% the higher the precision of reconstruction.
%
% We define the time vector $t_1$ with higher resolution. We define the signal
% $x_1$ with higher resolution. We add the samples of |x_sampled| to $x_1$ with
% the rate of |prc_rate|. We add the zero samples to $x_1$ with the rate of
% |prc_rate|. We define the sinc function $h$ with higher resolution.
%
% We can see the aliasing in the reconstructed signal. The reconstructed signal
% is not the same as the original signal.
prc_rate = 100;
t1 = -2:1 / (prc_rate * fs_low):2;
x1 = zeros(1, (length(t1) + 1) / 2);
x1(1:prc_rate:end) = x_sampled;

h = sinc(fs_low * t1);
y = conv(x1, h, 'same');

plot(t1((length(t1) + 1) / 2:end), y, 'LineWidth', 1.5);
legend('Original signal', 'Sampled signal', 'Reconstructed signal')

%% Aliasing in frequency domain
% In frequency domain we should check the spectrum of the signal. and the
% spectrum of the sampled signal. The spectrum of the sampled signal should be
% the periodic repetition of the spectrum of the original signal. If the
% sampling rate is lower than the Nyquist rate, the spectrum of the sampled
% signal will overlap with the spectrum of the original signal. This is called
% aliasing.
fs = 500;
Ts = 1/500;

t = -1:Ts:1;
f0 = 20;
x = cos(2*pi*f0*t);
N = length(x);
sampling_frq = 100;

f_axis = linspace(-fs / 2, fs / 2, N);
FT_x = fftshift(fft(x))/fs;
sampled_signal = zeros(1, N);
sampled_signal(1:fs / sampling_frq:end) = x(1:fs / sampling_frq:end);
FT_sampled_signal = 1 / sampling_frq * fftshift(fft(sampled_signal));
figure('Name', 'Aliasing in frequency domain');
subplot(2, 1, 1);
plot(f_axis, abs(FT_x), 'LineWidth', 1.5);
xlabel('Frequency(Hz)');
ylabel('Amplitude(Volt./sec.)');
title('Spectrum of original signal');
grid on;
subplot(2, 1, 2);
plot(f_axis, abs(FT_sampled_signal), 'LineWidth', 1.5);
xlabel('Frequency(Hz)');
ylabel('Amplitude(Volt./sec.)');
title('Spectrum of sampled signal');
grid on;
