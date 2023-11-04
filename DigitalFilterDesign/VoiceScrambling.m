%% *Voice Scrambing*
%% Clear the workspace
close all;
clear;
clc;

%% Voice Scrambling
% Voice scrambling is a technique used to encrypt voice signals. The
% encrypted voice signal is called the cipher signal. The cipher signal is
% transmitted over the communication channel. At the receiver, the cipher
% signal is descrambled to recover the original voice signal. The
% descrambling process is the inverse of the scrambling process. The
% scrambling process is a nonlinear process. It is implemented using a
% nonlinear function. The descrambling process is also a nonlinear process.
% It is implemented using the inverse of the nonlinear function used in the
% scrambling process. The scrambling process is a one-to-one mapping
% process. This means that each sample in the original voice signal is
% mapped to a unique sample in the cipher signal. The descrambling process
% is also a one-to-one mapping process. This means that each sample in the
% cipher signal is mapped to a unique sample in the original voice signal.
%
% Before scrambling a voice signal, we should use a low-pass filter to
% remove the frequencies that are higher than the Nyquist frequency. This
% is because the frequencies that are higher than the Nyquist frequency
% will be aliased. The aliased frequencies will be mixed with the original
% frequencies. This will make the descrambling process more difficult.
%
% To scramble a voice signal, we need to define a nonlinear function. We can
% make a nonlinear function by modulating the voice signal with a sinusoid.
% The sinusoid is called the scrambling sinusoid. The scrambling sinusoid
% is a sinusoid with a frequency that is different from the frequency of
% the voice signal. The scrambling sinusoid is generated using the
% following equation:
%
% $$s(t) = A \cos(\frac{2 \pi f_0 t}{f_s})$$
%
% where |A| is the amplitude of the scrambling sinusoid and |f_s| is its
% frequency. The scrambling sinusoid is modulated with the voice signal
% using the following equation:
%
% $$y(t) = x_{low-passed}(t) \cos(\frac{2 \pi f_0 t}{f_s})$$
%
% where |x(t)| is the voice signal. The scrambling sinusoid is modulated
% with the voice signal using the |.*| operator. The scrambled voice signal
% is stored in the variable |y|. The scrambling sinusoid is stored in the
% variable |s|. The following code scrambles a voice signal.
%
% |y = x_lowpassed .* s;|
%
% The descrambling process is the inverse of the scrambling process. The
% descrambling process is implemented using the following equation:
%
% $$y_2(t) = y(t) \cos(\frac{2 \pi f_0 t}{f_s})$$
%
% The descrambling process is implemented using the |.*| operator. The
% descrambled voice signal is stored in the variable |y_2|. The following
% code descrambles the voice signal.
%
% |y_2 = y .* s;|
%
% After multiplying the voice signal with the scrambling sinusoid, the
% frequencies of the voice signal are shifted to the left and right sides
% of the scrambling sinusoid. The frequencies of the voice signal are
% shifted to the left side of the scrambling sinusoid because the voice
% signal is multiplied with the cosine of the scrambling sinusoid.
% We should perform a low-pass filtering process to remove the frequencies
% that are shifted to the right side of the scrambling sinusoid. This is
% because the frequencies that are shifted to the right side of the
% scrambling sinusoid will be aliased.
%
% $$ x_{reconstructed} = h_{low-passed} * y_2(t)$$
%
% where $h_{low-passed}$ is the impulse response of the low-pass filter. The
% reconstructed voice signal is stored in the variable |x_reconstructed|.
% The following code reconstructs the voice signal.
%% Load the audio file
% # Too load the audio file, use the |audioread| function.
% # The audio file is stored in the variable |y| and the sampling frequency
% is stored in the variable |fs|.
% # We can specify the start and end points of the audio file to be read
% using the |audioread| function. It takes the start and end points as
% a vector in the form |[start end]|. The second argument is the samples range.
%  # |y| is an column vector of size |N x 1|, where |N| is the number of samples.
% So, we should use the transpose operator |'| to convert it to a row vector.
% # To define the time axis, we use the |linspace| function. It takes the
% start and end points as well as the number of points to be generated.
% The start point is |0| and the end point is |N/fs|, where |N| is the number
% of samples and |fs| is the sampling frequency. The number of points is |N|.
%
% The following code loads the audio file and defines the time axis.
%
% |[x_t, fs] = audioread('Audio01.wav');|
%
% |x_t = x_t';|
%
% |t_axis = linspace(0, length(x_t) / fs, length(x_t));|

