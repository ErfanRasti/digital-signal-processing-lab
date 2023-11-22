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
