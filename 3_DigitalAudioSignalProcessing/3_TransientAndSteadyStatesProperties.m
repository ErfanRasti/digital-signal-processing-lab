%% Transient and Steady States Properties
%% Clear the workspace and the command window
close all;
clear;
clc;
%% Sinusoidal Response of a Second Order Digital Filter
% According to the previous section, the transfer function of a second order
% digital filter is given by:
%
% $$H(z) = \frac{b_0 + b_1z^{-1} + b_2z^{-2}}{1 + a_1z^{-1} + a_2z^{-2}}$$
%
% * The poles of the transfer function are the roots of the denominator
% polynomial.
% * The zeros of the transfer function are the roots of the
% numerator polynomial.
% * The poles and zeros of the transfer function are complex conjugate pairs.
% * The poles and zeros of the transfer function are located inside the unit
% circle.
%
% So the sinusoidal response of a second order digital filter is given by:
%
% $$x(n) = A\cos(\omega_0n + \phi) \rightarrow
% y(n) = |H(e^{j\omega_0})|A\cos(\omega_0n + \theta_0)
% + B_1 P_1^n+ B_2 P_2^n$$
%
% where $P_1$ and $P_2$ are the poles of the transfer function, $B_1$ and
% $B_2$ are the constants that are determined by the initial conditions.
%
%% Notch Filter(Band-Reject Filter)
% We can design a notch filter by placing the zeros of the transfer function
% at the desired frequency. The transfer function of a notch filter is given
% by:
%
% $$H(z) = \frac{1}{1+\beta}
% \frac{1 - 2\cos(\omega_0)z^{-1} + z^{-2}}
% {1-\frac{2\cos(\omega_0)}{1+\beta}z^{-1} + \frac{1-\beta}{1+\beta}z^{-2}}$$
%
% where $\beta$ is the bandwidth parameter. The poles of the transfer
% function are given by:
%
% $$P_{1,2} = \frac{1-\beta \pm \sqrt{(1-\beta)^2 - 4\beta\cos^2(\omega_0)}}{2(1+\beta)}$$
%
% The notch frequency and the bandwidth of the notch is given by:
%
% $$\omega_0 = \frac{2\pi f_0}{f_s}$$
%
% $$ \Delta \omega = \frac{2\pi \Delta f}{f_s}$$
%
% $$ \beta = \tan(\frac{\Delta \omega}{2})$$
%
% where $f_0$ is the notch frequency, $\Delta f$ is the 3dB bandwidth and
% $f_s$ is the sampling frequency.
%
%% Direct Form II(Canonical Form) of Notch Filter
% To implement the notch filter, we can use the direct form II structure.
% Direct form II is concluded of two parts: feedforward part and feedback
% We can define it as a difference equation:
%
% $$y(n) = b_0x(n) + b_1x(n-1) + b_2x(n-2) - a_1y(n-1) - a_2y(n-2)$$
%
% where $b_0$, $b_1$, $b_2$, $a_1$ and $a_2$ are the filter coefficients.
%
% We use MATLAb simulink to design the canonical form of the notch filter.
% The simulink model is shown below:
%
figure('Name', 'Simulink Model of Notch Filter');
imshow('.\images\NotchFilterH1_directFormII.png');
%%%
% To integrate the simulink model into MATLAB, we should define the coefficients
% of the filter. We can use the following code to define the coefficients:
%
%
N = 200;
n = 0:N;
f0 = 100;
fs = 2000;
w0 = 2 * pi * f0 / fs;
delta_f = 10;
delta_w = 2 * pi * delta_f / fs;
beta = tan(delta_w / 2);
x_delta = zeros(1, N + 1);
x_delta(1) = 1;
b1 = [1 -2 * cos(w0) 1] / (beta + 1);
a1 = [-2 * cos(w0) / (1 + beta) (1 - beta) / (1 + beta)];
w2 = 0;
w1 = 0;
x2 = 0;
x1 = 0;
y_delta = zeros(1, N + 1);

