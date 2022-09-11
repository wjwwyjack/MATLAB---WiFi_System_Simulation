function Fc_init = FFT(Sc,Fs,Figure_Name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Get the FFT result of signal, plot the FFT figure.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Sc: The input signal.
% Fs: The sampling frequency.
% Figure_Name: The name of output figure.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Fc_init: The FFT result of signal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = length(Sc);   % Get the length of Sc.
Ts = 1/Fs;     % Sampling period.
T = (L-1)*Ts;   % Total sampling time.

t = (0:L-1)*Ts;    % Time vector

Fc_init = (1/L)*fft(Sc);      % FFT inital result of Sc(Complete signal);The frequency domain of result is 0 ~ Fs*(L-1)/L
% Fc_init is a series of complex

Fc_N = Fc_init(L/2+2:L);     % Negative capture of FFT spectrum result
Fc_P = Fc_init(1:L/2+1);         % Positive capture of FFT spectrum result
Fc_final = [Fc_N Fc_P];         % The complete FFT spectrum result
Abs_Fc_final = abs(Fc_final);    % The absolute value of complete FFT spectrum result
fw = (Fs/L)*((-(L/2-1)):(L/2));    % Frequency coordinate

% Plot the FFT result
figure('Name',Figure_Name)
plot(fw,Abs_Fc_final)     % Graph generated