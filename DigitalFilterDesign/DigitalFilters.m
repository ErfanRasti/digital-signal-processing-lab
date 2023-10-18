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
ax = gca;
ax.XAxis.FontSize = 8;
w_axis = linspace(-pi, pi, 1e3);
DTFT_h1 = h1 * exp(-1j * n1' * w_axis);
figure('name', 'Frequency Response of The Ideal Band-pass FIR Filter');
subplot(211);
plot(w_axis, abs(DTFT_h1), 'linewidth', 1.5);
title('Magnitude Response');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.25 * pi, 0, 0.25 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '\pi'});
xlabel('\omega');
ylabel('|H_1(\omega)|');
grid on;

subplot(212);
plot(w_axis, angle(DTFT_h1), 'linewidth', 1.5);
xlabel('\omega');
ylabel('\angle H_1(\omega)');
xlim([-pi pi]);
xticks([-pi, -pi / 2, -0.25 * pi, 0, 0.25 * pi, pi / 2, pi]);
xticklabels({'-\pi', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '\pi'});
title('Phase of DTFT');
grid on;
%%%
% We can see that the ideal bandpass filter has a very sharp transition
% between the passband and the stopband. This is not practical for
% implementation. We need to smooth the transition between the passband and
% the stopband. We can do this by using a window function.
%
% In the following example, we use the Hamming window to smooth the
% transition between the passband and the stopband.

hamming_window = 0.54 - 0.46 * sin(2 * pi * n1 / M);
h2 = h1 .* hamming_window;
