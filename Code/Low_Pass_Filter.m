function Selp = Low_Pass_Filter(Se,Fs,Fcut,Figure_Name_Selp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% The ideal low-pass-filter achievement, use FFT and iFFT.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Se: The input signal.
% Fs: The sampling frequency.
% Fcut: The cut-off frequency of ideal low pass filter(Need to be multiple of Fres)
% Figure_Name_Felp: The name of output Felp figure.
% Figure_Name_Selp: The name of output Selp figure.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Selp: The signal after low-pass-filter in time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = length(Se);   % Get the length of Se.
Ts = 1/Fs;     % Sampling period
T = (L-1)*Ts;   % Total sampling time
Fres = Fs/L;   % The resolution of FFT.
Fcut = Fcut - rem(Fcut,Fres);   % Adjust the Fcut frequency to be the multiple of Fres.

t = (0:L-1)*Ts;    % Time vector.

Cut_Point_Number = fix(Fcut/Fres)+1;   % The number of cut point of the filter.

Flp1 = ones(1,(Cut_Point_Number+1));
Flp2 = zeros(1,(L-(2*Cut_Point_Number)-1));
Flp3 = ones(1,Cut_Point_Number);
Flp = [Flp1 Flp2 Flp3];   % The function cruve of Low pass filter.

Fe = fft(Se)*(1/L);   % The effective signal before low pass filter in frequency domain.

Felp = Fe.*Flp;   % The effective signal after low pass filter in frequency domain.

% figure('Name',Figure_Name_Felp)
% plot(abs(Felp))   % Plot the frequency domain of effective signal after low pass filter.

Selp = ifft(L*Felp);   % The effective signal after low pass filter in time domain.

figure('Name',Figure_Name_Selp)
plot(t,Selp)   % Plot the time domain of effective signal after low pass filter.