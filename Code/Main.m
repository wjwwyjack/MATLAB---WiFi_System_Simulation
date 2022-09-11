close all;
clear;
clc;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input Parameters Definition
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The system basic parameters %
fc_transmitter = 2e9;   % The frequency of transmitter center carrier /Hz.
Delta_Phi_transmitter = 0;   % The delta phase of the transmitter mixer.
fc_receiver = 2e9;   % The frequency of receiver center carrier /Hz.
Delta_Phi_receiver = 0;   % The delta phase of the receiver mixer.
Fs = 8e10;  % Sampling frequency. (Fixed)
L_Symbol = 2.56e5;   % Sampling point amount of data symbol, please do not modify. (Fixed)
L_STF_Single = 6.4e4;   % Sampling point amount of single STF symbol, please do not modify. (Fixed)
L_LTF_Single = 2.56e5;   % Sampling point amount of single LTF symbol, please do not modify. (Fixed)
L_GI_CP_LTF = 1.28e5;   % Sampling point amount of LTF_GL/CP, please do not modify. (Fixed)
L_GI_CP_data_Symbol = 6.4e4;   % Sampling point amount of Data_Symbol_GL/CP, please do not modify. (Fixed)
L_Guard = [6.4e4 6.4e4];   % Sampling point amount of idle guard before and after effective signals.

% The TX signal related parameters %
f_data = [312.5e3*(-26) 312.5e3*(-25) 312.5e3*(-24) 312.5e3*(-23) 312.5e3*(-22) 312.5e3*(-20) 312.5e3*(-19) 312.5e3*(-18) 312.5e3*(-17) 312.5e3*(-16) 312.5e3*(-15) 312.5e3*(-14) 312.5e3*(-13) 312.5e3*(-12) 312.5e3*(-11) 312.5e3*(-10) 312.5e3*(-9) 312.5e3*(-8) 312.5e3*(-6) 312.5e3*(-5) 312.5e3*(-4) 312.5e3*(-3) 312.5e3*(-2) 312.5e3*(-1) 312.5e3*(1) 312.5e3*(2) 312.5e3*(3) 312.5e3*(4) 312.5e3*(5) 312.5e3*(6) 312.5e3*(8) 312.5e3*(9) 312.5e3*(10) 312.5e3*(11) 312.5e3*(12) 312.5e3*(13) 312.5e3*(14) 312.5e3*(15) 312.5e3*(16) 312.5e3*(17) 312.5e3*(18) 312.5e3*(19) 312.5e3*(20) 312.5e3*(22) 312.5e3*(23) 312.5e3*(24) 312.5e3*(25) 312.5e3*(26)];   % The frequency of data subcarriers, need to be multiple of 312.5kHz and symmetric.
f_plt = [312.5e3*(-21) 312.5e3*(-7) 312.5e3*(7) 312.5e3*(21)];   % The frequency of pilot subcarriers, need to be multiple of 312.5kHz and symmetric.

Aiq_data_random_flag = 1;   % Flag of enable random ir fix Aiq data, 1 means random, 0 means fix.
[Ai_data_1,Aq_data_1,Ai_data_2,Aq_data_2,Ai_data_3,Aq_data_3] = Generate_Aiq_data(Aiq_data_random_flag);   % Generate The amplitude of I/Q signal data(Aiq data) subcarriers.

Ai_plt = [1 1 1 1];   % The amplitude of I signal pilot subcarriers.
Aq_plt = [0 0 0 0];   % The amplitude of Q signal pilot subcarriers.

DC_I = 0;   % The amplitude of I signal DC offset.
DC_Q = 0;   % The amplitude of Q signal DC offset.

% The channel model flag %
Channel_Model_flag = 1;   % The specific defination of Model_flag please check the annotation in channel model subfunction.
Noise_level = 0;   % AWGN noise level in channel, generally set to 50.

% The baseband low pass filter related parameters %
Fcut_LPF = 40e6;   % The cut-off frequency of low pass filter.

