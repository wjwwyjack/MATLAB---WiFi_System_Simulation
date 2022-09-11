function Flag_SymbolPointNumIQ = RX_Packet_Detect(I_Imbalance,Q_Imbalance,Fs)
%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Dectect if there is a WiFi packet in input signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_Imbalance: The imbalanced BB I signal in time domain.
% Q_Imbalance: The imbalanced BB Q signal in time domain.
% Fs: The sampling frequency.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Flag_PointNumI_PointNumQ(1): The flag of packet detect, this flag will set to '1' if detect WiFi signal both on I and Q signal.
% Flag_PointNumI_PointNumQ(2): The initial index of data symbol of IQ.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = 1/Fs;   % Sampling period.
Sampling_interval = (0.8e-6/16)/Ts;   % Sampling interval for second sampling, it is used for autocorrelation packet detect, sampling 16 points in 0.8us.
Sampling_interval = int32(Sampling_interval);   % Define the type of 'Sampling_interval' to int32, cause this variable will be used for loop index.
L_LTF_Single = 2.56e5;   % Sampling point amount of single LTF symbol, better do not modify (Defined).
L_GI_CP_LTF = 1.28e5;   % Sampling point amount of LTF_GL/CP, better do not modify (Defined)


IQ_Imbalance = I_Imbalance-1i*Q_Imbalance;   % Construct the complex signal in time domain.
IQ_Imbalance_Length = length(IQ_Imbalance);   % The length of IQ imbalance signal.
Remain_Length = IQ_Imbalance_Length;   % The remain length after every sampling loop.
Sampling_index = 1;   % Sampling index used for sampling loop.
Sampling_IQ_Imbalance = [];   % Sampling result matrix.
while Remain_Length >= Sampling_interval   % Sampling loop, sampling one point every sampling_interval.
    Sampling_IQ_Imbalance = [Sampling_IQ_Imbalance IQ_Imbalance(Sampling_index)];
    Remain_Length = IQ_Imbalance_Length-Sampling_index;
    Sampling_index = Sampling_index+Sampling_interval;
end


Sampling_IQ_Imbalance_Length = length(Sampling_IQ_Imbalance);   % The length of second sampled IQ imbalance signal.
for Xcorr_Index_IQ = (1:1:Sampling_IQ_Imbalance_Length+1-176)   % Loop the entire second sampling signal to capture the 11 STF samples.
    Xcorr_current_IQ = Sampling_IQ_Imbalance(Xcorr_Index_IQ:Xcorr_Index_IQ+176-1);   % Capture 11 STF samples length to do the correlation.
    Xcorr_current_IQ_Single = Xcorr_current_IQ(1:16);   % Capture the first STF length to do the correlation.
    Xcorr_Result_IQ = xcorr(Xcorr_current_IQ,Xcorr_current_IQ_Single);   % Do correlation with the single STF component and 11 STF component.
    Xcorr_Result_IQ_abs = abs(Xcorr_Result_IQ);
    
    Xcorr_Result_IQ_Length = length(Xcorr_Result_IQ_abs);   % The length of correlation result.
    Xcorr_Result_IQ_Index_Upthreshold = [];   % The index of correlation result whose value has exceeded the threshold.
    for Xcorr_Result_IQ_Index = (1:1:Xcorr_Result_IQ_Length)   % Loop the entire correlation result, find the index whose value has exceeded the threshold.
        if Xcorr_Result_IQ_abs(Xcorr_Result_IQ_Index) > 40   % The correlation threshold is 40, based on the experiment.
            Xcorr_Result_IQ_Index_Upthreshold = [Xcorr_Result_IQ_Index_Upthreshold Xcorr_Result_IQ_Index];
        end
    end
    
    Xcorr_Result_IQ_Index_Upthreshold_Length = length(Xcorr_Result_IQ_Index_Upthreshold);   % Amount of the index whose value has exceeded the threshold.
    if Xcorr_Result_IQ_Index_Upthreshold_Length >= 10   % Judge the amount of upthreshold correlaton index, if the amount >= 10, will do the next judgement statement; if the amount < 10, deem there is no WiFi packet.
       Xcorr_Result_IQ_Index_Upthreshold_Flip = fliplr(Xcorr_Result_IQ_Index_Upthreshold);   % Flip the matrix of upthreshold index, it is convenient to do next statement.
       Packet_Detect_IQ_Flag = 0;   % The default value of packet detect flag is '0'.
       Matched_Upthreshold_Number_IQ = 1;
       for Compare_Index_IQ_init = (1:1:Xcorr_Result_IQ_Index_Upthreshold_Length-9)   % When there are 10 upthreshold index that the difference of every two adjacent index is between 15~17, then deem there is a WiFi packet.
           Compare_Index_IQ = Compare_Index_IQ_init;
           while true
               for Compare_Index_buff_IQ = (Compare_Index_IQ+1:1:Xcorr_Result_IQ_Index_Upthreshold_Length)
                   if Xcorr_Result_IQ_Index_Upthreshold_Flip(Compare_Index_IQ)-Xcorr_Result_IQ_Index_Upthreshold_Flip(Compare_Index_buff_IQ) >= 15 && Xcorr_Result_IQ_Index_Upthreshold_Flip(Compare_Index_IQ)-Xcorr_Result_IQ_Index_Upthreshold_Flip(Compare_Index_buff_IQ) <= 17
                       Matched_Upthreshold_Number_IQ = Matched_Upthreshold_Number_IQ+1;
                       if Matched_Upthreshold_Number_IQ == 10
                           Packet_Detect_IQ_Flag = 1;
                           break
                       else
                       end
                       Compare_Index_IQ = Compare_Index_buff_IQ;
                       break
                   else
                   end
               end

               if Packet_Detect_IQ_Flag == 1
                   break
               elseif Compare_Index_buff_IQ == Xcorr_Result_IQ_Index_Upthreshold_Length
                   break
               end
           end
       end
    else
        Packet_Detect_IQ_Flag = 0;
    end
    
    if Packet_Detect_IQ_Flag == 1
        symbol_start_index_IQ = Xcorr_Index_IQ+176;   % The initial index of data symbol in second sampling matrix.
        break
    end
end


if Packet_Detect_IQ_Flag == 1   % If detect WiFi signal with IQ signal, deems there is a real WiFi packet.
    Flag_Packet_Detect = 1;   % Set packet detect flag to '1' indicate there is a real WiFi packet.
    symbol_start_index_IQ_initial = 1+4000*(symbol_start_index_IQ-1)+L_GI_CP_LTF+2*L_LTF_Single;   % The initial index of IQ data symbol in initial sampling matrix.
    Flag_SymbolPointNumIQ = [Flag_Packet_Detect symbol_start_index_IQ_initial];   % Merge the flag and initial index into one matrix, it is convenient as output parameters.
    
%     L_Xcorr_current_IQ = length(Xcorr_current_IQ);
%     Xcorr_current_IQ_real = real(Xcorr_current_IQ);
%     Xcorr_current_IQ_imag = imag(Xcorr_current_IQ);
%     figure('Name','STF symbols of IQ path after synchronization')
%     plot3(1:L_Xcorr_current_IQ,Xcorr_current_IQ_real,Xcorr_current_IQ_imag)
%     box off
    
    figure('Name','Correlation result of IQ path STF')
    plot(Xcorr_Result_IQ_abs)
    box off
else
    Flag_SymbolPointNumIQ = [0 0];   % If there is no WiFi packet have been detected, set all to '0'.
end