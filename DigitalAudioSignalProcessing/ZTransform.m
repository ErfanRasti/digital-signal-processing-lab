%% * Z-Trnasform *
%% Clear the workspace
close al;
clear;
clc;
%% Why Z-transform?
%
% # The Z-transform is a powerful tool for analyzing discrete-time systems.
% # It is the discrete-time counterpart of the Laplace transform, which is
% used to analyze continuous-time systems.
% # The Z-transform is useful in the design and analysis of discrete-time
% systems.
% # It provides a convenient representation of the input-output behavior
% of discrete-time systems.
% # The Z-transform is also useful in solving difference equations.
% The Z-transform is a generalization of the DTFT.
% # The DTFT is the Z-transform evaluated on the unit circle.
%
%% Definition of Z-transform
% The Z-transform of a discrete-time signal $x[n]$ is defined as
%
% $$X(z)=\sum_{n=-\infty}^{\infty}x[n]z^{-n}$$
%
% where $z$ is a complex variable.
%
% # The Z-transform is a function of the complex variable $z$.
% # The Z-transform decomposes a discrete-time signal into its constituent
% complex exponentials.
%
%% Region of convergence
% In the concept of the Z-transform, the region of convergence (ROC) is
% defined as the set of values of $z$ for which the Z-transform converges.
% The ROC is a ring or disk in the $z$-plane.
%
% # The ROC is a ring or disk in the $z$-plane.
% # The ROC can be either inside or outside the outermost pole of the
% Z-transform.
% # The ROC cannot include any poles of the Z-transform.
% # The ROC of Z-transform must be a connected region.
% # The ROC of Z-transform of an LTI stable system contains the unit circle
% in the $z$-plane.
% # The ROC of Z-transform of an LTI system is independent of the input
% signal. It depends only on the system.
% # In calculating the ROC, the summation in the formula for the Z-transform is
% assumed to converge absolutely. So, the ROC is the set of values of $z$
% for which the series converges absolutely.
% # The Z-transform is assumed to be a rationa function of $z$.
% # The ROC is bounded by poles of the Z-transform.
%
%% Generating function of a sequence
% Generating function is a powerful tool for solving number theoretic
% problems.
%
% In mathematics, a generating function is a way of encoding an infinite
% sequence of numbers (an) by treating them as the coefficients of a
% formal power series.
%
% The generating function of a sequence is a power series whose coefficients
% are the terms of the sequence.
%
% There are many different generating functions, depending on what
% information one wants to encode. Some of the most common functions are
% listed below with their formulas, where $a_n$ denotes the $n$th term of
% the sequence.
%
% *Ordinary generating function:*
%
% $$G(a_n;x)=\sum_{n=0}^{\infty}a_nx^n$$
%
% *Probability generating function:* If $a_n$ is the probability mass
% function of a discrete random variable $X$, then  its ordinary generating
% function is called the probability generating function of $X$.
%
% *Exponential generating function:*
%
% $$G(a_n;x)=\sum_{n=0}^{\infty}a_n\frac{x^n}{n!}$$
%
% Another benefit of generating functions is that they can be used to
% convert a recurrence relation into a differential equation.
%
% # The Z-transform is a generating function of a one-sided sequence.
% The formula of the Z-transform can be expressed based on the ordinary
% generating function as
%
% $$X(z)=\sum_{n=0}^{\infty}x[n]z^{-n}=G(x[n];z^{-1})$$
%
% where $G(x[n];z^{-1})$ is the ordinary generating function of the
% sequence $x[n]$.
% # The Z-transform is a generating function of a two-sided sequence.
% The formula of the Z-transform of a two-sided sequence can be expressed
% as the sum of two generating functions as
%
% $$X(z)=\sum_{n=-\infty}^{\infty}x[n]z^{-n}=G(x[n];z^{-1})+G(x[-n-1];z)$$
%
% where $G(x[n];z^{-1})$ and $G(x[-n-1];z)$ are the ordinary generating
% functions of the sequences $x[n]$ and $x[-n-1]$, respectively.
%
% Generating functions are so powerful in analyzing number sequences and
% can be used to solve many problems in number theory.
%
%% Riemann Zeta Function
% The Riemann zeta function is a function of a complex variable $s$ that
% analytically continues the sum of the Dirichlet series
%
% $$\zeta(s)=\sum_{n=1}^{\infty}\frac{1}{n^s}$$
%
% * Holomorphic function is a complex-valued function of one or more complex
% variables that is complex differentiable in a neighborhood of every point
% in its domain.
% * Meromorphic function is a function that is holomorphic in all of the
% complex plane except for a set of isolated points (the poles).
% * Riemann Zeta  function defines a meromorphic function that is holomorphic
% in the half-plane $\Re(s)>1$ and has a simple pole at $s=1$, with residue 1.
% * The Riemann zeta function plays a pivotal role in analytic number theory
% and has applications in physics, probability theory, and applied
% statistics.
% * The Riemann zeta function is a measure of the distribution of prime
% numbers.
% * The Riemann zeta funnction is an index for calculating the convergence
% of infinite series.
%
%% Euler's product formula
% Euler's product formula is a product representation for the Riemann zeta
% function, which is valid for all complex numbers $s$ that have real part
% greater than $1$.
%
% $$\zeta(s)=\sum_{n=1}^{\infty}\frac{1}{n^s}=\prod_{p\in P}\frac{1}{1-p^{-s}}$$
%
% where $P$ is the set of all prime numbers.
%
%% Inverse Z-Transform
% The inverse Z-transform is defined as
%
% $$x[n]=\frac{1}{2\pi j}\oint X(z)z^{n-1}dz$$
%
% where the integration is performed over a closed path encircling the
% origin in the $z$-plane.
%
% # The inverse Z-transform is a function of the complex variable $z$.
% # The inverse Z-transform decomposes a Z-transform into its constituent
% complex exponentials.
%% |freqz| function
% The |freqz| function is used to calculate the frequency response of a
% discrete-time system and plot the magnitude and phase responses in MATLAB.
%
% *Syntax:*
%
%   |H=freqz(b,a,w)|
%
% *Input arguments:*
%
% * |b| is the numerator polynomial of the system.
% * |a| is the denominator polynomial of the system.
% * |w| is the vector of frequencies at which the frequency response is
% calculated.
%
% *Output arguments:*
%
% * |H| is the frequency response of the system.
%
%% |zplane| function
% The |zplane| function is used to plot the poles and zeros of a
% discrete-time system in MATLAB.
%
% *Syntax:*
%
%   |zplane(b,a)|
%
% *Input arguments:*
%
% * |b| is the numerator polynomial of the system.
% * |a| is the denominator polynomial of the system.
%
%% |impz| function
% The |impz| function is used to calculate the impulse response of a
% discrete-time system and plot the impulse response in MATLAB.
%
% *Syntax:*
%
%   |h=impz(b,a,n)|
%
% *Input arguments:*
%
% * |b| is the numerator polynomial of the system.
% * |a| is the denominator polynomial of the system.
% * |n| is the number of samples of the impulse response.
%
% *Output arguments:*
%
% * |h| is the impulse response of the system.
%
%% |ztrans| function
% The |ztrans| function is used to calculate the Z-transform of a
% discrete-time signal in MATLAB.
%
% *Syntax:*
%
%   |X=ztrans(x, transVar)|
%
% *Input arguments:*
%
% * |x| is the discrete-time signal.
% * |transVar| is the transformation variable.
%
% *Output arguments:*
%
% * |X| is the Z-transform of the discrete-time signal.
%
%% |iztrans| function
% The |iztrans| function is used to calculate the inverse Z-transform of a
% discrete-time signal in MATLAB.
%
% *Syntax:*
%
%   |x=iztrans(X, transVar)|
%
% *Input arguments:*
%
% * |X| is the Z-transform of the discrete-time signal.
% * |transVar| is the transformation variable.
%
% *Output arguments:*
%
% * |x| is the discrete-time signal.
%
%% |residuez| function
% The |residuez| function is used to calculate the residues, poles, and
% direct terms of a discrete-time system in MATLAB.
%
% *Syntax:*
%
%   |[r,p,k]=residuez(b,a)|
%
% *Input arguments:*
%
% * |b| is the numerator polynomial of the system.
% * |a| is the denominator polynomial of the system.
%
% *Output arguments:*
%
% * |r| is the vector of residues.
% * |p| is the vector of poles.
% * |k| is the vector of direct terms.
%
