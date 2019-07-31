function y = self_fft(x, titles)
% data preprocessing 
Fs = 2560;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
[L, n] = size(x);     % size of signal array
t = (0:L-1)*T;        % Time vector

% Visualization
 
plot(1000*t, x)
plot(1000*t, x)
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure;
plot(f,P1)
ti = strcat('Single-Sided Amplitude Spectrum of X(t)', titles)

title(ti)
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Y = fft(S);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% figure;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of S(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

end
