%% *Basics of Signal Processing - Basic Signals*
%% Clear the workspace
close all;
clear;
clc;

%% Dirac Delta Function
% The continuous-time dirac delta function is defined as follows:
%
% $$\delta(t) = \begin{cases} 0, & t \neq 0 \\ \infty, & t = 0 \end{cases}$$
%
% The discrete-time dirac delta function is defined as follows:
%
% $$\delta[n] = \begin{cases} 0, & n \neq 0 \\ 1, & n = 0 \end{cases}$$
%
% * The dirac delta function is also known as the unit impulse function.
% * It is a function that is zero everywhere except at the origin, where it is
% infinite.
% * The dirac delta function is used to model a unit impulse in
% signal processing.
% * The dirac delta function is also used to model a
% single sample in discrete-time signal processing.
% * The dirac delta function is used to represent the impulse response of
% an LTI system.
% * The infinity can not be represented in MATLAB. Therefore, we can
% represent the dirac delta function as $1/T_s = f_s$, where $T_s$ is the
% sampling time and $f_s$ is the sampling frequency.
%
% We can define continuous-time dirac delta function as follows:
fs = 1e4;
t = -10:1 / fs:10;
N = length(t);
delta = zeros(N, 1);
delta(t == 0) = fs; % Spike at t = 0
figure('Name', 'Continuous-Time Dirac Delta Function');
plot(t, delta, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Dirac Delta Function');
grid on;

%%%
% We can define discrete-time dirac delta function as follows:
n = -10:10;
N = length(n);
delta = zeros(N, 1);
delta(n == 0) = 1; % Spike at n = 0
figure('Name', 'Discrete-Time Dirac Delta Function');
stem(n, delta, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Dirac Delta Function');
grid on;

%% Dirac Comb Function
% The Dirac comb function is a periodic function that is zero everywhere except
% at integer multiples of the period, where it is infinite.
%
% * The Dirac comb function is used to represent the sampling process in
% signal processing.
% * The Dirac comb function is used to represent the periodic impulse
% response of an LTI system.
%
% We can define continuous-time Dirac comb function as follows:
fs = 1e4;
t = -10:1 / fs:10;
N = length(t);
figure('Name', 'Dirac Comb Function');
dirac_comb = zeros(N, 1);
dirac_comb(mod(t, 1) == 0) = fs; % Spike at t = -10, -9, ..., 9, 10
plot(t, dirac_comb, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Dirac Comb Function');
grid on;

%%%
% We can define discrete-time Dirac comb function as follows:
n = -10:10;
N = length(n);
figure('Name', 'Discrete-Time Dirac Comb Function');
dirac_comb = zeros(N, 1);
dirac_comb(mod(n, 1) == 0) = 1; % Spike at n = -10, -9, ..., 9, 10
stem(n, dirac_comb, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Dirac Comb Function');
grid on;

%% Unit Step Function
% The continuous-time unit step function is defined as follows:
%
% $$u(t) = \begin{cases} 0, & t < 0 \\ 1, & t \geq 0 \end{cases}$$
%
% The discrete-time unit step function is defined as follows:
%
% $$u[n] = \begin{cases} 0, & n < 0 \\ 1, & n \geq 0 \end{cases}$$
%
% * The unit step function is also known as the Heaviside function.
% * The unit step function is used to represent the unit step response of
% an LTI system.
%
% We can define continuous-time unit step function in several ways:
%
% *1. Using the heaviside function*
fs = 1e3;
t = -10:1 / fs:10;
unit_step = heaviside(t); % Heaviside function
figure('Name', 'Continuous-Time Unit Step Function');
plot(t, unit_step, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Unit Step Function');
grid on;

%%%
% *2. Using the sign function*

unit_step = sign(t);
unit_step(unit_step < 0) = 0; % Sign function
figure('Name', 'Continuous-Time Unit Step Function');
plot(t, unit_step, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Unit Step Function');
grid on;

%%%
% *3. Using the comparison operator*
unit_step = t >= 0;
figure('Name', 'Continuous-Time Unit Step Function');
plot(t, unit_step, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Unit Step Function');
grid on;

%%%
% We can define discrete-time unit step function as follows(Several ways are
% available):
n = -10:10;
N = length(n);
unit_step = zeros(N, 1);
unit_step(n >= 0) = 1;
figure('Name', 'Discrete-Time Unit Step Function');
stem(n, unit_step, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-0.1 1.1]);
title('Discrete-Time Unit Step Function');
grid on;

%% Square Pulse
% The continuous-time square pulse is defined as follows:
%
% $$\Pi(t) = \begin{cases} 0, & |t| > \frac{1}{2} \\ 1, & |t| \leq
% \frac{1}{2} \end{cases}$$
%
% The discrete-time square pulse is defined as follows:
%
% $$\Pi[n] = \begin{cases} 0, & |n| > \frac{1}{2} \\ 1, & |n| \leq
% \frac{1}{2} \end{cases}$$
%
% We use the |rectpuls| function to define the square pulse.
% This function takes two arguments. The first argument is the number of
% samples and the second argument is the width of the pulse.
%
% We can define continuous-time rectanglular pulse as follows:
fs = 1e3;
t = -10:1 / fs:10;
rect_pulse = rectpuls(t, 2); % Rectangular pulse with width 2
figure('Name', 'Continuous-Time Rectangular Pulse');
plot(t, rect_pulse, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Rectangular Pulse');
grid on;

%%%
% We can define discrete-time rectangular pulse as follows:
n = -10:10;
N = length(n);
rect_pulse = rectpuls(n, 1); % Rectangular pulse with width 1(1 sample)
figure('Name', 'Discrete-Time Rectangular Pulse');
stem(n, rect_pulse, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Rectangular Pulse');
grid on;

%% Rectangular Wave
% * The square wave is a periodic function that is one for part of the period and
% zero for the rest of the period.
% * The square wave is used to represent the periodic step response of
% an LTI system.
% * We use the |square| function to define the square wave.
% This function takes two arguments. The first argument is the time vector and
% the second argument is the duty cycle percentage.
% * The duty cycle is the ratio of the pulse width to the period.
% * The duty cycle is a number between 0 and 1.
% * The period of |square| function is 2*pi. To change the period, we
% need to multiply the time vector by 2*pi/T0, where T0 is the period.
%
% The continuous-time rectangular wave is defined as follows:
fs = 1e3;
t = -1:1 / fs:1;
T0 = 0.5;
duty_cycle = 0.25;
square_wave = square(2 * pi * t / T0, duty_cycle * 100);
figure('Name', 'Continuous-Time Rectangular Wave');
plot(t, square_wave, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Rectangular Wave');
grid on;

%%%
% The discrete-time rectangular wave is defined as follows:
n = -10:10;
N = length(n);
T0 = 5;
duty_cycle = 0.4;
square_wave = square(2 * pi * n / T0, duty_cycle * 100);
figure('Name', 'Square Wave');
stem(n, square_wave, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Rectangular Wave');
grid on;

%singen
