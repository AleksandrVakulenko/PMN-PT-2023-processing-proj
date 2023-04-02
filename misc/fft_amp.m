function [amp, f] = fft_amp(X, Fs)

signal_size = numel(X);
Y = fft(X)/signal_size;
f = Fs*(0:(signal_size/2))/signal_size;

amp = abs(Y);
amp = amp(1:signal_size/2+1);
amp(2:end-1) = 2*amp(2:end-1);

end