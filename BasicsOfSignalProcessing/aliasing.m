%% *Aliasing*
%% Clear the workspace
close all;
clear;
clc;

%% What is aliasing?
% *Nyquist-Shannon sampling theorem:* If a function $x(t)$ contains no frequencies
% higher than $B$ Hz, it is completely determined by giving its ordinates at a
% series of points spaced $1/(2B)$ seconds apart.
%
% *Proof:* Let $x(t)$ be a bandlimited function with Fourier transform $X(f)$.
% Then $X(f)$ is zero for $|f| > B$. &x_s(t) = x(t) \cdot s(t)$ is the sampled
% version of $x(t)$, where $s(t)$ is a train of impulses spaced $T_s$ seconds
% apart. The Fourier transform of $x_s(t)$ is $X_s(f) = X(f) * S(f)$, where $S(f)$
% is the Fourier transform of $s(t)$. $S(f)$ is a train of impulses spaced $1/T_s$
% Hz apart. As log as the $X(f)$ is zero for $|f| > B$, $X_s(f)$ is a train of
% $X(f)$ spaced $1/T_s$ Hz apart. If $T_s = 1/(2B)$, then the $X(f)$s in
% $X_s(f)$ are spaced $1/(2B)$ Hz apart, and $X_s(f)$ contains all the information
% in $X(f)$. Therefore, $x_s(t)$ contains all the information in $x(t)$.
%
% *Aliasing:* If $x(t)$ is not bandlimited, then $X(f)$ is not zero for $|f| > B$ or
% $T_s > 1/(2B)$. In this case, $X_s(f)$ is not a train of $X(f)$ spaced $1/T_s$
% Hz apart. The $X(f)$s in $X_s(f)$ overlap, and $X_s(f)$ does not contain all
% the information in $X(f)$. Therefore, $x_s(t)$ does not contain all the
% information in $x(t)$. This is called aliasing.

% *Reconstruction:* If $x(t)$ is bandlimited, then $x(t)$ can be reconstructed
% from $x_s(t)$ by passing $x_s(t)$ through a lowpass filter with cutoff
% frequency $B$ Hz. This is called reconstruction.
%
% The filter only filters one period of the sampled signal in the frequency
% domain. The filter is a sinc function in the time domain. The sinc function
% has infinite duration. Therefore, the filter cannot be implemented in practice.
% Instead, a practical filter is used. The practical filter is a windowed sinc
% function. The windowed sinc function has finite duration. The windowed sinc
% function is called a *reconstruction filter*.