% The I/Q imbalance matrix related parameters %
DCO_I = 0;   % The DC offset of I imbalance.
DCO_Q = 0;   % The DC offset of Q imbalance.
Gain_I_dB = 0;   % The gain of I imbalance.
Gain_Q_dB = 0;   % The gain of Q imbalance.
Delta_Phase_I = 0;   % The phase imbalance of I mixer.
Delta_Phase_Q = 0;   % The phase imbalance of Q mixer.
Delay_I_Q = (0)*(1/Fs);   % The time delay imbalance of I/Q imbalance, means 'Delay_I - Delay_Q' (Defined)
                                 % Need to be multiple of 1/Fs(0.0125ns).

% The IQ Capture related parameters %
Window_Flag = 1;   % 0: Rectangular(Disable); 1: Hanning; 2: Bartlett
Unit_Flag = 1;   % The flag of unit; 0: None; 1: dB(1 -> 0dB).
Demod_Bandwidth = 80e6;   % The display(de-modulate) point of IQ capture.


% PA Non-linearity parameters %
PA_Nonlinear_flag = 0;   % '0' --> Disable PA Non-linearity; '1' --> Enable PA-Nonlinearity.

PA_Memory_depth = 2;   % The memory depth of PA non-linearity model.
PA_Nonlinear_order = 2;   % The Non-linear order of PA model. Only consider about odd order, '1' means 1-order, '2' means 1-order and 3-order.
PA_Nomial_factors = [50 -25 2 -20 1 -15];   % Nomial factors should be (PA_Memory_depth+1)*PA_Nonlinear_order long.
PA_memory_depth_guard = 160;   % The guard sampling point of one memory depth.


% DPD parameters %
DPD_flag = 0;   % '0' --> Disable DPD; '1' --> Enable DPD.

DPD_Memory_depth = 0;   % The memory depth of DPD model; currently only support memoryless DPD, please set this item to '0'.
DPD_Nonlinear_order = 2;   % The Non-linear order of DPD model. Only consider about odd order, '1' means 1-order, '2' means 1-order and 3-order.
DPD_memory_depth_guard = 160;   % The guard sampling point of one single memory depth.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DPD Training implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if DPD_flag == 1
    DPD_Training_W_factor = DPD_Training(fc_transmitter,Fs,f_data,f_plt,Ai_plt,Aq_plt,L_STF_Single,L_LTF_Single,L_Symbol,PA_Memory_depth,PA_Nonlinear_order,PA_Nomial_factors,PA_memory_depth_guard,DPD_Memory_depth,DPD_Nonlinear_order,DPD_memory_depth_guard);
else
    DPD_Training_W_factor = [0 0];
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TX RF signal implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TX_RF = TX_RF_Total_Time(fc_transmitter,Delta_Phi_transmitter,Fs,L_Symbol,L_STF_Single,L_LTF_Single,L_Guard,f_data,f_plt,Ai_data_1,Aq_data_1,Ai_data_2,Aq_data_2,Ai_data_3,Aq_data_3,Ai_plt,Aq_plt,DC_I,DC_Q,DPD_flag,DPD_Training_W_factor,DPD_Memory_depth,DPD_Nonlinear_order,DPD_memory_depth_guard);   % The complete TX_RF signal.
TX_RF_fft = FFT(TX_RF,Fs,'TX_RF_Frequency_Domain');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TX RF signal with PA Non-linearity
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if PA_Nonlinear_flag == 1
    TX_RF_PA_out = PA_Nonlinear_Model(TX_RF,PA_Memory_depth,PA_Nonlinear_order,PA_Nomial_factors,PA_memory_depth_guard);
else
    TX_RF_PA_out = PA_Nomial_factors(1)*TX_RF;
