%% *Short-time Fourier Transform*
%% Clear the workspace
close all;
clear;
clc;
%% |chirp| function
% The |chirp| function generates samples of a linear swept-frequency
% cosine signal. The |chirp| function is used to simulate a radar pulse.
% The |chirp| function is defined as follows:
%
% $$x(t) = \cos(2\pi f_0 t + \pi \beta t^2 + \phi_0)$$
%
% where
%
% * $f_0$ is the instantaneous frequency at time $t=0$.
% * $\beta$ is the rate of change of the instantaneous frequency.
% * $\phi_0$ is the initial phase of the signal.
%
% We can also define the chirp signal as a function of frequency:
%
% $$x(t) = \cos(\Phi(t))$$
%
% where
% $f(t) = f_0 + \beta t$ is the instantaneous frequency at time $t$.
%
% and
%
% $\Phi(t) = \Phi_0 + 2\pi \int_0^t f(\tau) d\tau$ is the instantaneous phase at time $t$.
%
% where
%
% * $f(t) = f_0 + \beta t$ is the instantaneous frequency at time $t$.
% * $\beta = \frac{f_1 - f_0}{T}$ is the rate of change of the instantaneous frequency.
% * $\phi_0$ is the initial phase of the signal.
% * $f_0$ is the initial frequency of the signal.
% * $f_1$ is the final frequency of the signal.
% * $T$ is the duration of reaching from $f_0$ to $f_1$.
%
% To implement the chirp signal, we use the |chirp| function. The |chirp|
% function is defined as follows:
%
% $$y = \text{chirp}(t,f_0,t_1,f_1)$$
%
% where
%
% * $t$ is the time vector.
% * $f_0$ is the initial frequency of the signal.
% * $f_1$ is the final frequency of the signal.
% * $t_1$ is the time for reaching the final frequency.
%
