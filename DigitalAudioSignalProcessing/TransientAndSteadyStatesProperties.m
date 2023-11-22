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
% $$ \Delta \omega = \frac{2\pi \Delta f}{f_s}$$
% $$ \beta = \tan(\frac{\Delta \omega}{2})$$
%