end
% TX_RF_PA_out_fft = FFT(TX_RF_PA_out,Fs,'TX_RF_PA_out_Frequency_Domain');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TX RF signal with channel model
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RF_channel_model = Channel_Model(TX_RF_PA_out,Channel_Model_flag,Noise_level);   % Create TX RF signal with channel model.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX RF down-conversion implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RF_RX = RF_channel_model;   % The RF_RX signal.
RF_RX_I = RF_RX_I_Time_Domain(RF_RX,fc_receiver,Fs,Delta_Phi_receiver,Delta_Phase_I);   % I path down-conversion.
RF_RX_Q = RF_RX_Q_Time_Domain(RF_RX,fc_receiver,Fs,Delta_Phi_receiver,Delta_Phase_Q);   % Q path down-conversion.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX baseband Low-pass-filter implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BB_RX_I = Low_Pass_Filter(RF_RX_I,Fs,Fcut_LPF,'BB_RX_I_Time Domain');   % The RX I signal after BB low pass filter.
BB_RX_Q = Low_Pass_Filter(RF_RX_Q,Fs,Fcut_LPF,'BB_RX_Q_Time Domain');   % The RX Q signal after BB low pass filter.

BB_RX_I_fft = FFT(BB_RX_I,Fs,'BB_RX_I_Frequency_Domain');
BB_RX_Q_fft = FFT(BB_RX_Q,Fs,'BB_RX_Q_Frequency_Domain');
close BB_RX_I_Frequency_Domain;
close BB_RX_Q_Frequency_Domain;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX baseband I/Q imbalance matrix implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Delay_Num = round(Delay_I_Q*Fs);   % The point number of time domian correspond to delay time.
I_Imbalance = I_Imbalance_Matrix(BB_RX_I,DCO_I,Gain_I_dB,Delay_Num,Fs);   % The BB I signal after imbalance.
Q_Imbalance = Q_Imbalance_Matrix(BB_RX_Q,DCO_Q,Gain_Q_dB,Delay_Num,Fs);   % The BB Q signal after imbalance.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IQ Capture of entire received signal
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IQ_Capture_Value = IQ_Capture(I_Imbalance,Q_Imbalance,Window_Flag,Unit_Flag,Fs,Demod_Bandwidth);   % The IQ capture result of entire recived signal.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX packet detect implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Flag_SymbolPointNumI_SymbolPointNumQ = RX_Packet_Detect(I_Imbalance,Q_Imbalance,Fs);   % Packet detect of WiFi.

Flag_packet_detect = Flag_SymbolPointNumI_SymbolPointNumQ(1);   % The flag of WiFi packet detect.
data_symbol_start_index_IQ_initial = Flag_SymbolPointNumI_SymbolPointNumQ(2)-400;   % The initial index of IQ data symbol, with 400 offset to avoid FFT window lag behind actual data symbol.
% data_symbol_start_index_IQ_initial = 1407999; % Ideal index 1408001.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RX data symbol sync window implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Flag_packet_detect == 1
    
    I_Imbalance_data_symbol_1 = I_Imbalance(data_symbol_start_index_IQ_initial:data_symbol_start_index_IQ_initial+L_Symbol-1);   % The time domain of imbalance I data symbol signal.
    Q_Imbalance_data_symbol_1 = Q_Imbalance(data_symbol_start_index_IQ_initial:data_symbol_start_index_IQ_initial+L_Symbol-1);   % The time domain of imbalance Q data symbol signal.
    I_Imbalance_data_symbol_2 = I_Imbalance(data_symbol_start_index_IQ_initial+L_Symbol+L_GI_CP_data_Symbol:data_symbol_start_index_IQ_initial+2*L_Symbol+L_GI_CP_data_Symbol-1);   % The time domain of imbalance I data symbol signal.
    Q_Imbalance_data_symbol_2 = Q_Imbalance(data_symbol_start_index_IQ_initial+L_Symbol+L_GI_CP_data_Symbol:data_symbol_start_index_IQ_initial+2*L_Symbol+L_GI_CP_data_Symbol-1);   % The time domain of imbalance Q data symbol signal.
    I_Imbalance_data_symbol_3 = I_Imbalance(data_symbol_start_index_IQ_initial+2*L_Symbol+2*L_GI_CP_data_Symbol:data_symbol_start_index_IQ_initial+3*L_Symbol+2*L_GI_CP_data_Symbol-1);   % The time domain of imbalance I data symbol signal.
    Q_Imbalance_data_symbol_3 = Q_Imbalance(data_symbol_start_index_IQ_initial+2*L_Symbol+2*L_GI_CP_data_Symbol:data_symbol_start_index_IQ_initial+3*L_Symbol+2*L_GI_CP_data_Symbol-1);   % The time domain of imbalance Q data symbol signal.

    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Frequency error calculation implementation
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    LTF_start_index_IQ_initial = data_symbol_start_index_IQ_initial-2*L_LTF_Single-L_GI_CP_data_Symbol;
    I_Imbalance_LTF = I_Imbalance(LTF_start_index_IQ_initial:(LTF_start_index_IQ_initial+2*L_LTF_Single-1));   % The time domain of imbalance I data symbol signal.
    Q_Imbalance_LTF = Q_Imbalance(LTF_start_index_IQ_initial:(LTF_start_index_IQ_initial+2*L_LTF_Single-1));   % The time domain of imbalance Q data symbol signal.
    Frequency_Error_Result = Frequency_Error_Calculation(I_Imbalance_LTF,Q_Imbalance_LTF);   % Calculate the Frequency Error.
