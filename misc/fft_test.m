
Fs = 10000;                  
t = 0:1/Fs:1;

S = 1*sin(2*pi*50*t) + 2*sin(2*pi*120*t);

X = S + 2*randn(size(t));

%%

figure
hold on
plot(1000*t(1:50), X(1:50))
plot(1000*t(1:50), S(1:50))
% plot(1000*t, X)
% plot(1000*t, S)
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

%%
[amp, f] = fft_amp(X, Fs);

figure
plot(f, amp) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%%

[amp, f] = fft_amp(X, Fs);

plot(f,amp) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')





%%




