function y = bind_fft(x1, x2, titles)

% data preprocessing 
Fs = 2560;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
[L, n] = size(x1);     % size of signal array
t = (0:L-1)*T;        % Time vector

% Visualization 
figure; cla;

Y = fft(x1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1, 'b');
ti = strcat('Single-Sided Amplitude Spectrum of X(t)', titles);
title(ti);
xlabel('f (Hz)')
ylabel('|P1(f)|')

hold on;

Y = fft(x2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
f
plot(f, P1, 'r');


end


% plot(f, P1, 'Color', colorstring(0));
% % hold on;
% 

% 