%     Frequency_Error_Result = 0;
    

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Frequency error correction(time domain) implementation
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [I_Imbalance_LTF_Freq_Corrected,Q_Imbalance_LTF_Freq_Corrected,I_Imbalance_Data_Freq_Corrected_1,Q_Imbalance_Data_Freq_Corrected_1,I_Imbalance_Data_Freq_Corrected_2,Q_Imbalance_Data_Freq_Corrected_2,I_Imbalance_Data_Freq_Corrected_3,Q_Imbalance_Data_Freq_Corrected_3] = Frequency_Error_Correction(I_Imbalance_LTF,Q_Imbalance_LTF,I_Imbalance_data_symbol_1,Q_Imbalance_data_symbol_1,I_Imbalance_data_symbol_2,Q_Imbalance_data_symbol_2,I_Imbalance_data_symbol_3,Q_Imbalance_data_symbol_3,Frequency_Error_Result,L_LTF_Single,L_GI_CP_data_Symbol,L_Symbol,Fs);   % Frequency error correction in time dmain signal.

    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Channel Estimation implementation
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Matrix_H = Channel_Estimation(I_Imbalance_LTF_Freq_Corrected,Q_Imbalance_LTF_Freq_Corrected,Fs);   % Calculate channel estimation Matrix H.
%     Matrix_H = ones(1,53);
    

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RX baseband de-modulation implementation_v2
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Demod_Ai_Aq = Demod_IQ_RX(I_Imbalance_Data_Freq_Corrected_1,Q_Imbalance_Data_Freq_Corrected_1,I_Imbalance_Data_Freq_Corrected_2,Q_Imbalance_Data_Freq_Corrected_2,I_Imbalance_Data_Freq_Corrected_3,Q_Imbalance_Data_Freq_Corrected_3,Fs,Matrix_H,f_data,f_plt);   % Demodulate RX IQ signal.
    
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Pick the de-modulation result of sub-carriers
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Symbol 1 %
    Demod_Ai_f_sub_1 = Demod_Ai_Aq(1,:);
    Demod_Aq_f_sub_1 = Demod_Ai_Aq(2,:);
    Demod_Ai_f_plt_1 = Demod_Ai_Aq(3,1:4);
    Demod_Aq_f_plt_1 = Demod_Ai_Aq(4,1:4);
    Demod_Ai_DC_1 = Demod_Ai_Aq(5,1);
    Demod_Aq_DC_1 = Demod_Ai_Aq(6,1);
    
    Average_factor1 = sum(1./Demod_Ai_f_plt_1)/4;
    Demod_Ai_f_sub_1 = Average_factor1 * Demod_Ai_f_sub_1;
    Demod_Aq_f_sub_1 = Average_factor1 * Demod_Aq_f_sub_1;
    Demod_Ai_DC_1 = Average_factor1 * Demod_Ai_DC_1;
    Demod_Aq_DC_1 = Average_factor1 * Demod_Aq_DC_1;
    
    
    % Symbol 2 %
    Demod_Ai_f_sub_2 = Demod_Ai_Aq(7,:);
    Demod_Aq_f_sub_2 = Demod_Ai_Aq(8,:);
    Demod_Ai_f_plt_2 = Demod_Ai_Aq(9,1:4);
    Demod_Aq_f_plt_2 = Demod_Ai_Aq(10,1:4);
    Demod_Ai_DC_2 = Demod_Ai_Aq(11,1);
    Demod_Aq_DC_2 = Demod_Ai_Aq(12,1);
    
    Average_factor2 = sum(1./Demod_Ai_f_plt_2)/4;
    Demod_Ai_f_sub_2 = Average_factor2 * Demod_Ai_f_sub_2;
    Demod_Aq_f_sub_2 = Average_factor2 * Demod_Aq_f_sub_2;
    Demod_Ai_DC_2 = Average_factor2 * Demod_Ai_DC_2;
    Demod_Aq_DC_2 = Average_factor2 * Demod_Aq_DC_2;
    
    
    % Symbol 3 %
    Demod_Ai_f_sub_3 = Demod_Ai_Aq(13,:);
    Demod_Aq_f_sub_3 = Demod_Ai_Aq(14,:);
    Demod_Ai_f_plt_3 = Demod_Ai_Aq(15,1:4);
    Demod_Aq_f_plt_3 = Demod_Ai_Aq(16,1:4);
    Demod_Ai_DC_3 = Demod_Ai_Aq(17,1);
    Demod_Aq_DC_3 = Demod_Ai_Aq(18,1);
    
    Average_factor3 = sum(1./Demod_Ai_f_plt_3)/4;
    Demod_Ai_f_sub_3 = Average_factor3 * Demod_Ai_f_sub_3;
    Demod_Aq_f_sub_3 = Average_factor3 * Demod_Aq_f_sub_3;
    Demod_Ai_DC_3 = Average_factor3 * Demod_Ai_DC_3;
    Demod_Aq_DC_3 = Average_factor3 * Demod_Aq_DC_3;
    
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Carrier Phase Correction implementation
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Carrier_Phase_Error = Carrier_Phase_Error_Calculate(Demod_Ai_f_plt,Demod_Aq_f_plt);   % Calculate the phase error based on pilot sub-carriers, this is caused by LO phase unsynchronization and FFT window sync error.
%     Phase_Correction = Carrier_Phase_Correction(Demod_Ai_f_sub,Demod_Aq_f_sub,Carrier_Phase_Error);   % Calculate the phase error of every data sub-carriers based on pilot phase error and linear fitting.
%     Demod_Aiq_Phase_Corrected = Demod_Correction_Of_Carrier_Phase(Demod_Ai_f_sub,Demod_Aq_f_sub,Phase_Correction);   % Correct the de-modulation result caused by phase error.
%     Demod_Ai_f_sub_Phase_Corrected = Demod_Aiq_Phase_Corrected(1,:);   % Ai de-modulation result after phase error correction.
%     Demod_Aq_f_sub_Phase_Corrected = Demod_Aiq_Phase_Corrected(2,:);   % Aq de-modulation result after phase error correction.
%     clear Demod_Aiq_Phase_Corrected;
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % EVM calculation implementation
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    EVM_average_dB = EVM_Calculation(Demod_Ai_f_sub_1,Demod_Aq_f_sub_1,Demod_Ai_f_sub_2,Demod_Aq_f_sub_2,Demod_Ai_f_sub_3,Demod_Aq_f_sub_3);

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Constellation Plot
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Constellation_Plot(Demod_Ai_f_sub_1,Demod_Aq_f_sub_1,Demod_Ai_f_sub_2,Demod_Aq_f_sub_2,Demod_Ai_f_sub_3,Demod_Aq_f_sub_3,'Constellation');
%     Constellation_Plot(Demod_Ai_f_sub_Phase_Corrected,Demod_Aq_f_sub_Phase_Corrected,'Constellation_Phase Correction');
    



else  
end