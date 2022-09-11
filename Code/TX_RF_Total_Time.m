function TX_RF_Total = TX_RF_Total_Time(fc,Delta_Phi,Fs,L_Symbol,L_STF_Single,L_LTF_Single,L_Guard,f_sub,f_plt,Ai_sub_1,Aq_sub_1,Ai_sub_2,Aq_sub_2,Ai_sub_3,Aq_sub_3,Ai_plt,Aq_plt,DC_I,DC_Q,DPD_flag,DPD_Training_W_factor,DPD_Memory_depth,DPD_Nonlinear_order,DPD_memory_depth_guard)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Create total TX signal in time domain.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% fc: The frequency of center carrier.
% Delta_Phi: The delta phase of the transmitter mixer.
% Fs: The sampling frequency.
% L_Symbol: Sampling point amount of data symbol.
% L_STF_Single: Sampling point amount of single STF symbol.
% L_Guard: Sampling point amount of idle guard before and after effective signals.
% f_sub: The frequency of data subcarriers.
% f_plt: The frequency of pilot subcarriers.
% Ai_sub: The amplitude of I signal data subcarriers.
% Aq_sub: The amplitude of Q signal data subcarriers.
% Ai_plt: The amplitude of I signal pilot subcarriers.
% Aq_plt: The amplitude of Q signal pilot subcarriers.
% DC_I: The amplitude of I signal DC offset.
% DC_Q: The amplitude of Q signal DC offset.
% DPD_flag: The flag of enable DPD.
% DPD_Training_W_factor: The DPD factor 'W'.
% DPD_Memory_depth & DPD_Nonlinear_order & DPD_memory_depth_guard: DPD related parameters.

%%%%%%%%% Output Parameters %%%%%%%%%%
% TX_RF_Total: The total TX signal including guard, STF, data symbol in time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wc = 2*pi*fc; % The w of center carrier.
Ts = 1/Fs;   % Get the single sampling period.

TX_BB_STF_complex = TX_STF_Generate_Time(fc,Fs,L_STF_Single);   % Create TX STF component including 10 single STF symbols in complex time domain.

TX_BB_LTF_complex = TX_LTF_Generate_Time(fc,Fs,L_LTF_Single);   % Create TX LTF component including 2 single LTF symbols in complex time domain.

TX_BB_Symbol_1_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub_1,Ai_plt,Aq_sub_1,Aq_plt,fc,Fs,L_Symbol);   % Create TX data symbol in complex time domain.
TX_BB_Symbol_2_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub_2,Ai_plt,Aq_sub_2,Aq_plt,fc,Fs,L_Symbol); % Create TX data symbol in complex time domain.
TX_BB_Symbol_3_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub_3,Ai_plt,Aq_sub_3,Aq_plt,fc,Fs,L_Symbol);   % Create TX data symbol in complex time domain.

% Make the power of STF Aand LTF the same as data symbol %
STF_Power_Factor = sum(abs(TX_BB_STF_complex).^2) / length(TX_BB_STF_complex);
LTF_Power_Factor = sum(abs(TX_BB_LTF_complex).^2) / length(TX_BB_LTF_complex);
Data_Power_Factor = sum(abs(TX_BB_Symbol_1_complex).^2) / length(TX_BB_Symbol_1_complex);
TX_BB_STF_complex = sqrt(Data_Power_Factor/STF_Power_Factor)*TX_BB_STF_complex;
TX_BB_LTF_complex = sqrt(Data_Power_Factor/LTF_Power_Factor)*TX_BB_LTF_complex;

% DPD %
if DPD_flag == 1
    TX_BB_complex_Total = [TX_BB_STF_complex TX_BB_LTF_complex TX_BB_Symbol_1_complex TX_BB_Symbol_2_complex TX_BB_Symbol_3_complex];   % Merge the created signal above to total TX signal in complex time domain.
    
    % Normalization of TX_BB signal %
    Norm_Factor_TX_BB_complex_Total = max(abs(TX_BB_complex_Total));
    TX_BB_complex_Total_Norm = TX_BB_complex_Total / Norm_Factor_TX_BB_complex_Total;
    TX_BB_complex_Total_Norm_Add_Zero = [zeros(1,DPD_Memory_depth*DPD_memory_depth_guard) TX_BB_complex_Total_Norm];
    
    Length_TX_BB_complex_Total_Norm = length(TX_BB_complex_Total_Norm);
    Length_TX_BB_complex_Total_Norm_Add_Zero = length(TX_BB_complex_Total_Norm_Add_Zero);
    TX_BB_complex_Total_DPD = zeros(1,Length_TX_BB_complex_Total_Norm);
    for index = (DPD_Memory_depth*DPD_memory_depth_guard+1:1:Length_TX_BB_complex_Total_Norm_Add_Zero)
        % Build series nomial element of TX BB signal %
        TX_BB_complex_Total_nomial_DPD_element = [];
        for q = (0:1:DPD_Memory_depth)
            for k = (1:1:DPD_Nonlinear_order)
                TX_BB_complex_Total_nomial_DPD_element = [TX_BB_complex_Total_nomial_DPD_element abs(TX_BB_complex_Total_Norm_Add_Zero(index-q*DPD_memory_depth_guard))^(2*k-2)*TX_BB_complex_Total_Norm_Add_Zero(index-q*DPD_memory_depth_guard)];
            end
        end
        % DPD of each time slot %
        TX_BB_complex_Total_DPD(index-DPD_Memory_depth*DPD_memory_depth_guard) = DPD_Training_W_factor * TX_BB_complex_Total_nomial_DPD_element.';
    end
    
    TX_BB_complex_Total_ZeroGuard = [zeros(1,L_Guard(1)) TX_BB_complex_Total_DPD zeros(1,L_Guard(2))];   % Add zero guard.
else
    TX_BB_complex_Total = [TX_BB_STF_complex TX_BB_LTF_complex TX_BB_Symbol_1_complex TX_BB_Symbol_2_complex TX_BB_Symbol_3_complex];   % Merge the created signal above to total TX signal in complex time domain.
    Norm_Factor_TX_BB_complex_Total = max(abs(TX_BB_complex_Total));
    TX_BB_complex_Total_Norm = TX_BB_complex_Total / Norm_Factor_TX_BB_complex_Total;
    
    TX_BB_complex_Total_ZeroGuard = [zeros(1,L_Guard(1)) TX_BB_complex_Total_Norm zeros(1,L_Guard(2))];   % Add zero guard.
end


TX_BB_I_Total = real(TX_BB_complex_Total_ZeroGuard) + DC_I;   % Create I path real signal from complex signal.
TX_BB_Q_Total = -imag(TX_BB_complex_Total_ZeroGuard) + DC_Q;   % Create Q path real signal from complex signal.

L_GI_CP_LTF = 1.28e5;
L_GI_CP_Symbol = 6.4e4;
L_Total = (L_Guard(1)+10*L_STF_Single+L_GI_CP_LTF+2*L_LTF_Single+(L_GI_CP_Symbol+L_Symbol)*3+L_Guard(2));
t_Total = (0:L_Total-1)*Ts;
TX_RF_I_Total = TX_BB_I_Total.*cos(wc*t_Total+Delta_Phi);   % Signal I after quadrature conversion.
TX_RF_Q_Total = TX_BB_Q_Total.*sin(wc*t_Total+Delta_Phi);   % Signal Q after quadrature conversion.

TX_RF_Total = TX_RF_I_Total+TX_RF_Q_Total;   % The complete TX_RF signal.

% Plot the TX_RF_Total signal.
figure('Name','TX_RF_Tatol_Time Domain')
plot(t_Total,TX_RF_Total)
