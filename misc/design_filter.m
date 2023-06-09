function Hd = design_filter(Fc)
%DESIGN_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 16-Mar-2023 15:07:05

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N  = 4;   % Order
% Fc = 40;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% [EOF]
