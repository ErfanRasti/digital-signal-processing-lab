%% *Basics of Signal Processing - Different Noises*
%% Uniform Noise
% Uniform noise is a type of noise that the probability of each value is
% equal.
%
% The following code generates a uniform noise with the size of 1000 and
% the range of [0, 1].

noise = rand(1000, 1);
figure;
plot(noise);
title('Uniform Noise');
xlabel('Sample');
ylabel('Amplitude');
%% 
