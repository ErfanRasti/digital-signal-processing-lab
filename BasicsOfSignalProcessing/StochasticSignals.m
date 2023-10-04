%% *Basics of Signal Processing - Stochastic Signals*
%% Clear the workspace
close all;
clear;
clc;

%% Uniform Stochastic Signals
% Uniform random variables are used to model situations where any outcome
% is equally likely. The probability density function of a uniform random
% variable is given by
%
% $$f(x) = \frac{1}{b-a}$$
%
% for $a \leq x \leq b$ and $0$ otherwise. The mean and variance of a
% uniform random variable are given by
%
% $$\mu = \frac{a+b}{2}$$
%
% $$\sigma^2 = \frac{(b-a)^2}{12}$$

% The following code generates a uniform random variable with size 1000
% between 0 and 1.

stochastic_signal = rand(1, 1000);
figure('Name', 'Uniform Stochastic Signal');
plot(stochastic_signal);
title('Uniform Stochastic Signal');
xlabel('Sample');
ylabel('Amplitude');
grid on;

%%%
% It can be shown that the histogram of a uniform random process is also
% uniform.
% More accurate results can be obtained by increasing the number of samples.
stochastic_signal = rand(1, 10000);
histogram(stochastic_signal, 50); % 100 bins
title('Uniform Stochastic Signal Histogram');
xlabel('Amplitude');
ylabel('Number of Samples');
grid on;

%%%
% We can plot the probability density function using |makedist| class
% and |pdf| function.
pd = makedist('Uniform'); % Make a uniform distribution
x = 0:0.01:1;
y = pdf(pd, x); % Calculate the pdf over the x values
figure('Name', 'Uniform Stochastic Signal PDF');
plot(x, y, 'LineWidth', 1.5');
title('Uniform Stochastic Signal PDF');
xlabel('Amplitude');
ylabel('Probability');
grid on;

%% Gaussian Stochastic Signals
% Gaussian random variables are used to model situations where the
% probability density function is bell-shaped. The probability density
% function of a Gaussian random variable is given by
%
% $$f(x) = \frac{1}{\sigma \sqrt{2\pi}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$
%
% The mean and variance of a Gaussian random variable are given by
%
% $$\mu = \mu$$
%
% $$\sigma^2 = \sigma^2$$

%%%
% The following code generates a Gaussian random variable with size 1000
% with mean 0 and variance 1.

stochastic_signal = randn(1, 1000);
figure('Name', 'Gaussian Stochastic Signal');
plot(stochastic_signal);
title('Gaussian Stochastic Signal');
xlabel('Sample');
ylabel('Amplitude');
grid on;

%%%
% It can be shown that the histogram of a Gaussian random process is also
% Gaussian.
% More accurate results can be obtained by increasing the number of samples.
figure('Name', 'Histogram of Gaussian Stochastic Signal');
stochastic_signal = randn(1, 10000);
histogram(stochastic_signal, 100);
title('Histogram of Gaussian Stochastic Signal');
xlabel('Amplitude');
ylabel('Number of Samples');
grid on;

%%%
% We can plot the probability density function using |makedist| class
% and |pdf| function.
pd = makedist('Normal'); % Make a Gaussian distribution
x = -5:0.01:5;
y = pdf(pd, x); % Calculate the pdf over the x values
figure('Name', 'Gaussian Stochastic Signal PDF');
plot(x, y, 'LineWidth', 1.5');
title('Gaussian Stochastic Signal PDF');
xlabel('Amplitude');
ylabel('Probability');
grid on;

%% Poisson Stochastic Signals
% Poisson random variables are used to model situations where the
% probability density function is asymmetric and has a long tail. The
% probability density function of a Poisson random variable is given by
%
% $$f(x) = \frac{e^{-\lambda} \lambda^x}{x!}$$
%
% The mean and variance of a Poisson random variable are given by
%
% $$\mu = \lambda$$
%
% $$\sigma^2 = \lambda$$

%%%
% The following code generates a Poisson random variable with size 1000
% with mean 5.

stochastic_signal = poissrnd(5, 1, 1000);
figure('Name', 'Poisson Stochastic Signal');
plot(stochastic_signal);
title('Poisson Stochastic Signal');
xlabel('Sample');
ylabel('Amplitude');
grid on;

%%%
% It can be shown that the histogram of a Poisson random process is also
% Poisson.
% More accurate results can be obtained by increasing the number of samples.
figure('Name', 'Histogram of Poisson Stochastic Signal');
stochastic_signal = poissrnd(5, 1, 10000);
histogram(stochastic_signal, 100);
title('Histogram of Poisson Stochastic Signal');
xlabel('Amplitude');
ylabel('Number of Samples');
grid on;

%%%
% We can plot the probability density function using |makedist| class
% and |pdf| function.
pd = makedist('Poisson', 'lambda', 5); % Make a Poisson distribution
x = 0:0.01:20;
y = pdf(pd, x); % Calculate the pdf over the x values
figure('Name', 'Poisson Stochastic Signal PDF');
plot(x, y, 'LineWidth', 1.5');
title('Poisson Stochastic Signal PDF');
xlabel('Amplitude');
ylabel('Probability');
grid on;

%% Exponential Stochastic Signalsq
%% Lognormal Stochastic Signals
%% Rayleigh Stochastic Signals
%% Rician Stochastic Signals\
%% Weibull Stochastic Signals
%% Gamma Stochastic Signals
%% |random| Function
