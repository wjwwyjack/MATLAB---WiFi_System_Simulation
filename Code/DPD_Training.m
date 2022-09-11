function DPD_Training_W_factor = DPD_Training(fc,Fs,f_sub,f_plt,Ai_plt,Aq_plt,L_STF_Single,L_LTF_Single,L_Symbol,PA_Memory_depth,PA_Nonlinear_order,PA_Nomial_factors,PA_memory_depth_guard,DPD_Memory_depth,DPD_Nonlinear_order,DPD_memory_depth_guard)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% DPD training.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% f_data: The delta frequency of data subcarriers, one-dimensional.
% f_plt: The delta frequency of pilot subcarriers, one-dimensional.
% Ai_data & Ai_plt: The amplitude of I signal, one-dimensional.
% Aq_data & Aq_plt: The amplitude of Q signal, one-dimensional.
% fc: The frequency of center carrier.
% Fs: The sampling frequency.
% L_STF_Single & L_LTF_Single & L_Symbol: Sampling point amount of symbol.
% PA_Memory_depth & PA_Nonlinear_order & PA_Nomial_factors & PA_memory_depth_guard: PA Non-linearity related parameters.
% DPD_Memory_depth & DPD_Nonlinear_order & DPD_memory_depth_guard: DPD related parameters.

%%%%%%%%% Output Parameters %%%%%%%%%%
% DPD_Training_W_factor: The DPD polynomial 'W' factor.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = 1/Fs;   % The sampling period.
wc = 2*pi*fc; % The w of center carrier.

[Ai_data_1,Aq_data_1,Ai_data_2,Aq_data_2,Ai_data_3,Aq_data_3] = Generate_Aiq_data(1);   % Generate The amplitude of I/Q signal data(Aiq data) subcarriers.


% Generate DPD training reference BB complex signal %
TX_BB_STF_complex = TX_STF_Generate_Time(fc,Fs,L_STF_Single);   % Create TX STF component including 10 single STF symbols in complex time domain.

TX_BB_LTF_complex = TX_LTF_Generate_Time(fc,Fs,L_LTF_Single);   % Create TX LTF component including 2 single LTF symbols in complex time domain.

TX_BB_Symbol_1_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_data_1,Ai_plt,Aq_data_1,Aq_plt,fc,Fs,L_Symbol);   % Create TX data symbol in complex time domain.
TX_BB_Symbol_2_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_data_2,Ai_plt,Aq_data_2,Aq_plt,fc,Fs,L_Symbol); % Create TX data symbol in complex time domain.
TX_BB_Symbol_3_complex = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_data_3,Ai_plt,Aq_data_3,Aq_plt,fc,Fs,L_Symbol);   % Create TX data symbol in complex time domain.

TX_BB_complex_ref = [TX_BB_STF_complex TX_BB_LTF_complex TX_BB_Symbol_1_complex TX_BB_Symbol_2_complex TX_BB_Symbol_3_complex];   % Merge the created signal above to total TX signal in complex time domain.






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DPD training %
% Solve matrix scheme, in analogy with LS(Least-Squares) convergence algorithm. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use 1 data symbol for DPD training %
Norm_Factor_TX_BB_Symbol_1_complex = max(abs(TX_BB_Symbol_1_complex));   % Normalization factor.
TX_BB_Symbol_1_complex_Norm = TX_BB_Symbol_1_complex / Norm_Factor_TX_BB_Symbol_1_complex;   % Normalization of training data symbol.s

% Split complex BB signal to I/Q signal %
TX_BB_ref_I = real(TX_BB_Symbol_1_complex_Norm);
TX_BB_ref_Q = -imag(TX_BB_Symbol_1_complex_Norm);

% I/Q up-conversion %
Length_TX_BB_Symbol_1_complex = length(TX_BB_Symbol_1_complex_Norm);
for index = (1:1:Length_TX_BB_Symbol_1_complex)
    t_index = (index-1)*Ts;
    TX_RF_ref_I(index) = TX_BB_ref_I(index) * cos(wc*t_index);   % Signal I after quadrature conversion.
    TX_RF_ref_Q(index) = TX_BB_ref_Q(index) * sin(wc*t_index);   % Signal Q after quadrature conversion.
end

% TX RF signal before PA %
TX_RF_ref = TX_RF_ref_I + TX_RF_ref_Q;   % The complete TX_RF signal.

% TX RF signal after PA %
TX_RF_PA_out = PA_Nonlinear_Model(TX_RF_ref,PA_Memory_depth,PA_Nonlinear_order,PA_Nomial_factors,PA_memory_depth_guard);

% I/Q down-conversion %
for index = (1:1:Length_TX_BB_Symbol_1_complex)
    t_index = (index-1)*Ts;
    RF_RX_I(index) = TX_RF_PA_out(index) * cos(wc*t_index);   % I signal after conversion pre-filter.
    RF_RX_Q(index) = TX_RF_PA_out(index) * sin(wc*t_index);   % Q signal after conversion pre-filter.
end

% Merge BB I/Q signal to complex BB signal, and normalization %
BB_RX = RF_RX_I - RF_RX_Q*1i;
Norm_Factor_BB_RX = max(abs(BB_RX));
BB_RX_Norm = BB_RX/Norm_Factor_BB_RX;

% DPD training, solve matrix %
Xn_Norm = TX_BB_Symbol_1_complex_Norm;   % The BB reference signal used for DPD training.
Yn_Norm = BB_RX_Norm;   % The feedback signal after PA that used for DPD training.

% Only consider about odd non-linear order %
length_Yn_Norm = length(Yn_Norm);
Yn_Norm_nomial = [];   % Build series nomial matrix of Yn.
for q = 0:1:DPD_Memory_depth  % q for memory depth loop.
     H_buff = zeros(length_Yn_Norm,DPD_Nonlinear_order);   % Build buffer matrix of one memory depth.
     for k = 1:1:DPD_Nonlinear_order   % k for non-linear order loop.
        for p = (q*DPD_memory_depth_guard+1):length_Yn_Norm
            H_buff(p,k) = abs(Yn_Norm(p-q*DPD_memory_depth_guard))^(2*k-2)*Yn_Norm(p-q*DPD_memory_depth_guard);   % Only contain odd non-linear order.
        end
    end
    Yn_Norm_nomial = [Yn_Norm_nomial H_buff];   % Merge series nomial matrix of Yn.
end

DPD_Training_W_factor = (Yn_Norm_nomial \ Xn_Norm.').';   % Get DPD training factor by solving matrix, this gives the Least-Squares error.

