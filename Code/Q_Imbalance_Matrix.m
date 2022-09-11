function Q_Imbalance = Q_Imbalance_Matrix(BB_RX_Q,DCO_Q,Gain_Q_dB,Delay_Num,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Involve IQ imbalance into BB Q signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% BB_RX_Q: The baseband RX Q signal in time domain.
% DCO_Q: The RX DC offset of Q signal.
% Gain_Q: The RX gain of Q signal.
% Delay_I_subtract_Q: The time delay imbalance(or phase imbalance) of I/Q imbalance, means 'Delay_I - Delay_Q'.
% Fs: The Sampling frequency.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Q_Imbalance: The imbalanced BB Q signal in time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gain_Q = 10^(Gain_Q_dB/10);

if Delay_Num > 0
    Delay_Q_Init = [BB_RX_Q zeros(1,Delay_Num)];
elseif Delay_Num < 0
    Delay_Q_Init = [zeros(1,-Delay_Num) BB_RX_Q];
elseif Delay_Num == 0
    Delay_Q_Init = BB_RX_Q;
end

Q_Imbalance = Gain_Q*Delay_Q_Init+DCO_Q;   % The final imbalanced I signal.