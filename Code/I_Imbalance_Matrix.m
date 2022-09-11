function I_Imbalance = I_Imbalance_Matrix(BB_RX_I,DCO_I,Gain_I_dB,Delay_Num,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Involve IQ imbalance into BB I signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% BB_RX_I: The baseband RX I signal in time domain.
% DCO_I: The RX DC offset of I signal.
% Gain_I: The RX gain of I signal.
% Delay_I_subtract_Q: The time delay imbalance(or phase imbalance) of I/Q imbalance, means 'Delay_I - Delay_Q'.
% Fs: The Sampling frequency.

%%%%%%%%% Output Parameters %%%%%%%%%%
% I_Imbalance: The imbalanced BB I signal in time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gain_I = 10^(Gain_I_dB/10);

if Delay_Num < 0
    Delay_I_Init = [BB_RX_I zeros(1,-Delay_Num)];
elseif Delay_Num > 0
    Delay_I_Init = [zeros(1,Delay_Num) BB_RX_I];
elseif Delay_Num == 0
    Delay_I_Init = BB_RX_I;
end

I_Imbalance = Gain_I*Delay_I_Init+DCO_I;   % The final imbalanced I signal.