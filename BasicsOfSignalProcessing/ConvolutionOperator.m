%% *Basics of Signal Processing - Convolution Operator*
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
