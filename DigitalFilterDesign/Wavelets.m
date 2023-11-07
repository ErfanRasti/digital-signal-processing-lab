%% *Digital Filters*
%% Clear the workspace
close all;
clear;
clc;
%% Why STFT is not enough?
% STFT is a powerful tool for analyzing non-stationary signals. However, it
% is not always the best tool for the job. STFT has two main drawbacks:
%
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
% * These two drawbacks leads to the need of a new tool for analyzing
% non-stationary signals.
% * We should use different window lengths for different parts of the signal.
% * We should also use a time limited basis function instead of the complex
% exponential. This is where the wavelet transform comes in.
%
%% Replacement of frequency domain
%
% * According to the second drawback of STFT, we need to use a time limited
% basis function instead of the complex exponential. This means that the new
% basis function is not periodic which means that we can't use the
% frequency domain to analyze the signal(Because the frequency domain is
% based on the complex exponential and periodicity).
% * We should analyze what interesting features are captured by the complex
% exponential. The complex exponential is a basis function for the
% frequency domain. If the signal is periodic with the frequency of
% * $f_0$, then the complex exponential will have a peak at $f_0$. the second
% harmonic will have a peak at $2f_0$ and so on.
% * The relations between
% different harmonics is the concept that we should capture in the new
% basis function.
%
% *Warping the time axis* is the key to capture the relations between
% different harmonics. The new basis function should be a time limited
% function that is warped in time. For example if we replace $t$ with
% $2t$ in the original signal $x(t)$, then the second harmoinc will be
% captured in the new signal.
%
% We claim that the main characteristic of harmonic frequencies can be drawn
% from a more general concept that we call _*"scale"*_. The interesting part is
% that unlike frequency that is defined only for periodic signals, scale is
% equally applicable to non-periodic signals. This proves that we have found
% a new concept, i.e., scale, to replace frequency.
%
% Using _scale_ as a variable, the new transform, which will be based on
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
% $$\Psi(t)=\frac{2}{\sqrt{3a}\pi^{1/4}}\left(1-\frac{t^2}{a^2}\right)e^{\frac{-t^2}/{2a^2}}$$
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
title('Mexican Hat Wavelet');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% There are many other mother wavelets. The most important ones are:
%
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
% Daubechies wavelets are the most popular wavelets:
%
% * They are orthogonal wavelets. Orthogonal wavelets are used in image compression.
% * They are indicated by dbX, where X is the number of vanishing moments.
% * The number of vanishing moments is the number of derivatives of the
% wavelet function that are zero at the origin.
% * The more complex the signal, the more vanishing moments are needed to
% capture its features.
%
% To choose the best wavelet for a specific application, we should consider
% the following factors:
%
% # complex mother wavelets are needed for complex signals.
% # the mother wavelet that resembles the general shape of the signal to be
% analyzed would be a more suitable choice.
%
% One of the most important properties of the wavelet transform is the
% area below the wavelet function. The area below the wavelet function
% should be equal to zero. This property is called the zero mean property.
%
% $$\int_{-\infty}^{\infty}\Psi(t)dt=0$$
%
%% One-dimensional Discrete Wavelet Transform
% * A closer look at the CWT reveals that this transformation requires the
% calculations based on all continuous shifts and all continuous scales.
% * This obviously makes the computational complexity of the CWT and the ICWT
% unsuitable for many practically important applications.
% * This leads us to the discrete version of this transform.
%
% We define sampled versions of the scale and translation parameters as:
%
% $$a_{jk}=a_0^j,k=0,1,...,M-1,j=0,1,...,N-1$$
%
% $$b_{jk}=ka_0^jT,k=0,1,...,M-1,j=0,1,...,N-1$$
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
% * A relevant question at this point is: _"How to choose the number of basis
% functions for a given signal?"_
% * A frame is a set of basis functions that can be used to decompose a signal.
% * This set can be minimal or nonminimal, i.e., if the number of basis functions
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
%
% In the case of a basis (i.e., a minimal frame), the values A and B in the
% aforementioned inequality become the same, i.e., $A = B$.
% This means that for a basis we have
%
% $$\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}|W_{\Psi, X}(j,k)|^2=E_x$$
%
% This indicates the energy of the coefficients is exactly the same as the energy of the
% signal.
% This is a very important property of the wavelet transform.
%
% The next important question to ask here is: "What are the properties of the
% functions that allow the function sets to form a basis?" The most popular
% basis sets are the orthogonal ones, i.e., the function
% sets whose members are orthogonal to each other.
%
%% Discrete Wavelet Transform on Discrete Signals
% # We need to focus on calculating DWT from discrete signals. At this point,
% we assume that the discrete signal, if sampled from a continuous
% signal, has been sampled according to the Nyquist rate (or faster).
% This guarantees that all information of the continuous signal is preserved in
% the discrete signal.
% # The question here is: _"How to form such basis sets systematically?"_
% # The method described next, called Mallat pyramidal algorithm or quadrature
% mirror filter (QMF), allows systematic creation of an unlimited number of
% orthogonal basis sets for DWT.
% # The interesting feature of this method is the fact that the method relies
% only on the choice of a digital low-pass filter $h(n)$, and once this filter
% is chosen, the entire algorithm is rather mechanical and straightforward.
%
% Assuming a digital filter $h(n)$, we form another filter $g(n)$ as follows:
%
% $$g(n)=h(2N-1-n),n=0,1,...,2N-1$$
%
% It can be proved that once $h(n)$ is a low-pass filter, $g(n)$ is a high-pass filter.
%
% The schematic diagram of the Mallat pyramidal algorithm is shown below:
figure('Name', 'Mallat Pyramidal Algorithm');
imshow('./images/DWT_QMF_Algorithm.png');
%%%
% # The first step in transformation is filtering the signal once with the
% low-pass filter $h(n)$ and once with the high-pass filter $g(n)$.
% # Then the filtered versions of the signal are downsampled by a factor of 2.
% This means that every other samples of the signal are preserved and the
% remaining samples are discarded.
%
% We can also ask another relevant question about downsampling: _"How would
% downsampling fit into the general ideas of the DWT?"_
% Without getting into the mathematical details of the process, one can see
% that downsampling somehow creates the description of the signal at a
% different scale and resolution.
% Now we should consider the mother wavelet of QMF algorithm.
% The mother wavelet of the QMF algorithm is defined as:
%
% $$\Psi(n)=\sum_{k=0}^{2N-1}g(k)\Phi(2n-k)$$
%
% where
%
% $$\Phi(n)=\sum_{k=0}^{2N-1}h(k)\Phi(2n-k)$$
%
% * The function $\Phi(n)$ is called the scaling function.
% * The scaling function is a low-pass filter that is used to reconstruct the
% signal from the wavelet coefficients.
% * The scaling function is also called the *father wavelet*.
%
% It can be shown that all popular wavelets are derived from the QMF algorithm.
%
% Now we should ask another question: _"How many decomposition levels are needed
% for a suitable transform?"_ An intuitive criterion to choose the level of the
% decomposition would be continuing decomposition until the highest known
% frequencies in the signal of interest are extracted and identified.
%
% Now we define inverse DWT algorithm. The inverse DWT algorithm is shown below:
figure('Name', 'Inverse DWT Algorithm');
imshow('./images/IDWT_QMF_Algorithm.png');
%%%
% The inverse DWT algorithm is the reverse of the forward DWT algorithm.
%
% The filters $h(n)$ and $g(n)$ are called the analysis filters.
% The filters $h_1(n)$ and $g_1(n)$ are called the synthesis filters.
% $h_1(n)$ and $g_1(n)$ can be derived from $h(n)$ and $g(n)$:
%
% $$h_1(n)=(-1)^(1-n)h(1-n)$$
%
% and
%
% $$g_1(n)=h(2N-1-n)$$
%
% * An interesting feature of the DWT and IDWT is the possibility of
% reconstructing the signal only based on a few of the levels (scales)
% of decomposition.
% * For example, if we want to extract only the main trend
% of the signal and ignore the medium and fast variations, we can easily
% decompose the signal to several levels using DWT, but use only the first
% (or first few) low-pass components to reconstruct the signal using IDWT.
% This allows bypassing the medium- and high-frequency components.
% * Similarly, if the objective is to extract only the fast variations of signal,
% in the reconstruction phase, we can easily set the coefficients of the low
% frequency (high scales) to zero while calculating the IDWT.
%
%% |wnoise| function
% The |wnoise| function is used to add white noise to a signal.
% The syntax of this function is:
%
% |[x, noisy_x] = wnoise(fun, n, sqrtsnr, seed)|
%
% * |x|: The original signal
% * |noisy_x|: The noisy signal
% * |fun|: The function that generates the signal
% * |n|: The nummber of iterations(power of 2 $log_2(numberOfSamples)$)
% * |sqrtsnr|: The square root of the signal to noise ratio
% * |seed|: The seed of the random number generator
%
N = 8;
loc = linspace(0, 1, 2 ^ N);
Ts = loc(2) - loc(1);
fs = 1 / Ts;
sqrtsnr = 10;
[x, noisy_x] = wnoise('heavy sine', N, sqrtsnr);
figure('Name', 'Heavy Sine Signal vs Heavy Sine Signal with White Noise');
subplot(211);
plot(loc, x, 'LineWidth', 1.5);
title('Heavy Sine Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
subplot(212);
plot(loc, noisy_x, 'LineWidth', 1.5);
title('Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
figure('Name', 'Spectrum of Heavy Sine Signal With and Without White Noise');
subplot(211);
plot_dft_amp(x, fs, 'Frequency Spectrum of input signal without noise');
subplot(212);
plot_dft_amp(noisy_x, fs, 'Frequency Spectrum of input signal with noise');
%%%
% For more information about the |wnoise| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wnoise.html |wnoise|>
% documentation.
%
%% |dwt| function
% The |dwt| function is used to decompose a signal using DWT in one level.
% It implements Multilevel 1-D wavelet decomposition.
%
% The syntax of this function is:
%
% |[cA, cD] = dwt(x, waveletName)|
%
% * |cA|: The approximation coefficients
% * |cD|: The detail coefficients
% * |x|: The original signal
% * |waveletName|: The name of the wavelet
%
% The diagram of the DWT is shown below:
figure('Name', 'DWT Diagram');
imshow('./images/dwt_diagram.png');
%%%
% The following code uses the |dwt| function to decompose the noisy signal
% to approximation and detail coefficients using the db3 wavelet.
[cA, cD] = dwt(noisy_x, 'db3');
figure('Name', 'Approximation and Detail Coefficients');
subplot(211);
plot(cA, 'LineWidth', 1.5);
title('Approximation Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
subplot(212);
plot(cD, 'LineWidth', 1.5);
title('Detail Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |dwt| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/dwt.html |dwt|>
% documentation.
%
%% |idwt| function
% The |idwt| function is used to reconstruct a signal using DWT.
% It implements Multilevel 1-D wavelet reconstruction.
%
% The syntax of this function is:
%
% |x = idwt(cA, cD, waveletName)|
%
% * |x|: The reconstructed signal
% * |cA|: The approximation coefficients
% * |cD|: The detail coefficients
% * |waveletName|: The name of the wavelet
%
% The diagram of the IDWT is shown below:
figure('Name', 'IDWT Diagram');
imshow('./images/idwt_diagram.png');
% |wkeep| block is used to keep the central part of the signal with
% convenient length.
%%%
% The following code uses the |idwt| function to reconstruct the noisy signal
% using the approximation and detail coefficients using the db3 wavelet.
reconstructed_x = idwt(cA, cD, 'db3');
figure('Name', 'Reconstructed Heavy Sine Signal with White Noise');
plot(loc, reconstructed_x, 'LineWidth', 1.5);
title('Reconstructed Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%

%% |wavedec| function
% The |wavedec| function is used to decompose a signal using DWT.
% It implements Multilevel 1-D wavelet transform.
%
% The syntax of this function is:
%
% |[waveletCoefficients, waveletLevels] = wavedec(x, numberOfLevels, waveletName)|
%
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |x|: The original signal
% * |numberOfLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
%
% The graph of the wavelet coefficients is shown below:
figure('Name', 'Wavelet Coefficients Graph');
imshow('./images/wavedec_graph.png');
%%%
% In each level of decomposition, the signal is decomposed to approximation
% coefficients and detail coefficients. The approximation coefficients are
% the low frequency components of the signal and the detail coefficients are
% the high frequency components of the signal.
%
% Approximation coefficients then are decomposed to approximation and detail
% coefficients in the next level of decomposition. This process continues
% until the specified number of levels is reached.
%
% The stage diagram of the wavelet decomposition in each level is shown below:
figure('Name', 'Wavelet Decomposition Stage Diagram');
imshow('./images/wavedec_stage_diagram.png');
%%%
% The following code uses the |wavedec| function to decompose the noisy
% signal to 5 levels of decomposition using the db3 wavelet.
numberOfLevels = 5;
[waveletCoefficients, waveletLevels] = wavedec(noisy_x, 5, 'db3');
figure('Name', 'Wavelet Coefficients');
stem(waveletCoefficients, 'LineWidth', 1.5);
title('Wavelet Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;

%%%
% The |wavedec| function returns the wavelet coefficients of the signal
% decomposed to the specified number of levels using the specified wavelet.
%
% For more information about the |wavedec| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wavedec.html |wavedec|>
% documentation.
%
%% |detcoef| function
% The |detcoef| function is used to extract the detail wavelet coefficients
% of a specific level or levels of decomposition. It returns $cDx$ which is the
% detail coefficients of the specified level or levels of decomposition.
%
% The syntax of this function is:
%
% |detailed_coeff = detcoef(waveletCoefficients, waveletLevels, levels_to_extract)|
%
% * |detailed_coeff|: The wavelet coefficients of the specified level or levels
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |levels_to_extract|: The levels to extract
%
detailed_coeff = detcoef(waveletCoefficients, waveletLevels, 1:numberOfLevels);
figure('Name', 'Wavelet Coefficients of Different Levels');
set(gcf, 'Position', [100, 100, 1000, 1000]);

for i = 1:numberOfLevels
    subplot(numberOfLevels, 1, i);
    stem(detailed_coeff{i}, 'LineWidth', 1.5);
    title(['Wavelet Coefficients of Level ', num2str(i)]);
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
end

%%%
% For more information about the |detcoef| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/detcoef.html |detcoef|>
% documentation.
%
%% |appcoef| function
% The |appcoef| function is used to extract the approximation coefficients
% from the wavelet coefficients. It returns $cAx$ which is the approximation
% coefficients of the specified level or levels of decomposition.
%
% The syntax of this function is:
%
% |approx_coeff = appcoef(waveletCoefficients, waveletLevels, waveletName, levels_to_extract)|
%
% * |approx_coeff|: The approximation coefficients
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
% * |levels_to_reconstruct|: The levels to reconstruct(0 for the original signal)
%
approx_coeff = appcoef(waveletCoefficients, waveletLevels, 'db3', 2);
figure('Name', 'Approximation Coefficients');
plot(approx_coeff, 'LineWidth', 1.5);
title('Approximation Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |appcoef| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/appcoef.html |appcoef|>
% documentation.
%
%% Regenerat Wavelet Coefficients from Approximation and Detail Coefficients
% The following code regenerates the wavelet coefficients from the
% approximation and detail coefficients.
%
% First we should extract the approximation coefficients of the last level
% of decomposition.
approx_coeff_deepest_ayer = appcoef( ...
    waveletCoefficients, ...
    waveletLevels, ...
    'db3', ...
    numberOfLevels ...
);
%%%
% Then we should extract the detail coefficients of different layers and
% concatenate them. Finally we should concatenate the approximation
% coefficients of the last layer to the detail coefficients.

wavelet_coefficients_regenerated = ...
    [approx_coeff_deepest_ayer, detailed_coeff{numberOfLevels:-1:1}];
%%%
% Now we should compare the regenerated wavelet coefficients with the
% original wavelet coefficients.
fprintf("\nError: %d\n", ...
    sum(abs(wavelet_coefficients_regenerated - waveletCoefficients)));
figure('Name', 'Wavelet Coefficients vs Regenerated Wavelet Coefficients');
subplot(211);
stem(waveletCoefficients, 'LineWidth', 1.5);
title('Wavelet Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis tight;
subplot(212);
stem(wavelet_coefficients_regenerated, 'LineWidth', 1.5);
title('Regenerated Wavelet Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis tight;
%%%
%% |waverec| function
% The |waverec| function is used to reconstruct a signal using approximation
% and detail coefficients. It returns $x$ which is the reconstructed signal.
% It implements Multilevel 1-D wavelet reconstruction. It acts as the inverse
% of the |wavedec| function.
%
% The syntax of this function is:
%
% |x = waverec(waveletCoefficients, waveletLevels, waveletName)|
%
% * |x|: The reconstructed signal
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
%
% The following code uses the |waverec| function to reconstruct the noisy
% signal using the wavelet coefficients and the db3 wavelet.
reconstructed_x = waverec(waveletCoefficients, waveletLevels, 'db3');
figure('Name', 'Reconstructed Heavy Sine Signal with White Noise');
plot(loc, reconstructed_x, 'LineWidth', 1.5);
title('Reconstructed Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |waverec| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/waverec.html |waverec|>
% documentation.
%
%% |wrcoef| function
% The |wrcoef| function is used to reconstruct a single branch of the
% wavelet decomposition tree. It returns $x$ which is the reconstructed signal.
%
% The syntax of this function is:
%
% |x = wrcoef(type, waveletCoefficients, waveletLevels, waveletName, levels_to_reconstruct)|
%
% * |x|: The reconstructed signal
% * |type|: The type of the branch to reconstruct
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
% * |levels_to_reconstruct|: The levels to reconstruct(0 for the original signal)
%
% The following code uses the |wrcoef| function to reconstruct the noisy
% signal using the approximation and detail coefficients of the last level
% of decomposition and the db3 wavelet.
reconstructed_x = wrcoef('a', waveletCoefficients, waveletLevels, 'db3', 0);
figure('Name', 'Reconstructed Heavy Sine Signal with White Noise');
plot(loc, reconstructed_x, 'LineWidth', 1.5);
title('Reconstructed Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |wrcoef| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wrcoef.html |wrcoef|>
% documentation.
%
%% |wenergy| function
% The |wenergy| function is used to calculate the energy of the wavelet
% coefficients.
%
% The syntax of this function is:
%
% |energy = wenergy(waveletCoefficients, waveletLevels)|
%
% * |energy|: The energy of the wavelet coefficients
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
%
energy = wenergy(waveletCoefficients, waveletLevels);
fprintf("\nEnergy of the wavelet coefficients: %d\n", energy);
%%%
% For more information about the |wenergy| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wenergy.html |wenergy|>
% documentation.
%
%% |wnoisest| function
% The |wnoisest| function is used to estimate the noise energy of the
% wavelet coefficients.
%
% The syntax of this function is:
%
% |noise_energy = wnoisest(waveletCoefficients, waveletLevels, level_to_estimate)|
%
% * |noise_energy|: The noise energy of the wavelet coefficients
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |level_to_estimate|: The level to estimate
%
noise_energy = wnoisest(waveletCoefficients, waveletLevels, 1:numberOfLevels);
fprintf("\nNoise energy of the wavelet coefficients: %d\n", noise_energy);
%%%
% For more information about the |wnoisest| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wnoisest.html |wnoisest|>
% documentation.
%
%% Noise filtering using wavelet coefficients
% To filter the noise from the signal, we should set the wavelet coefficients
% of the noisy signal to zero and then reconstruct the signal using the
% |waverec| function.
%
% We should continue this process until the energy of the wavelet
% coefficients is less than the noise energy.
%
% Intuitively, we should contiue decomposition until the shape of the
% approximation coefficients is similar to the shape of the original signal.
%
% The following code filters the noise from the noisy signal using the
% wavelet coefficients.
%
% First we should calculate the energy of the wavelet coefficients.
energy = wenergy(waveletCoefficients, waveletLevels);
%%%
% Then we should calculate the noise energy of the wavelet coefficients.
noise_energy = wnoisest(waveletCoefficients, waveletLevels, 1:numberOfLevels);
%%%
% Then we should set the wavelet coefficients of the noisy signal to zero
% and reconstruct the signal using the |waverec| function.

figure('Name', 'Approximation Coefficients of Different Levels');

for level = 1:numberOfLevels
    subplot(numberOfLevels, 1, level);
    set(gcf, 'Position', [100, 100, 1000, 1000]);
    approx = appcoef(waveletCoefficients, waveletLevels, 'db3', level);
    plot(approx, 'LineWidth', 1.5);
    title(['Approximation Coefficients of Level ', num2str(level)]);
    xlabel('Samples');
    ylabel('Amplitude');
    grid on;
end

%%%
% We can see that the shape of the approximation coefficients of the layer 3
% and so on is similar to the shape of the original signal.
% So we should replace the detail coefficients of layers one, two and three
% with zeros and reconstruct the signal using the |waverec| function.
for level = 1:3
    detailed_coeff{level} = zeros(size(detailed_coeff{level}));
end

wavelet_coefficients_denoised = ...
    [approx_coeff_deepest_ayer, detailed_coeff{numberOfLevels:-1:1}];

x_denoised = waverec(wavelet_coefficients_denoised, waveletLevels, 'db3');
figure('Name', 'Denoised Heavy Sine Signal');
title('Denoised Heavy Sine Signal');
xlabel('Time');
ylabel('Amplitude');
plot(loc, x, 'LineWidth', 1.5);
hold on;
grid on;
plot(loc, x_denoised, 'LineWidth', 1.5);
legend('Original Signal', 'Denoised Signal');
%%%
% We can see that the denoised signal is very similar to the original signal.
%
% There are other methods to filter the noise from the signal using the
% wavelet coefficients. This method is not the best method.

%% |wdenoise| function
% The |wdenoise| function is used to denoise a signal using DWT.
%
% The syntax of this function is:
%
% |denoised_x = wdenoise(noisy_x, waveletLevels, waveletName)|
%
% * |denoised_x|: The denoised signal
% * |noisy_x|: The noisy signal
% * |waveletLevels|: The number of levels of decomposition
% * |Wavelet|: The name of the wavelet
%
denoised_x = wdenoise(noisy_x, 8, Wavelet = 'db3');
figure('Name', 'Heavy Sine Signal with White Noise vs Denoised Heavy Sine Signal');
subplot(211);
plot(loc, noisy_x, 'LineWidth', 1.5);
title('Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(212);
title('Denoised Heavy Sine Signal');
xlabel('Time');
ylabel('Amplitude');
plot(loc, x, 'LineWidth', 1.5);
grid on;
hold on;
plot(loc, denoised_x, 'LineWidth', 1.5);
legend('Original Signal', 'Denoised Signal');
%%%
% For more information about the |wdenoise| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wdenoise.html |wdenoise|>
% documentation.
%
%% Functions
% We used the following function to plot differnt plots with an arbitrary title:
function plot_dft_amp(x, fs, title_name)
    % Plots the amplitude spectrum of the signal x with sampling frequency fs
    % and title title_name.
    f_axis = linspace(-fs / 2, fs / 2, length(x));
    FT_x = fftshift(fft(x)) / fs;
    plot( ...
        f_axis, ...
        abs(FT_x), ...
        'LineWidth', ...
        1.5 ...
    );
    xlabel('Frequency(Hz)');
    title(title_name);
    ylabel('Amplitude');
    axis tight;
    grid on;
end
