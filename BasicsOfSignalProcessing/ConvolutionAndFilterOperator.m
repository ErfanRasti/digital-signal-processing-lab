%% *Basics of Signal Processing - Convolution and Filter Operators*
%% Clear the workspace
close all;
clear;
clc;

%% Convolution Operator
% The convolution operator is a very important operator in signal processing.
% It is used to filter signals and to find the impulse response of systems.
% The convolution of two signals $x(t)$ and $y(t)$ is defined as
%
% $$x(t) * y(t) = \int_{-\infty}^{\infty} x(\tau) y(t-\tau) d\tau$$
%
% * The convolution operator is commutative, i.e. $x(t) * y(t) = y(t) * x(t)$.
% * It is also associative, i.e. $(x(t) * y(t)) * z(t) = x(t) * (y(t) * z(t))$.
% * The convolution operator is linear, i.e. $a x(t) * y(t) + b z(t) * y(t) = a (x(t) + b z(t)) * y(t)$.
%
% The convolution operator is implemented in MATLAB as |conv|.
% The following example shows the convolution of two rectangular pulses.
fs = 1000; % Sampling frequency
Ts = 1 / fs; % Sampling time
t = 0:Ts:2; % Time axis
xt = rectpuls(t - 0.5, 1); % Rectangular pulse x(t)
yt = rectpuls(t - 1.5, 1); % Rectangular pulse y(t)
zt = conv(xt, yt) * Ts; % Convolution of xt and yt
tz = 0:Ts:4; % Time axis
figure('Name', 'Convolution Operator');
subplot(3, 1, 1);
plot(t, xt, 'LineWidth', 1.5);
title('x(t)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([0 1.1]);
grid on;
subplot(3, 1, 2);
plot(t, yt, 'LineWidth', 1.5);
title('y(t)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([0 1.1]);
grid on;
subplot(3, 1, 3);
plot(tz, zt, 'LineWidth', 1.5);
title('z(t) = x(t) * y(t)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([0 1.1]);
grid on;

%% Convolution of Signals with Different Lengths
% |conv| function in MATLAB has another syntax which is |conv(x, y, 'same')|.
% This syntax returns the central part of the convolution with the same length
% as the first input signal.
% The following example shows the convolution of two rectangular pulses with
% different lengths.

%% Filter Operator
% * The filter operator is a special case of the convolution operator.
% It is used to filter signals.
% * It is defined in MATLAB as |filter(b, a, x)| where |b| and |a| are the
% coefficients of the numerator and denominator of the transfer function of
% the filter respectively.
% * To create a moving average filter, the numerator coefficients are set to
% $b = \frac{1}{N} \left[1, 1, \ldots, 1\right]$ and the denominator
% coefficients are set to $a = 1$.
% * The |filter| function excludes the transient response of the filter
% from the output signal and the phase of the output signal is not affected.
