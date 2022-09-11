function RF_RX_Q = RF_RX_Q_Time_Domain(RF_RX,fc,Fs,Delta_Phi,Delta_Phase_Mixer)
%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% The down-conversion of Q signal before low-passs-filter.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% RF_RX: The input RF_RX signal.
% fc: The frequency of center carrier.
% Fs: The sampling frequency.
% Delta_Phi: The delta phase of the receiver mixer.

%%%%%%%%% Output Parameters %%%%%%%%%%
% RF_RX_Q: Q signal after down-conversion before low-pass-filter in time domain. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wc = 2*pi*fc; % The w of center carrier
Ts = 1/Fs;     % Sampling period
L = length(RF_RX);   % Get the length of RF_RX.
t = (0:L-1)*Ts;    % Time vector
RF_RX_Q = RF_RX.*sin(wc*t+Delta_Phi+Delta_Phase_Mixer);   % Q signal after conversion pre-filter.

% Plot the RF_RX_Q signal.
% figure('Name','RF_RX_Q_Time Domain')
% plot(t,RF_RX_Q)