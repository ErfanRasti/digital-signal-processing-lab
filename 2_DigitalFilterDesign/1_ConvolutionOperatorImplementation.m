%% *Convolution Operator Implementation*
%% Clear the workspace
close all;
clear;
clc;

%% Discrete Convolution Operator
% The discrete convolution operator is defined as
%
% $$y[n] = \sum_{k=-\infty}^{\infty} x[k]h[n-k]$$
%
% where $x[n]$ is the input signal, $h[n]$ is the impulse response, and
% $y[n]$ is the output signal. The convolution operator is commutative,
% meaning that
%
% $$x[n]*h[n] = h[n]*x[n]$$
%
% The convolution operator is implemented in MATLAB using the |conv|
% function. The |conv| function takes two vectors as inputs and returns the
% convolution of the two vectors. The length of the output vector is equal
% to the sum of the lengths of the input vectors minus one.
%% Implementation
% # According to the formula of the convlution, we should flip one of the vectors.
% # To flip the vector in MATLAB, we use the |fliplr| function.
% # According to the final lengtyh of the output vector, we should pad two vectors
% with zeros to reach the same length of the output vector.
% # To shift the reversed vector, we use the |circshift| function.
% This function shifts the elements in the vector by a specified number of
% positions.
% # We should only use one for loop to calculate the convolution.
%%%
% *Using |toeplitz| matrix*
%
% Toeplitz is implemented on an array. It starts iterating over the elements
% of the array and goes backward to reach the first element of the input array.
% Then it starts iterating over the elements of the array and goes forward to
% reach the length of the input array.
%
% # The convolution operator can also be implemented using the toeplitz
% matrix.
% # The toeplitz matrix is a matrix with constant values along its
% diagonals.
% # The first row of the toeplitz matrix is the impulse response
% vector.
% # The first column of the toeplitz matrix is the input signal
% vector padded with zeros.
% # Check the website for more information about the
% <https://www.mathworks.com/help/matlab/ref/toeplitz.html#buw23nm-3 toeplitz matrix>.
%
% The following code illustrates the behavior of the toeplitz matrix.
x = [1 2 3 4 5];
h = [1 2 3];
toeplitz(x)

%%%
% We can replace the reversed circular vector with an arbitrary vector(second vector);
% but the first element of the second vector should be the same as thhe first element
% of the first vector.
c = [1 0 0];
toeplitz(c, x)

%%%
% We can use the property of toeplitz matrix to implement the convolution operator.
size_x = length(x);
size_h = length(h);
h_pad = [h zeros(1, size_x - 1)];
c = [h(1) zeros(1, size_x - 1)];
H = toeplitz(c, h_pad); % H represents the toeplitz matrix
y = x * H;
disp(y)
%%%
% The result of the convolution is the same as the result of the |conv| function.
disp(conv(x, h))

%% nth order derivative filter
% To generate the nth order derivative filter, we can use a for loop and repeat
% the convolution for n times. The result of the convolution is the nth order
% derivative filter.