%% Sound the audio file
% # To sound the audio file, use the |sound| function. It takes the audio
% signal and the sampling frequency as arguments.
% # To prevent the sound from being cut, we should wait until the sound
% finishes. We can do this using the |pause| function. It takes the time
% to wait in seconds as an argument.
%
% The following code sounds the audio file:
%
% |sound(x_t, fs);|
%
% |pause(length(x_t) / fs);|
%%%
%% Implementaion of the scrambling process
% We assume the input signal is a shifted sinc function with scaling factor of
% 0.1 and shift factor of 0.5. The sampling frequency is 100 Hz.
% We know the Fourier transform of the this function in general form is:
%
% $$x(t) = sinc(\frac{t - t_0}{T}) \Rightarrow\mathcal{FT}:
% X(f) = T \cdot \Pi(\frac{f}{T}) \cdot e^{-j 2 \pi f t_0}$$
%
% where $t_0$ is the shift factor and $T$ is the scaling factor.
% The Discrete-Time Fourier Transform (DTFT) of the sampled signal is:
%
% $$x[n] = sinc(\frac{n - n_0}{N}) \Rightarrow\mathcal{DTFT}:
% X(e^{j \omega}) = N \cdot \Pi(\frac{\omega}{N}) \cdot e^{-j \omega n_0}$$
%
% We can analyze a signal in two methods:
%
% *Analog Signal Processing*
%
fs = 100;
t = 0:1 / fs:1;
x = sinc((t - 0.5) / 0.1);
N_freq = 1e4;
f_axis = linspace(-fs / 2, fs / 2, N_freq);
FT_x = fftshift(fft(x, N_freq)) / fs;

figure("Name", "Sampled Signal");
subplot(2, 1, 1);
stem(t, x, 'LineWidth', 1.5);
xlabel("Time (s)");
ylabel("Amplitude");
title("Sampled Signal in Time Domain");
grid on;
subplot(2, 1, 2);
plot(f_axis, abs(FT_x), 'LineWidth', 1.5);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Frequency Spectrum of the Sampled Signal");
grid on;
%%%
% *Digital Signal Processing*
% The sampled signal in the analog signal processing is the same as:
%
% |x = sinc((n / fs - 0.5) / 0.1);|
%
fs = 100;
n = 0:length(t) - 1; % Discrete axis
f_axis = linspace(-fs / 2, fs / 2, N_freq);
FT_x = fftshift(fft(x, N_freq)) / fs;
figure("Name", "Sampled Signal");
subplot(2, 1, 1);
stem(n, x, 'LineWidth', 1.5);
xlabel("Time (s)");
ylabel("Amplitude");
title("Sampled Signal in Time Domain");
grid on;
subplot(2, 1, 2);
plot(f_axis, abs(FT_x), 'LineWidth', 1.5);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Frequency Spectrum of the Sampled Signal");
grid on;
%%%
% We consider digital signal processing in the following.
%
% Now we define a low-pass filter with cutoff frequency of 10 Hz using
% the filter designer tool.
lowpass_filter = load('filters/VoiceScrambling_LP_FIR_filter.mat').Num;
f_axis_pos = f_axis(floor(N_freq / 2) + 1:end);
FT_lowpass_filter = fftshift(fft(lowpass_filter, N_freq));
FT_lowpass_filter = FT_lowpass_filter(floor(N_freq / 2) + 1:end);
figure('Name', 'Low-Pass Filter');
subplot(3, 1, 1);
stem(lowpass_filter, 'LineWidth', 1.5);
xlabel("Samples");
ylabel("Amplitude");
title("Impulse Response of the Low-Pass Filter");
grid on;
subplot(3, 1, 2);
plot(f_axis_pos, 20 * log10(abs(FT_lowpass_filter)), 'LineWidth', 1.5);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Frequency Response of the Low-Pass Filter");
ylim([-70 10]);
grid on;
subplot(3, 1, 3);
plot(f_axis_pos, unwrap(angle(FT_lowpass_filter)), 'LineWidth', 1.5);
xlabel("Frequency (Hz)");
ylabel("Phase (rad)");
title("Phase Response of the Low-Pass Filter");
grid on;
%%%
