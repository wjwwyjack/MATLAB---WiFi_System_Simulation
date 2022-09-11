function [I_Imbalance_LTF_Freq_Corrected,Q_Imbalance_LTF_Freq_Corrected,I_Imbalance_Data_Freq_Corrected_1,Q_Imbalance_Data_Freq_Corrected_1,I_Imbalance_Data_Freq_Corrected_2,Q_Imbalance_Data_Freq_Corrected_2,I_Imbalance_Data_Freq_Corrected_3,Q_Imbalance_Data_Freq_Corrected_3] = Frequency_Error_Correction(I_Imbalance_LTF,Q_Imbalance_LTF,I_Imbalance_data_symbol_1,Q_Imbalance_data_symbol_1,I_Imbalance_data_symbol_2,Q_Imbalance_data_symbol_2,I_Imbalance_data_symbol_3,Q_Imbalance_data_symbol_3,Freq_Error,L_LTF_Single,L_GI_CP_data_Symbol,L_Symbol,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Frequency error correction in time domain.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_Imbalance_LTF: Initial I signal of LTF.
% Q_Imbalance_LTF: Initial Q signal of LTF.
% I_Imbalance_data_symbol: Initial I signal of data symbol.
% Q_Imbalance_data_symbol: Initial Q signal of data symbol.
% Freq_Error: Calculated Frequency error.
% Fs: Sampling frequency.

%%%%%%%%% Output Parameters %%%%%%%%%%
% I_Imbalance_LTF_Freq_Corrected: I signal of LTF after Frequency error correction.
% Q_Imbalance_LTF_Freq_Corrected: Q signal of LTF after Frequency error correction.
% I_Imbalance_Data_Freq_Corrected: I signal of data symbol after Frequency error correction.
% Q_Imbalance_Data_Freq_Corrected: Q signal of data symbol after Frequency error correction.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Imbalance_LTF = I_Imbalance_LTF-1i*Q_Imbalance_LTF;   % Create complex signal in time domain of LTF.
Imbalance_Data_1 = I_Imbalance_data_symbol_1-1i*Q_Imbalance_data_symbol_1;   % Create complex signal in time domain of data symbol.
Imbalance_Data_2 = I_Imbalance_data_symbol_2-1i*Q_Imbalance_data_symbol_2;
Imbalance_Data_3 = I_Imbalance_data_symbol_3-1i*Q_Imbalance_data_symbol_3;

L_Imbalance_LTF = length(Imbalance_LTF);
L_Imbalance_Data_1 = length(Imbalance_Data_1);
L_Imbalance_Data_2 = length(Imbalance_Data_2);
L_Imbalance_Data_3 = length(Imbalance_Data_3);
L_Gap_1 = L_LTF_Single*2+L_GI_CP_data_Symbol;
L_Gap_2 = L_LTF_Single*2+2*L_GI_CP_data_Symbol+L_Symbol;
L_Gap_3 = L_LTF_Single*2+3*L_GI_CP_data_Symbol+2*L_Symbol;

t_Index_LTF = (1/Fs)*[1:L_Imbalance_LTF];   % Create time index of LTF.
t_Index_Data_1 = (1/Fs)*[L_Gap_1+1:L_Gap_1+L_Imbalance_Data_1];   % Create time index of data symbol.
t_Index_Data_2 = (1/Fs)*[L_Gap_2+1:L_Gap_2+L_Imbalance_Data_2];   
t_Index_Data_3 = (1/Fs)*[L_Gap_3+1:L_Gap_3+L_Imbalance_Data_3];  

Phase_Index_LTF = exp(1i*2*pi*Freq_Error*t_Index_LTF);   % Phase correction value of each time point in LTF.
Phase_Index_Data_1 = exp(1i*2*pi*Freq_Error*t_Index_Data_1);   % Phase correction value of each time point in data symbol.
Phase_Index_Data_2 = exp(1i*2*pi*Freq_Error*t_Index_Data_2);
Phase_Index_Data_3 = exp(1i*2*pi*Freq_Error*t_Index_Data_3);

Imbalance_LTF_Freq_Corrected = Imbalance_LTF.*Phase_Index_LTF;   % Frequency error correction of LTF.
Imbalance_Data_Freq_Corrected_1 = Imbalance_Data_1.*Phase_Index_Data_1;   % Frequency error correction of data symbol.
Imbalance_Data_Freq_Corrected_2 = Imbalance_Data_2.*Phase_Index_Data_2;
Imbalance_Data_Freq_Corrected_3 = Imbalance_Data_3.*Phase_Index_Data_3;

% Split complex time signal to I/Q signal.
I_Imbalance_LTF_Freq_Corrected = real(Imbalance_LTF_Freq_Corrected);
Q_Imbalance_LTF_Freq_Corrected = -imag(Imbalance_LTF_Freq_Corrected);
I_Imbalance_Data_Freq_Corrected_1 = real(Imbalance_Data_Freq_Corrected_1);
Q_Imbalance_Data_Freq_Corrected_1 = -imag(Imbalance_Data_Freq_Corrected_1);
I_Imbalance_Data_Freq_Corrected_2 = real(Imbalance_Data_Freq_Corrected_2);
Q_Imbalance_Data_Freq_Corrected_2 = -imag(Imbalance_Data_Freq_Corrected_2);
I_Imbalance_Data_Freq_Corrected_3 = real(Imbalance_Data_Freq_Corrected_3);
Q_Imbalance_Data_Freq_Corrected_3 = -imag(Imbalance_Data_Freq_Corrected_3);




