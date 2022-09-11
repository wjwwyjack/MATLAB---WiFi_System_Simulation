function Demod_Ai_Aq = Demod_IQ_RX(I_data_time_1,Q_data_time_1,I_data_time_2,Q_data_time_2,I_data_time_3,Q_data_time_3,Fs,Matrix_H,f_data,f_plt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% De-modulation, Calculate the amplitude of I/Q signal of every frequency points.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_data_time: I signal time domain of data symbol.
% Q_data_time: Q signal time domain of data symbol.
% Fs: Sampling frequency.
% Matrix_H: The Matrix H of channel estimation.
% f_data: Frequency of data sub-carriers.
% f_plt: Frequency of pilot sub-carriers.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Demod_IQ: The demodulation result of Ai and Aq.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Symbol 1 %
Complex_IQ_time_1 = I_data_time_1-1i*Q_data_time_1;   % Construct the complex baseband signal in time domain.
IQ_fft_symbol_1 = FFT_Norrow_Plot(Complex_IQ_time_1,Fs,'IQ_Imbalance_data symbol 1 Frequency Domain');   % The frequency domain of imbalance IQ data symbol signal.

Demod_data_IQ_raw_1 = conj(2*IQ_fft_symbol_1);   % The raw data of demodulated result.
L_Demod_data_IQ_raw_1 = length(Demod_data_IQ_raw_1);
Demod_data_IQ_rearrange_1 = [Demod_data_IQ_raw_1((L_Demod_data_IQ_raw_1/2+2):end) Demod_data_IQ_raw_1(1:(L_Demod_data_IQ_raw_1/2))];   % Rearrange the demodulation result with sub-carrier position.
L_Demod_data_IQ_rearrange_1 = length(Demod_data_IQ_rearrange_1);
Demod_data_IQ_intercept_1 = Demod_data_IQ_rearrange_1((L_Demod_data_IQ_rearrange_1+1)/2-26:(L_Demod_data_IQ_rearrange_1+1)/2+26);   % Intercept the useful frequency point in frequency domain.

% Symbol 2 %
Complex_IQ_time_2 = I_data_time_2-1i*Q_data_time_2;   % Construct the complex baseband signal in time domain.
IQ_fft_symbol_2 = FFT_Norrow_Plot(Complex_IQ_time_2,Fs,'IQ_Imbalance_data symbol 2 Frequency Domain');   % The frequency domain of imbalance IQ data symbol signal.

Demod_data_IQ_raw_2 = conj(2*IQ_fft_symbol_2);   % The raw data of demodulated result.
L_Demod_data_IQ_raw_2 = length(Demod_data_IQ_raw_2);
Demod_data_IQ_rearrange_2 = [Demod_data_IQ_raw_2((L_Demod_data_IQ_raw_2/2+2):end) Demod_data_IQ_raw_2(1:(L_Demod_data_IQ_raw_2/2))];   % Rearrange the demodulation result with sub-carrier position.
L_Demod_data_IQ_rearrange_2 = length(Demod_data_IQ_rearrange_2);
Demod_data_IQ_intercept_2 = Demod_data_IQ_rearrange_2((L_Demod_data_IQ_rearrange_2+1)/2-26:(L_Demod_data_IQ_rearrange_2+1)/2+26);   % Intercept the useful frequency point in frequency domain.

% Symbol 3 %
Complex_IQ_time_3 = I_data_time_3-1i*Q_data_time_3;   % Construct the complex baseband signal in time domain.
IQ_fft_symbol_3 = FFT_Norrow_Plot(Complex_IQ_time_3,Fs,'IQ_Imbalance_data symbol 3 Frequency Domain');   % The frequency domain of imbalance IQ data symbol signal.

Demod_data_IQ_raw_3 = conj(2*IQ_fft_symbol_3);   % The raw data of demodulated result.
L_Demod_data_IQ_raw_3 = length(Demod_data_IQ_raw_3);
Demod_data_IQ_rearrange_3 = [Demod_data_IQ_raw_3((L_Demod_data_IQ_raw_3/2+2):end) Demod_data_IQ_raw_3(1:(L_Demod_data_IQ_raw_3/2))];   % Rearrange the demodulation result with sub-carrier position.
L_Demod_data_IQ_rearrange_3 = length(Demod_data_IQ_rearrange_3);
Demod_data_IQ_intercept_3 = Demod_data_IQ_rearrange_3((L_Demod_data_IQ_rearrange_3+1)/2-26:(L_Demod_data_IQ_rearrange_3+1)/2+26);   % Intercept the useful frequency point in frequency domain.


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Channel Equalizer
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Demod_data_IQ_equalized_1 = Demod_data_IQ_intercept_1./Matrix_H;   % Do channel equalization.
Demod_Ai_1 = real(Demod_data_IQ_equalized_1);
Demod_Aq_1 = imag(Demod_data_IQ_equalized_1);

Demod_data_IQ_equalized_2 = Demod_data_IQ_intercept_2./Matrix_H;   % Do channel equalization.
Demod_Ai_2 = real(Demod_data_IQ_equalized_2);
Demod_Aq_2 = imag(Demod_data_IQ_equalized_2);

Demod_data_IQ_equalized_3 = Demod_data_IQ_intercept_3./Matrix_H;   % Do channel equalization.
Demod_Ai_3 = real(Demod_data_IQ_equalized_3);
Demod_Aq_3 = imag(Demod_data_IQ_equalized_3);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pick the de-modulation result of sub-carriers
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Symbol 1 %
Length_Demod_Ai_1 = length(Demod_Ai_1);   % The length of Ai de-modulation result.
Num_f_sub_1 = f_data./312.5e3;   % The No.# of subcarries.
Demod_Ai_f_sub_1 = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
for index = (1:1:length(Num_f_sub_1))
    Demod_Ai_f_sub_buff_1 = Demod_Ai_1((Length_Demod_Ai_1+1)/2+Num_f_sub_1(index));   % Pick the de-modulation result of sub-carriers.
    Demod_Ai_f_sub_1 = [Demod_Ai_f_sub_1 Demod_Ai_f_sub_buff_1];   % Merge the pick result.
end

Length_Demod_Aq_1 = length(Demod_Aq_1);
Num_f_sub_1 = f_data./312.5e3;
Demod_Aq_f_sub_1 = [];
for index = (1:1:length(Num_f_sub_1))
    Demod_Aq_f_sub_buff_1 = Demod_Aq_1((Length_Demod_Aq_1+1)/2+Num_f_sub_1(index));
    Demod_Aq_f_sub_1 = [Demod_Aq_f_sub_1 Demod_Aq_f_sub_buff_1];
end

Num_f_plt_1 = f_plt./312.5e3;
Demod_Ai_f_plt_1 = [];
for index = (1:1:length(Num_f_plt_1))
    Demod_Ai_f_plt_buff_1 = Demod_Ai_1((Length_Demod_Ai_1+1)/2+Num_f_plt_1(index));
    Demod_Ai_f_plt_1 = [Demod_Ai_f_plt_1 Demod_Ai_f_plt_buff_1];
end
Demod_Ai_f_plt_1 = [Demod_Ai_f_plt_1 zeros(1,44)];

Num_f_plt_1 = f_plt./312.5e3;
Demod_Aq_f_plt_1 = [];
for index = (1:1:length(Num_f_plt_1))
    Demod_Aq_f_plt_buff_1 = Demod_Aq_1((Length_Demod_Aq_1+1)/2+Num_f_plt_1(index));
    Demod_Aq_f_plt_1 = [Demod_Aq_f_plt_1 Demod_Aq_f_plt_buff_1];
end
Demod_Aq_f_plt_1 = [Demod_Aq_f_plt_1 zeros(1,44)];

Demod_Ai_DC_1 = [Demod_Ai_1((Length_Demod_Ai_1+1)/2) zeros(1,47)];
Demod_Aq_DC_1 = [Demod_Aq_1((Length_Demod_Aq_1+1)/2) zeros(1,47)];

% Symbol 2 %
Length_Demod_Ai_2 = length(Demod_Ai_2);   % The length of Ai de-modulation result.
Num_f_sub_2 = f_data./312.5e3;   % The No.# of subcarries.
Demod_Ai_f_sub_2 = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
for index = (1:1:length(Num_f_sub_2))
    Demod_Ai_f_sub_buff_2 = Demod_Ai_2((Length_Demod_Ai_2+1)/2+Num_f_sub_2(index));   % Pick the de-modulation result of sub-carriers.
    Demod_Ai_f_sub_2 = [Demod_Ai_f_sub_2 Demod_Ai_f_sub_buff_2];   % Merge the pick result.
end

Length_Demod_Aq_2 = length(Demod_Aq_2);
Num_f_sub_2 = f_data./312.5e3;
Demod_Aq_f_sub_2 = [];
for index = (1:1:length(Num_f_sub_2))
    Demod_Aq_f_sub_buff_2 = Demod_Aq_2((Length_Demod_Aq_2+1)/2+Num_f_sub_2(index));
    Demod_Aq_f_sub_2 = [Demod_Aq_f_sub_2 Demod_Aq_f_sub_buff_2];
end

Num_f_plt_2 = f_plt./312.5e3;
Demod_Ai_f_plt_2 = [];
for index = (1:1:length(Num_f_plt_2))
    Demod_Ai_f_plt_buff_2 = Demod_Ai_2((Length_Demod_Ai_2+1)/2+Num_f_plt_2(index));
    Demod_Ai_f_plt_2 = [Demod_Ai_f_plt_2 Demod_Ai_f_plt_buff_2];
end
Demod_Ai_f_plt_2 = [Demod_Ai_f_plt_2 zeros(1,44)];

Num_f_plt_2 = f_plt./312.5e3;
Demod_Aq_f_plt_2 = [];
for index = (1:1:length(Num_f_plt_2))
    Demod_Aq_f_plt_buff_2 = Demod_Aq_2((Length_Demod_Aq_2+1)/2+Num_f_plt_2(index));
    Demod_Aq_f_plt_2 = [Demod_Aq_f_plt_2 Demod_Aq_f_plt_buff_2];
end
Demod_Aq_f_plt_2 = [Demod_Aq_f_plt_2 zeros(1,44)];

Demod_Ai_DC_2 = [Demod_Ai_2((Length_Demod_Ai_2+1)/2) zeros(1,47)];
Demod_Aq_DC_2 = [Demod_Aq_2((Length_Demod_Aq_2+1)/2) zeros(1,47)];

% Symbol 3 %
Length_Demod_Ai_3 = length(Demod_Ai_3);   % The length of Ai de-modulation result.
Num_f_sub_3 = f_data./312.5e3;   % The No.# of subcarries.
Demod_Ai_f_sub_3 = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
for index = (1:1:length(Num_f_sub_3))
    Demod_Ai_f_sub_buff_3 = Demod_Ai_3((Length_Demod_Ai_3+1)/2+Num_f_sub_3(index));   % Pick the de-modulation result of sub-carriers.
    Demod_Ai_f_sub_3 = [Demod_Ai_f_sub_3 Demod_Ai_f_sub_buff_3];   % Merge the pick result.
end

Length_Demod_Aq_3 = length(Demod_Aq_3);
Num_f_sub_3 = f_data./312.5e3;
Demod_Aq_f_sub_3 = [];
for index = (1:1:length(Num_f_sub_3))
    Demod_Aq_f_sub_buff_3 = Demod_Aq_3((Length_Demod_Aq_3+1)/2+Num_f_sub_3(index));
    Demod_Aq_f_sub_3 = [Demod_Aq_f_sub_3 Demod_Aq_f_sub_buff_3];
end

Num_f_plt_3 = f_plt./312.5e3;
Demod_Ai_f_plt_3 = [];
for index = (1:1:length(Num_f_plt_3))
    Demod_Ai_f_plt_buff_3 = Demod_Ai_3((Length_Demod_Ai_3+1)/2+Num_f_plt_3(index));
    Demod_Ai_f_plt_3 = [Demod_Ai_f_plt_3 Demod_Ai_f_plt_buff_3];
end
Demod_Ai_f_plt_3 = [Demod_Ai_f_plt_3 zeros(1,44)];

Num_f_plt_3 = f_plt./312.5e3;
Demod_Aq_f_plt_3 = [];
for index = (1:1:length(Num_f_plt_3))
    Demod_Aq_f_plt_buff_3 = Demod_Aq_3((Length_Demod_Aq_3+1)/2+Num_f_plt_3(index));
    Demod_Aq_f_plt_3 = [Demod_Aq_f_plt_3 Demod_Aq_f_plt_buff_3];
end
Demod_Aq_f_plt_3 = [Demod_Aq_f_plt_3 zeros(1,44)];

Demod_Ai_DC_3 = [Demod_Ai_3((Length_Demod_Ai_3+1)/2) zeros(1,47)];
Demod_Aq_DC_3 = [Demod_Aq_3((Length_Demod_Aq_3+1)/2) zeros(1,47)];


% Output %
Demod_Ai_Aq = [Demod_Ai_f_sub_1;Demod_Aq_f_sub_1;Demod_Ai_f_plt_1;Demod_Aq_f_plt_1;Demod_Ai_DC_1;Demod_Aq_DC_1;Demod_Ai_f_sub_2;Demod_Aq_f_sub_2;Demod_Ai_f_plt_2;Demod_Aq_f_plt_2;Demod_Ai_DC_2;Demod_Aq_DC_2;Demod_Ai_f_sub_3;Demod_Aq_f_sub_3;Demod_Ai_f_plt_3;Demod_Aq_f_plt_3;Demod_Ai_DC_3;Demod_Aq_DC_3];
