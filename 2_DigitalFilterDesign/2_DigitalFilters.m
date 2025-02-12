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
% $$ w(n) = \alpha - \beta \sin \left( \frac{2 \pi n}{N-1} \right) $$
%
% where the sample index $n$ goes from $0$ to $N-1$.

%% Bandpass FIR filter
% The bandpass filter passes a band of frequencies between a lower cutoff
% frequency, $f_l$, and an upper cutoff frequency, $f_h$.
%
% In the following example, we design an ideal bandpass filter with the lower
% cutoff frequency of 0.15 and the upper cutoff frequency of 0.25.
%
% *Ideal band-pass FIR filter in time domain*
M = 100;
wa = 0.15 * pi;
wb = 0.25 * pi;
n1 = 0:M;

h1 = ((wb / pi) * sinc(wb / pi * (n1 - M / 2)) - ...
    (wa / pi) * sinc(wa / pi * (n1 - M / 2)));

figure('name', 'Impulse Response of Ideal FIR bandpass filter');
stem(n1, h1, 'linewidth', 1.5);
xlabel('n');
ylabel('h1(n)');
title('Impulse Response of The Ideal Band-pass FIR Filter');
grid on;
%%%
%
% *Ideal band-pass FIR filter in frequency domain*
w_axis = linspace(-pi, pi, 1e3);
DTFT_h1 = h1 * exp(-1j * n1' * w_axis);
figure('name', 'Frequency Response of The Ideal Band-pass FIR Filter');
subplot(211);
plot(w_axis, abs(DTFT_h1), 'linewidth', 1.5);
title('Magnitude Response');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
xlabel('\omega');
ylabel('|H_1(\omega)|');
grid on;

subplot(212);
plot(w_axis, angle(DTFT_h1), 'linewidth', 1.5);
xlabel('\omega');
ylabel('\angle H_1(\omega)');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
title('Phase Response');
grid on;
%%
% We can see that the ideal bandpass filter has a very sharp transition
% between the passband and the stopband. This is not practical for
% implementation. We need to smooth the transition between the passband and
% the stopband. We can do this by using a window function.
%
% In the following example, we use the Hamming window to smooth the
% transition between the passband and the stopband.
%
% *Hamming window in time domain*
hamming_window = 0.54 - 0.46 * sin(2 * pi * n1 / M);

figure('name', 'Impulse Response of The Hamming Window');
stem(n1, hamming_window, 'linewidth', 1.5);
xlabel('n');
ylabel('w(n)');
title('Impulse Response of The Hamming Window');
grid on;
%%%
% *Hamming window in frequency domain*
DTFT_hamming_window = hamming_window * exp(-1j * n1' * w_axis);
figure('name', 'Frequency Response of The Hamming Window');
subplot(211);
plot(w_axis, abs(DTFT_hamming_window), 'linewidth', 1.5);
title('Magnitude Response');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
xlabel('\omega');
ylabel('|W(\omega)|');
grid on;

subplot(212);
plot(w_axis, angle(DTFT_hamming_window), 'linewidth', 1.5);
xlabel('\omega');
ylabel('\angle W(\omega)');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
title('Phase Response');
grid on;
%%%
%
% *Hamming windowed band-pass FIR filter in time domain*
%
h2 = h1 .* hamming_window;
figure('name', 'Impulse Response of The Hamming Windowed Band-pass FIR Filter');
stem(n1, h2, 'linewidth', 1.5);
xlabel('n');
ylabel('h2(n)');
title('Impulse Response of The Hamming Windowed Band-pass FIR Filter');
grid on;
%%%
%
% *Hamming windowed band-pass FIR filter in frequency domain*
%
DTFT_h2 = h2 * exp(-1j * n1' * w_axis);
figure('name', 'Frequency Response of The Hamming Windowed Band-pass FIR Filter');
subplot(211);
plot(w_axis, abs(DTFT_h2), 'linewidth', 1.5);
title('Magnitude Response');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
xlabel('\omega');
ylabel('|H_2(\omega)|');
grid on;

subplot(212);
plot(w_axis, angle(DTFT_h2), 'linewidth', 1.5);
xlabel('\omega');
ylabel('\angle H_2(\omega)');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.2 * pi, 0, 0.2 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/5', '0', '\pi/5', '\pi/2', '\pi'});
title('Phase Response');
grid on;

%% Design filters in the frequency domain using filterDesigner
% # We can design IIR filters in the frequency domain.
% # We use filterDesigner to design IIR filters.
% # We can export the filter coefficients to the workspace.
% # We can also export the filter coefficients to a file.
% # filterDesigner is a graphical user interface (GUI) tool.
% # We can use filterDesigner to design lowpass, highpass, bandpass, and bandstop filters.
% # We can also use filterDesigner to design FIR filters.
%
% *Design a passband filter using filterDesigner*
%
% # Open filterDesigner.
% # Select IIR filter.
% # Select the filter type(passband, lowpass, highpass, bandpass, or bandstop).
% # Select the filter design method(butterworth, chebyshev I, chebyshev II, elliptic, or bessel).
% # Enter the filter order or minimum order.
% # Enter the match exactly on passband or stopband.
% # Enter the frequency specifications. For example, if we use normalized
% frequency, we should specify the angular frequency in the range of $[0, \pi]$.
% We should specify it for stopband and passbands.
% # Enter magnitude specifications. It has different units. We should specify
% it for stopbands and passbands.
%
% *Design a IIR filter using filterDesigner*
%
% According to the filterDesigner, we can design a IIR filter with the
% following specifications:
%
% # Filter type: Bandpass
% # Design method: Elliptic
% # Normalized frequency of stopband 1: $0.45 \pi$
% # Normalized frequency of passband 1: $0.48 \pi$
% # Normalized frequency of passband 2: $0.52 \pi$
% # Normalized frequency of stopband 2: $0.55 \pi$
% # Magnitude of stopband 1: $-40$ dB
% # Magnitude of passband: $-1$ dB
% # Magnitude of stopband 2: $-40$ dB
%
% The following figure shows the setup of the filterDesigner and the magnitude
% frequency response of the designed filter.
figure('name', 'Magnitude Frequency Response of The Designed IIR Filter');
imshow('./images/Bandpass_Elliptic_IIR_filter.png');
%%%
%
% *Design a FIR filter using filterDesigner*
%
% According to the filterDesigner, we can design a FIR filter with the
% following specifications:
%
% # Filter type: Bandpass
% # Design method: Generalized Equiripple
% # Density factor: 20
% # PHase: Linear
% # Normalized frequency of stopband 1: $0.45 \pi$
% # Normalized frequency of passband 1: $0.48 \pi$
% # Normalized frequency of passband 2: $0.52 \pi$
% # Normalized frequency of stopband 2: $0.55 \pi$
% # Magnitude of stopband 1: $-40$ dB
% # Magnitude of passband: $-1$ dB
% # Magnitude of stopband 2: $-40$ dB
%
% The following figure shows the setup of the filterDesigner and the magnitude
% frequency response of the designed filter.
figure('name', 'Magnitude Frequency Response of The Designed FIR Filter');
imshow('./images/Bandpass_GeneralizedEquiripple_FIR_filter.png');
%%%
% We should save our design in the filterDesigner. To do this, we should press
% |ctrl + s| or go to the File menu and select "Save".
%
% *Export the filter*
%
% We can export the filter function to a MATLAB file. To do this,
% we should go to the File menu and select "Generate MATLAB Code".
% Then, we should select "Filter Design Function" and save the file.
%
% |File $\rightarrow$ Generate MATLAB Code $\rightarrow$ Filter Design Function|
%
% We can also save the filter to a MAT file. To do this, we should go to the
% File menu and select "Export...", then we should select "MAT-File" and
% "Coefficients" and save the file.
%
% |File $\rightarrow$ Export... $\rightarrow$ MAT-File $\rightarrow$ Coefficients|
%
% To load the filter, we should use the |load| function.
% The following code loads the filter.
%
FIR_Filter_Coefficients = ...
    load('./filters/Bandpass_GeneralizedEquiripple_FIR_filter.mat').Num;
%%%
% The second argument of the |load| function is the name of the workspace variable
% that we want to load from the MAT file.
%
% To use the filter function we should write the following code:
%
addpath('./filters');
FIR_Filter = Bandpass_GeneralizedEquiripple_FIR_filter;
IIR_Filter = Bandpass_Elliptic_IIR_filter;
%%%
%
% *Filter the signal*
%
% We can filter the signal using the filter function.
% We should pass the filter function and the signal to the filter function.
% The following code filters the signal using the filter function.
%
n = 0:500;
x = sin(0.1 * pi * n) + sin(0.5 * pi * n) + sin(0.3 * pi * n);
y1 = FIR_Filter.filter(x);
y2 = IIR_Filter.filter(x);

figure('name', 'Filtering the signal using the filter function');
subplot(211);
stem(n, x, 'linewidth', 1.5);
xlabel('n');
ylabel('x(n)');
title('Input Signal');
grid on;

subplot(212);
stem(n, y1, 'linewidth', 1.5);
xlabel('n');
ylabel('y(n)');
title('Output Signals');
grid on;
hold on;
stem(n, y2, 'linewidth', 1.5);
hold on;
stem(n, sin(0.5 * pi * n), 'linewidth', 1.5);
legend('Output of FIR Filter', 'Output of IIR Filter', 'Desired Signal');
%%%
%
% *Frequency response of the designed filters*؛
% We can plot the frequency response of the designed filters.
% We should pass the filter function to the freqz function.
% The following code plots the frequency response of the designed filters.
%
f_axis = linspace(0, 1, 1e4);
Impulse_Response_FIR_Filter = FIR_Filter.Numerator;
n = 0:length(Impulse_Response_FIR_Filter) - 1;
kernel = exp(-1j * n' * f_axis * pi);
DTFT_FIR_Filter = Impulse_Response_FIR_Filter * kernel;
figure('name', 'Frequency Response of The FIR Filter');
subplot(211);
plot(f_axis, 20 * log10(abs(DTFT_FIR_Filter)), 'linewidth', 1.5);
title('Magnitude Response of The FIR Filter');
xlabel('Normalized Frequency(\times\pi rad/sample)');
ylabel('|10log_{10}H(\omega)|');
xlim([0 1]);
ylim([-70 10]);
grid on;
subplot(212);
plot(f_axis, unwrap(phase(DTFT_FIR_Filter)), 'linewidth', 1.5);
title('Phase Response of The FIR Filter');
xlabel('Normalized Frequency(\times\pi rad/sample)');
ylabel('\angle H(\omega)');
grid on;
%%%
% To plot the frequency response of the IIR filter, we should pass the
% filter function to the freqz function.
% The following code plots the frequency response of the IIR filter.
%
[H, w] = freqz(IIR_Filter, 1e4);
figure('name', 'Frequency Response of The IIR Filter');
subplot(211);
plot(w / pi, 20 * log10(abs(H)), 'linewidth', 1.5);
title('Magnitude Response of The IIR Filter');
xlabel('Normalized Frequency(\times\pi rad/sample)');
ylabel('|10log_{10}H(\omega)|');
xlim([0 1]);
ylim([-70 10]);
grid on;
subplot(212);
plot(w / pi, unwrap(angle(H)), 'linewidth', 1.5);
title('Phase Response of The IIR Filter');
xlabel('Normalized Frequency(\times\pi rad/sample)');
ylabel('\angle H(\omega)');
grid on;
%%%
%% Analyze filters using Filter Visualization Tool
% # We can analyze the filters using the Filter Visualization Tool.
% # We can use the Filter Visualization Tool to analyze the magnitude and phase response of the filters.
% # We can also use the Filter Visualization Tool to analyze the impulse and step response of the filters.
% # We can also use the Filter Visualization Tool to analyze the pole-zero plot of the filters.
% # We can also use the Filter Visualization Tool to analyze the group delay of the filters.
%
% The following figures shows the magnitude and phase response of the IIR filter.
% We used the command |IIR_Filter.freqz| to plot the magnitude and phase response of the IIR filter.
figure('name', 'Magnitude and Phase Response of The IIR Filter');
imshow('./images/FilterVisualizationTool_IIR_freqz.png');
%%%
% The following figures shows the impulse response of the IIR filter.
% We used the command |IIR_Filter.impz| to plot the impulse response of the IIR filter.
figure('name', 'Impulse Response of The IIR Filter');
imshow('./images/FilterVisualizationTool_IIR_impz.png');
%%%
% The following figures shows the pole-zero plot of the IIR filter.
% We used the command |IIR_Filter.zplane| to plot the pole-zero plot of the IIR filter.
figure('name', 'Pole-Zero Plot of The IIR Filter');
imshow('./images/FilterVisualizationTool_IIR_zplane.png');
%%%
