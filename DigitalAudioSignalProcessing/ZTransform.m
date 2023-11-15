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
