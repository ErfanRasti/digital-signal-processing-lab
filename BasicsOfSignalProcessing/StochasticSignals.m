%% *Basics of Signal Processing - Stochastic Signals*
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
% The probability density function of the uniform noise can be shown by
% increasing the number of samples.
% More accurate results can be obtained by increasing the number of samples.
figure('Name', 'Uniform Stochastic Signal PDF');
stochastic_signal = rand(1, 10000);
histogram(stochastic_signal, 100);
title('Uniform Stochastic Signal PDF');
xlabel('Amplitude');
ylabel('Probability');
grid on;

%%%
% We can plot the probability density function using |makedist| class
% and |pdf| function..
figure('Name', 'Uniform Stochastic Signal PDF');
pd = makedist('Uniform');
x = 0:0.01:1;
y = pdf(pd, x);
figure('Name', 'Uniform Stochastic Signal PDF');
plot(x, y);
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
