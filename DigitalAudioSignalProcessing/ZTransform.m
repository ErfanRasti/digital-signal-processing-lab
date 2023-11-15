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
% $$X(z)=\sum_{n=-\infty}^{\infty}x[n]z^{-n}$$
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
