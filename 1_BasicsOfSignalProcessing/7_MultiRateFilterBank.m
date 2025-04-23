%% *Multirate Filter Bank*
%% Clear the workspace
close all;
clear;
clc;

%% What is a multi rate filter bank?
% # A multi rate filter bank consists of a set of filters that are used to
% decompose a signal into a set of subbands.
% # The subbands are then downsampled to reduce the sampling rate.
% # Then some operations are performed on the subbands and then the
% subbands are upsampled and combined to form the original signal.
% # The operations performed on the subbands are usually
% different for different subbands.
% # The operations performed on the subbands are usually some kind of
% compression or expansion.
% # Filter banks are used in many applications like audio compression,
% image compression, video compression, etc.
% # Filter banks are highly related to wavelets. Wavelets are a special case of
% filter banks.
% # The only difference between analysis and synthesis filter banks is in
% phase shift.
% # The downsampling and upsampling operations are called the
% polyphase decomposition and polyphase reconstruction respectively.
% # The downsampling operation is necessary to prevent aliasing.
% If there is no downsampling, then the output of the filter bank will be
% aliased(because of the overlap between the subbands).
%% Load the excel file containing the filters
% # The excel file contains the filter coefficients for the filter bank
% The filter bank is a 32 channel filter bank.
% # There are 4 subbands in each channel. The subbands are obtained
% by downsampling the output of the filter bank.
% # There are 4 filters in each sheet of the excel file.
% # To read the excel file, we use the |readmatrix| function.
% # To specify the sheet number, we use the |'Sheet'| name-value pair.
%% Downsample the signal
% # The signal is downsampled by a factor of number of channels in the filter
% bank.
% # We use the |downsample| function to downsample the signal.
% # The |downsample| function takes the signal and the downsampling factor
% as input arguments.
%% Upsample the signal
% # The signal is upsampled by a factor of number of channels in the filter
% bank.
% # We use the |upsample| function to upsample the signal.
% # The |upsample| function takes the signal and the upsampling factor
% as input arguments.
%% Spectrum of the filters
% # The spectrum of the filters can be obtained by taking the DTFT of the
% filter coefficients.
%
% In the following code, we plot the spectrum of the filters.
%
% # First we read the filter coefficients from the excel file.
% # Second we take the DTFT of the filter coefficients.
% # Third we plot the magnitude and phase of the DTFTs.
analysis_filters = readmatrix('./data/filters.xls', 'Sheet', 1);
synthesis_filters = readmatrix('./data/filters.xls', 'Sheet', 2);
figure('Name', "Amplitiude of frequency response of digital filters", 'Units', 'inches', 'Position', [1, 1, 10, 8]);

for i = 1:4
    n = 0:32 - 1;
    w_axis = linspace(0, pi, 1e3);
    kernel = exp(-1j * n' * w_axis);
    H = analysis_filters(i, :) * kernel;
    subplot(4, 2, 2 * i -1);
    plot(w_axis / pi, abs(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Magnitude');
    xlim([0 1]);
    title(strcat("Frequency response of analysis filter ", string(i)));
    grid on;

    H = synthesis_filters(i, :) * kernel;
    subplot(4, 2, 2 * i);
    plot(w_axis / pi, abs(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Magnitude');
    xlim([0 1]);
    title(strcat("Frequency response of synthesis filter ", string(i)));
    grid on;
end

%%%
figure('Name', "Phase of frequency response of digital filters", 'Units', 'inches', 'Position', [1, 1, 10, 8]);

for i = 1:4
    n = 0:32 - 1;
    w_axis = linspace(0, pi, 1e3);
    kernel = exp(-1j * n' * w_axis);
    H = analysis_filters(i, :) * kernel;
    subplot(4, 2, 2 * i -1);
    plot(w_axis / pi, angle(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Phase');
    xlim([0 1]);
    title(strcat("Frequency response of analysis filter ", string(i)));
    grid on;

    H = synthesis_filters(i, :) * kernel;
    subplot(4, 2, 2 * i);
    plot(w_axis / pi, angle(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Phase');
    xlim([0 1]);
    title(strcat("Frequency response of synthesis filter ", string(i)));
    grid on;

end

%%%
%% |freqz| function
% We could also use the |freqz| function to plot the frequency response of
% the filters. The |freqz| function takes three input arguments.
%
% # The first input argument is the numerator coefficients of the filter.
% # The second input argument is the denominator coefficients of the filter.
% # The third input argument is the number of points in the frequency axis.
%
% The |freqz| function returns the frequency response and the frequency
% axis as output arguments. The frequency response is a complex vector.
% The frequency axis is a vector of frequencies between 0 and pi.
figure('Name', "Amplitiude of frequency response of digital filters", 'Units', 'inches', 'Position', [1, 1, 10, 8]);

for i = 1:4
    n = 0:32 - 1;
    [H, w_axis] = freqz(analysis_filters(i, :), 1, 100);
    subplot(4, 2, 2 * i -1);
    plot(w_axis / pi, abs(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Magnitude');
    xlim([0 1]);
    title(strcat("Frequency response of analysis filter ", string(i)));
    grid on;

    [H, w_axis] = freqz(synthesis_filters(i, :), 1, 100);
    subplot(4, 2, 2 * i);
    plot(w_axis / pi, abs(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Magnitude');
    xlim([0 1]);
    title(strcat("Frequency response of synthesis filter ", string(i)));
    grid on;
end

%%%
figure('Name', "Phase of frequency response of digital filters", 'Units', 'inches', 'Position', [1, 1, 10, 8]);

for i = 1:4
    [H, w_axis] = freqz(analysis_filters(i, :), 1, 1024);
    subplot(4, 2, 2 * i -1);
    plot(w_axis / pi, angle(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Phase');
    xlim([0 1]);
    title(strcat("Frequency response of analysis filter ", string(i)));
    grid on;

    [H, w_axis] = freqz(synthesis_filters(i, :), 1, 1024);
    subplot(4, 2, 2 * i);
    plot(w_axis / pi, angle(H), 'LineWidth', 1.5);
    xlabel('Normalized Frequency');
    ylabel('Phase');
    xlim([0 1]);
    title(strcat("Frequency response of synthesis filter ", string(i)));
    grid on;

end
