function Fc_init = FFT_Norrow_Plot(Sc,Fs,Figure_Name)
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

% Plot the Norrow band FFT result
Middel_Index = fix(L/2);
Abs_Fc_final_Norrow_band = Abs_Fc_final((Middel_Index-199):(Middel_Index+200));
L_Norrow_band = length(Abs_Fc_final_Norrow_band);
fw_Norrow = (Fs/L_Norrow_band)*((-(L_Norrow_band/2-1)):(L_Norrow_band/2));    % Frequency coordinate

figure('Name',Figure_Name)
plot(fw_Norrow,Abs_Fc_final_Norrow_band)     % Graph generated