%%%
% Linear buffers are used to store the previous values of the input and
% output signals. The length of the buffers are equal to the order of the
% filter. The initial values of the buffers are zero.
%
% we use $z^{-1}$ and $z^{-2}$ to represent the delay of one and two samples.
%
% The difference equation of the filter can be computed as below:
for i = 1:N + 1
    y_delta(i) = -a1(1) * w1 -a1(2) * w2 + b1(1) * x_delta(i) + b1(2) * x1 + b1(3) * x2;
    w2 = w1;
    w1 = y_delta(i);
    x2 = x1;
    x1 = x_delta(i);
end

%%%
% We can use the following code to plot the frequency response of the
% filter:
%
figure('Name', 'Impulse Responses of the Two Notch Filters');
stem(n, y_delta, "LineWidth", 1.5);
title("Impuulse response of Filter H1 in Time Domain (\Deltaf = 4Hz)");
xlabel("n");
ylabel("Amplitude");
xlim([0 50]);
grid on;

%% Settling Time
% To find the settling time of the filter we should find the last value that
% the difference between the current value and the last value is less than
% the percent of settling time value.
%
% If the settled value of the filtered signal is $y_{settled}$, which is the
% of the unit response of the filter, the settling time is:
%
% $$ n_{settling} = \max\{n: |y(n) - y_{settled}| >= \epsilon\} + 1$$
%
% where $\epsilon$ is the percent of settling time value.
%
% * Lower bandwidths result in longer settling times.
% * Higher sampling frequencies result in shorter settling times.
% We can use the following code to find the settling time of the filter:
%
N = 1e4;
n = 0:N;
x_step = ones(1, N + 1);
w2 = 0;
w1 = 0;
x2 = 0;
x1 = 0;
y_step = zeros(1, N + 1);

for i = 1:N + 1
    y_step(i) = -a1(1) * w1 -a1(2) * w2 + b1(1) * x_step(i) + b1(2) * x1 + b1(3) * x2;
    w2 = w1;
    w1 = y_step(i);
    x2 = x1;
    x1 = x_step(i);
end
settling_time_value = find(abs(y_step - y_step(end)) >= 0.01, 1, 'last') + 1;
figure('Name', 'Step Responses of the Two Notch Filters');
stem(n, y_step, "LineWidth", 1.5);
title("Step Response of Filter H1 in Time Domain (\Deltaf = 4Hz)");
xlabel("n");
ylabel("Amplitude");
xlim([0 200]);
ylim([1 - 0.1, 1 + 0.1]);
grid on;
hold on;
stem(settling_time_value - 1, ...
    y_step(settling_time_value), ...
    "LineWidth", 1.5, "Marker", "o");
text(settling_time_value - 1, ...
    y_step(settling_time_value), ...
    "Settling Time = sample " + (settling_time_value -1), 'position', ...
    [settling_time_value - 1, y_step(settling_time_value) + 0.04]);

%%%
%% Peak Filter(Band-Pass Filter)
% We can design a peak filter by placing the poles of the transfer function
% at the desired frequency. The transfer function of a peak filter is given
% by:
%
% $$H(z) = \frac{\beta}{1+\beta}\dot\frac{1 - z^{-2}}
% {1 - 2\frac{\cos(\omega_0)}{1+\beta}z^{-1} + \frac{1-\beta}{1+\beta}z^{-2}}$$
%
% where
%
% $$\omega_0 = \frac{2\pi f_0}{f_s}$$
%
% $$ \Delta \omega = \frac{2\pi \Delta f}{f_s}$$
%
% $$\beta = \tan(\frac{\Delta \omega}{2})$$.
%
%
% where $f_0$ is the notch frequency, $\Delta f$ is the 3dB bandwidth and
% $f_s$ is the sampling frequency.
