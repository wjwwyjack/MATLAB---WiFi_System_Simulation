function Signal_channel_model_noise = Channel_Model(TX_Signal_initial,Model_flag,Noise_level)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Add effect of channel model to RF signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% TX_Signal_initial: Initial TX RF signal without channel model effect.
% Model_flag: The flag to indicate which channel model is used.
%   Model_flag = 1: Ideal channel model.
%   Model_flag = 2: First path + second path, second path with 400ns delay and 10dB loss.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Signal_channel_model: The RF signal with channel model effect.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%
% Ideal channel model
% %%%%%%%%%%%%%%%%%%%%%%%%%
if Model_flag == 1
    Signal_channel_model = TX_Signal_initial;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%
% First path + second path, second path with 400ns delay and 6dB loss.
% %%%%%%%%%%%%%%%%%%%%%%%%%
if Model_flag == 2
    TX_Signal_second_path = [zeros(1,32000) TX_Signal_initial]/2;   % 400ns delay and 6dB loss of second path.
    Signal_channel_model = [TX_Signal_initial zeros(1,32000)] + TX_Signal_second_path;
end


% %%%%%%%%%%%%%%%%%%%%%%%%%
% Add AWGN Noise
% %%%%%%%%%%%%%%%%%%%%%%%%%
L_Signal_channel_model = length(Signal_channel_model);
Signal_channel_model_noise = Signal_channel_model+(rand(1,L_Signal_channel_model)-0.5)*Noise_level;