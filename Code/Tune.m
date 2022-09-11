% % % %function RF_TX = TX_Time_Domain(Ai,Aq,fc,Fs,L)
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%% Input Parameters %%%%%%%%%%%
% % % % Ai: The amplitude of I signal.
% % % % Aq: The amplitude of Q signal.
% % % % fc: The frequency of center carrier.
% % % % Fs: The sampling frequency.
% % % % L: The sampling length(the sampling point amount).
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % fc = 2e9;   % The frequency of center carrier /Hz (Defined)
% % % Fs = 8e10;  % Sampling frequency (Defined)
% % % L = 2.56e5;   % Sampling point amount (Defined)
% % % 
% % % wc = 2*pi*fc; % The w of center carrier
% % % Ts = 1/Fs;     % Sampling period
% % % T = (L-1)*Ts;   % Total sampling time
% % % t = (0:L-1)*Ts;    % Time vector
% % % 
% % % f_sub1 = 312.5e3*10;
% % % w_sub1 = 2*pi*f_sub1;
% % % 
% % % a_sub1 = 3;
% % % b_sub1 = 4;
% % % TX_I = a_sub1*cos(w_sub1*t)+b_sub1*sin(w_sub1*t);
% % % TX_Q = (-a_sub1)*sin(w_sub1*t)+b_sub1*cos(w_sub1*t);
% % % 
% % % RF_TX_I = TX_I.*cos(wc*t);
% % % RF_TX_Q = TX_Q.*sin(wc*t);
% % % 
% % % % Quadrature Conversion.
% % % % Signal I after quadrature conversion.
% % % %RF_TX_I = Ai*cos(wc*t);
% % % % Signal Q after quadrature conversion.
% % % %RF_TX_Q = Aq*sin(wc*t);
% % % 
% % % % The whole TX signal.
% % % RF_TX = RF_TX_I+RF_TX_Q;
% % % 
% % % % Plot the RF_TX signal.
% % % figure('Name','RF_TX_Time Domain')
% % % plot(t,RF_TX)
% % % box off
% % % 
% % % 
% % % 
% % % Sc = RF_TX;
% % % Fc_init = (1/L)*fft(Sc);      % FFT inital result of Sc(Complete signal);The frequency domain of result is 0 ~ Fs*(L-1)/L
% % % % Fc_init is a series of complex
% % % 
% % % Fc_N = Fc_init(L/2+2:L);     % Negative capture of FFT spectrum result
% % % Fc_P = Fc_init(1:L/2+1);         % Positive capture of FFT spectrum result
% % % Fc_final = [Fc_N Fc_P];         % The complete FFT spectrum result
% % % Abs_Fc_final = abs(Fc_final);    % The absolute value of complete FFT spectrum result
% % % fw = (Fs/L)*((-(L/2-1)):(L/2));    % Frequency coordinate
% % % 
% % % % Plot the FFT result
% % % figure('Name','FFT')
% % % plot(fw,Abs_Fc_final)     % Graph generated
% % 
% % fc = 2e9;   % The frequency of center carrier /Hz (Defined)
% % Fs = 8e10;  % Sampling frequency (Defined)
% % L = 2.56e5;   % Sampling point amount (Defined)
% % 
% % f_sub = [312.5e3*(-20) 312.5e3*(-10) 312.5e3*(10) 312.5e3*(20)];
% % f_plt = [312.5e3*(-15) 312.5e3*15];
% % Ai_sub = [1 2 3 4];
% % Aq_sub = [7 8 9 10];
% % Ai_plt = [5 6];
% % Aq_plt = [11 12];
% % DC_I = 13;
% % DC_Q = 14;
% % 
% % TX_RF = TX_Time_Domain(f_sub,f_plt,Ai_sub,Ai_plt,Aq_sub,Aq_plt,DC_I,DC_Q,fc,Fs,L);
% % 
% % Sc = TX_RF;
% % Fc_init = (1/L)*fft(Sc);      % FFT inital result of Sc(Complete signal);The frequency domain of result is 0 ~ Fs*(L-1)/L
% % % Fc_init is a series of complex
% % 
% % Fc_N = Fc_init(L/2+2:L);     % Negative capture of FFT spectrum result
% % Fc_P = Fc_init(1:L/2+1);         % Positive capture of FFT spectrum result
% % Fc_final = [Fc_N Fc_P];         % The complete FFT spectrum result
% % Abs_Fc_final = abs(Fc_final);    % The absolute value of complete FFT spectrum result
% % fw = (Fs/L)*((-(L/2-1)):(L/2));    % Frequency coordinate
% % 
% % % Plot the FFT result
% % figure('Name','FFT')
% % plot(fw,Abs_Fc_final)     % Graph generated
% 
% 
% % fc = 312.5e3;   % The frequency of center carrier /Hz (Defined)
% % Fs = 8e10;  % Sampling frequency (Defined)
% % L = 2.56e5;   % Sampling point amount (Defined)
% % 
% % wc = 2*pi*fc; % The w of center carrier
% % Ts = 1/Fs;     % Sampling period
% % T = (L-1)*Ts;   % Total sampling time
% % t = (0:L-1)*Ts;    % Time vector
% % 
% % Sc = sin(wc*t);
% % Fc_init = (1/L)*fft(Sc);      % FFT inital result of Sc(Complete signal);The frequency domain of result is 0 ~ Fs*(L-1)/L
% % % Fc_init is a series of complex
% % 
% % Fc_N = Fc_init(L/2+2:L);     % Negative capture of FFT spectrum result
% % Fc_P = Fc_init(1:L/2+1);         % Positive capture of FFT spectrum result
% % Fc_final = [Fc_N Fc_P];         % The complete FFT spectrum result
% % Abs_Fc_final = abs(Fc_final);    % The absolute value of complete FFT spectrum result
% % fw = (Fs/L)*((-(L/2-1)):(L/2));    % Frequency coordinate
% % 
% % % Plot the FFT result
% % figure('Name','FFT')
% % plot(fw,Abs_Fc_final)     % Graph generated
% % 
% % A = [2 1;1 2];
% % b = [3;4];
% % x = linsolve(A,b)
% % 
% % X = [1 2 3];
% % XX = fliplr(X)
% 
% % X = [1 1 1 2];
% % XX = X+1;
% % XXX = 3*X;
% % 
% % X = [ 1 2 3 4 5];
% % XX = X(2:end);
% % 
% % X = [1 2 3 4];
% % Y = [5 6 7 8];
% % Z = (X.*X+Y.*Y);
% % ZZ = sqrt(Z);
% % 
% % X = 1.25e-11;
% 
% % X = [1 2 3 4];
% % Y = autocorr(X);
% % Z = xcorr(X);
% 
% % 
% % % 
% % % % function% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%% Input Parameters %%%%%%%%%%%
% % % % f_sub: The delta frequency of data subcarriers, one-dimensional.
% % % % f_plt: The delta frequency of pilot subcarriers, one-dimensional.
% % % % Ai_sub % Ai_plt: The amplitude of I signal, one-dimensional.
% % % % Aq_sub % Aq_plt: The amplitude of Q signal, one-dimensional.
% % % % DC_I & DC_Q: The amplitude of DC offset.
% % % % fc: The frequency of center carrier. TX_RF = TX_Time_Domain(f_sub,f_plt,Ai_sub,Ai_plt,Aq_sub,Aq_plt,DC_I,DC_Q,fc,Fs,L)
% % 
% % % % Fs: The sampling frequency.
% % % % L: The sampling length(the sampling point amount).
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % f_sub = [312.5e3*(-24) 312.5e3*(-20) 312.5e3*(-16) 312.5e3*(-12) 312.5e3*(-8) 312.5e3*(-4) 312.5e3*(4) 312.5e3*(8) 312.5e3*(12) 312.5e3*(16) 312.5e3*(20) 312.5e3*(24)];   % The frequency of data subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
% % Ai_sub = [1 -1 1 -1 -1 1 -1 -1 1 1 1 1];   % The amplitude of I signal data subcarriers (Defined)
% % Aq_sub = [1 -1 1 -1 -1 1 -1 -1 1 1 1 1];   % The amplitude of Q signal data subcarriers (Defined)
% % Fs = 2e7;  % Sampling frequency, better do not modify (Defined)
% % L = 16;   % Sampling point amount, better do not modify (Defined)
% % 
% % 
% % w_sub = 2*pi*f_sub; % The delta w of data subcarriers.
% % % w_plt = 2*pi*f_plt; % The delta w of pilot subcarriers.
% % Num_sub = length(f_sub); % The number of data subcarriers.
% % % Num_plt = length(f_plt); % The number of pilot subcarriers.
% % 
% % % wc = 2*pi*fc; % The w of center carrier
% % Ts = 1/Fs;     % Sampling period
% % T = (L-1)*Ts;   % Total sampling time
% % t = (0:L-1)*Ts;    % Time vector
% % 
% % 
% % % TX BB signal format.
% % TX_BB_sub_I = zeros(1,L);   % The BB I signal of data subcarriers.
% % for index_sub_I = (1:Num_sub)
% %     TX_BB_sub_I = Ai_sub(index_sub_I)*cos(w_sub(index_sub_I)*t)+Aq_sub(index_sub_I)*sin(w_sub(index_sub_I)*t)+TX_BB_sub_I;
% % end
% % 
% % % TX_BB_plt_I = zeros(1,L);   % The BB I signal of pilot subcarriers.
% % % for index_plt_I = (1:Num_plt)
% % %     TX_BB_plt_I = Ai_plt(index_plt_I)*cos(w_plt(index_plt_I)*t)+Aq_plt(index_plt_I)*sin(w_plt(index_plt_I)*t)+TX_BB_plt_I;
% % % end
% % 
% % TX_BB_sub_Q = zeros(1,L);   % The BB Q signal of data subcarriers.
% % for index_sub_Q = (1:Num_sub)
% %     TX_BB_sub_Q = -Ai_sub(index_sub_Q)*sin(w_sub(index_sub_Q)*t)+Aq_sub(index_sub_Q)*cos(w_sub(index_sub_Q)*t)+TX_BB_sub_Q;
% % end
% % 
% % % TX_BB_plt_Q = zeros(1,L);   % The BB Q signal of pilot subcarriers.
% % % for index_plt_Q = (1:Num_plt)
% % %     TX_BB_plt_Q = -Ai_plt(index_plt_Q)*sin(w_plt(index_plt_Q)*t)+Aq_plt(index_plt_Q)*cos(w_plt(index_plt_Q)*t)+TX_BB_plt_Q;
% % % end
% %     
% % TX_BB_I_Single = TX_BB_sub_I;   % The complete BB I signal.
% % TX_BB_Q_Single = TX_BB_sub_Q;   % The complete BB Q signal.
% % 
% % TX_BB_I = [];
% % for index = (1:1:10)
% %     TX_BB_I = [TX_BB_I TX_BB_I_Single];
% % end
% % % TX_BB_I_path2 = [zeros(1,11) 1/10*TX_BB_I(1:149)];
% % % TX_BB_I = TX_BB_I+TX_BB_I_path2;
% % TX_BB_I = TX_BB_I;
% % 
% % 
% % TX_BB_Q = [];
% % for index = (1:1:10)
% %     TX_BB_Q = [TX_BB_Q TX_BB_Q_Single];
% % end
% % % TX_BB_Q_path2 = [zeros(1,11) 1/10*TX_BB_Q(1:149)];
% % % TX_BB_Q = TX_BB_Q+TX_BB_Q_path2;
% % TX_BB_Q = TX_BB_Q;
% % 
% % figure
% % plot(TX_BB_I_Single)
% % box off
% % 
% % figure
% % plot(TX_BB_Q_Single)
% % box off
% % 
% % figure
% % plot(TX_BB_I)
% % box off
% % 
% % figure
% % plot(TX_BB_Q)
% % box off
% % 
% % TX_BB_I_Sample = TX_BB_I(1:16);
% % TX_BB_I_XCORR = xcorr(TX_BB_I,TX_BB_I_Sample);
% % % TX_BB_I_XCORR = TX_BB_I_XCORR(145:end);
% % 
% % TX_BB_Q_Sample = TX_BB_Q(1:16);
% % TX_BB_Q_XCORR = xcorr(TX_BB_Q,TX_BB_Q_Sample);
% % % TX_BB_Q_XCORR = TX_BB_Q_XCORR(145:end);
% % 
% % figure
% % plot(TX_BB_I_XCORR)
% % box off
% % 
% % figure
% % plot(TX_BB_Q_XCORR)
% % box off
% 
% % 
% % x = 7.04e5/176;
% 
% % x = 7;
% % if x >= 4 && x <= 6
% %     y = 1;
% % else
% %     y = 0;
% % end
% 
% % x = 5;
% % if x == 6
% %     y = 1;
% % else
% %     y = 0;
% % end
% 
% % Xcorr_Index_Q = 1;
% % Sampling_Q_Imbalance_Length = length(Sampling_Q_Imbalance);
% % for Xcorr_Index_Q = (1:1:Sampling_Q_Imbalance_Length+1-176)
% %     Xcorr_initial_Q = Sampling_Q_Imbalance(Xcorr_Index_Q:Xcorr_Index_Q+176-1);
% %     Xcorr_initial_Q_Single = Xcorr_initial_Q(1:16);
% %     Xcorr_Result_Q = xcorr(Xcorr_initial_Q,Xcorr_initial_Q_Single);
% %     
% %     Xcorr_Result_Q_Length = length(Xcorr_Result_Q);
% %     Xcorr_Result_Q_Index = 1;
% %     Xcorr_Result_Q_Index_Upthreshold = [];
% %     for Xcorr_Result_Q_Index = (1:1:Xcorr_Result_Q_Length)
% %         if Xcorr_Result_Q(Xcorr_Result_Q_Index) > 100
% %             Xcorr_Result_Q_Index_Upthreshold = [Xcorr_Result_Q_Index_Upthreshold Xcorr_Result_Q_Index];
% %         end
% %     end
% %     
% %     Xcorr_Result_Q_Index_Upthreshold_Length = length(Xcorr_Result_Q_Index_Upthreshold);
% %     if Xcorr_Result_Q_Index_Upthreshold_Length >= 10
% %        Xcorr_Result_Q_Index_Upthreshold_Flip = fliplr(Xcorr_Result_Q_Index_Upthreshold);
% %        for Compare_Index = (1:1:9)
% %            if (Xcorr_Result_Q_Index_Upthreshold_Flip(Compare_Index) - Xcorr_Result_Q_Index_Upthreshold_Flip(Compare_Index+1))>=14 && (Xcorr_Result_Q_Index_Upthreshold_Flip(Compare_Index) - Xcorr_Result_Q_Index_Upthreshold_Flip(Compare_Index+1))<=16
% %                Packet_Detect_Q_Flag = 1;
% %            else
% %                Packet_Detect_Q_Flag = 0;
% %                break
% %            end
% %        end 
% %     else
% %         Packet_Detect_Q_Flag = 0;
% %     end
% %     
% %     if Packet_Detect_Q_Flag == 1
% %         symbol_start_index_Q = Xcorr_Index_Q+176;
% %         break
% %     end
% % end
% 
% % x = [1 2 3 4 5 6];
% % y = (2:4);
% 
% % x = 7.1e5;
% % y = 312.5e3;
% % z = rem(x,y);
% 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     % RX baseband de-modulation achievement
% %     % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     Demod_Ai = [];   % Define a new empty Demod_Ai matrix used for 'for loop'.
% %     for index_f_num = (1:1:L_Symbol/500+1)   % Index_f_num define the number of FFT result points that are used to do de-modulation.
% %                                       % This number related to de-modulation bandwidth.
% %         Demod_Ai_buff = Demod_Ai_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of I signal.
% %         Demod_Ai = [Demod_Ai_buff(1) Demod_Ai Demod_Ai_buff(2)];   % Merge the de-modulation result.
% %     end
% %     Demod_Ai = [Demod_Ai(1:L_Symbol/500) Demod_Ai((L_Symbol/500+2):end)];   % Total de-modulated I signal.
% %     clear index_f_num Demod_Ai_buff
% % 
% %     Demod_Aq = [];   % Define a new empty Demod_Aq matrix used for 'for loop'.
% %     for index_f_num = (1:1:L_Symbol/500+1)    % Index_f_num define the number of FFT result points that are used to do de-modulation.
% %                                        % This number related to de-modulation bandwidth.
% %         Demod_Aq_buff = Demod_Aq_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of Q signal.
% %         Demod_Aq = [Demod_Aq_buff(1) Demod_Aq Demod_Aq_buff(2)];   % Merge the de-modulation result.
% %     end
% %     Demod_Aq = [Demod_Aq(1:L_Symbol/500) Demod_Aq((L_Symbol/500+2):end)];   % Total de-modulated Q signal.
% %     clear index_f_num Demod_Aq_buff
% % 
% %     Demod_Aiq_Spectrum_value = Demod_Aiq_Spectrum(Demod_Ai,Demod_Aq,Fs,L_Symbol,'Demod_Aiq_Spectrum');   % Display the spectrum of I/Q_combined after de-modulation.
% %                                                                                                   % Like the function of I/Q capture.
% 
% 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Input Parameters Defination
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % The basic sampling related parameters %
% % fc = 2e9;   % The frequency of center carrier /Hz (Defined)
% % Fs = 8e10;  % Sampling frequency, better do not modify (Defined)
% % % L = 2.56e5;   % Sampling point amount, better do not modify (Defined)
% % L_Symbol = 2.56e5;
% % L_STF_Single = 6.4e4;
% % L_Guard = [2 6.4e4 6.4e4];
% % 
% % % The TX signal related parameters %
% % f_sub = [312.5e3*(-20) 312.5e3*(-10) 312.5e3*(10) 312.5e3*(20)];   % The frequency of data subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
% % f_plt = [312.5e3*(-15) 312.5e3*15];   % The frequency of pilot subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
% % Ai_sub = [0 0 3 0];   % The amplitude of I signal data subcarriers (Defined)
% % Aq_sub = [0 0 4 0];   % The amplitude of Q signal data subcarriers (Defined)
% % Ai_plt = [0 0];   % The amplitude of I signal pilot subcarriers (Defined)
% % Aq_plt = [0 0];   % The amplitude of Q signal pilot subcarriers (Defined)
% % DC_I = 0;   % The amplitude of I signal DC offset (Defined)
% % DC_Q = 0;   % The amplitude of Q signal DC offset (Defined)
% % 
% % % The baseband low pass filter related parameters %
% % Fcut_LPF = 312.5e3*50;   % The cut-off frequency of low pass filter (Defined)
% % 
% % % The I/Q imbalance matrix related parameters %
% % DCO_I = 0;   % The DC offset of I imbalance (Defined)
% % DCO_Q = 0;   % The DC offset of Q imbalance (Defined)
% % Gain_I = 1;   % The gain of I imbalance  (Defined)
% % Gain_Q = 1;   % The gain of Q imbalance  (Defined)
% % Delay_I_subtract_Q = 0;   % The time delay imbalance(or phase imbalance) of I/Q imbalance, means 'Delay_I - Delay_Q' (Defined)
% %                           % Need to be multiple of 1/Fs(1.25e-11)
% 
% 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % TX RF signal achievement
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % TX_RF_1 = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub,Ai_plt,Aq_sub,Aq_plt,DC_I,DC_Q,fc,Fs,L_Symbol);
% % 
% % cycle = 2;
% % TX_RF = [TX_RF_1(256000-cycle+1:end) TX_RF_1(1:256000-cycle)];
% % % TX_RF = [zeros(1,cycle) TX_RF_1(1:256000-cycle)];
% % 
% % % Delay = 0;
% % % TX_RF = [zeros(1,Delay) TX_RF_1(1:25600-Delay)];
% % 
% % % figure(1)
% % % plot(TX_RF)
% % % box off
% % 
% % RF_RX = TX_RF;   % The RF_RX signal.
% % RF_RX_I = RF_RX_I_Time_Domain(RF_RX,fc,Fs);   % I path down-conversion.
% % RF_RX_Q = RF_RX_Q_Time_Domain(RF_RX,fc,Fs);   % Q path down-conversion.
% % 
% % RF_RX_I_fft = FFT(RF_RX_I,Fs,'RF_RX_I_Frequency Domain');   % The frequency domain of I path down-conversion signal.
% % RF_RX_Q_fft = FFT(RF_RX_Q,Fs,'RF_RX_Q_Frequency Domain');   % The frequency domain of Q path down-conversion signal.
% % 
% % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % RX baseband Low-pass-filter achievement
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % BB_RX_I = Low_Pass_Filter(RF_RX_I,Fs,Fcut_LPF,'BB_RX_I_Frequency Domain','BB_RX_I_Time Domain');   % The RX I signal after BB low pass filter.
% % BB_RX_Q = Low_Pass_Filter(RF_RX_Q,Fs,Fcut_LPF,'BB_RX_Q_Frequency Domain','BB_RX_Q_Time Domain');   % The RX Q signal after BB low pass filter.
% % 
% % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % RX baseband I/Q imbalance matrix achievement
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % I_Imbalance = I_Imbalance_Matrix(BB_RX_I,DCO_I,Gain_I,Delay_I_subtract_Q,Fs);   % The BB I signal after imbalance.
% % Q_Imbalance = Q_Imbalance_Matrix(BB_RX_Q,DCO_Q,Gain_Q,Delay_I_subtract_Q,Fs);   % The BB Q signal after imbalance.
% % 
% % % I_Imbalance_fft = FFT(I_Imbalance,Fs,'I_Imbalance Domain');   % The frequency domain of imbalance I signal.
% % % Q_Imbalance_fft = FFT(Q_Imbalance,Fs,'Q_Imbalance Domain');   % The frequency domain of imbalance Q signal.
% % 
% %     
% %     I_Imbalance_fft_symbol = FFT(I_Imbalance,Fs,'I_Imbalance_symbol Frequency Domain');   % The frequency domain of imbalance I signal.
% %     Q_Imbalance_fft_symbol = FFT(Q_Imbalance,Fs,'Q_Imbalance_symbol Frequency Domain');   % The frequency domain of imbalance Q signal.
% % 
% % 
% %     % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     % RX baseband de-modulation achievement
% %     % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     Demod_Ai = [];   % Define a new empty Demod_Ai matrix used for 'for loop'.
% %     for index_f_num = (1:1:L_Symbol/500+1)   % Index_f_num define the number of FFT result points that are used to do de-modulation.
% %                                       % This number related to de-modulation bandwidth.
% %         Demod_Ai_buff = Demod_Ai_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of I signal.
% %         Demod_Ai = [Demod_Ai_buff(1) Demod_Ai Demod_Ai_buff(2)];   % Merge the de-modulation result.
% %     end
% %     Demod_Ai = [Demod_Ai(1:L_Symbol/500) Demod_Ai((L_Symbol/500+2):end)];   % Total de-modulated I signal.
% %     clear index_f_num Demod_Ai_buff
% % 
% %     Demod_Aq = [];   % Define a new empty Demod_Aq matrix used for 'for loop'.
% %     for index_f_num = (1:1:L_Symbol/500+1)    % Index_f_num define the number of FFT result points that are used to do de-modulation.
% %                                        % This number related to de-modulation bandwidth.
% %         Demod_Aq_buff = Demod_Aq_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of Q signal.
% %         Demod_Aq = [Demod_Aq_buff(1) Demod_Aq Demod_Aq_buff(2)];   % Merge the de-modulation result.
% %     end
% %     Demod_Aq = [Demod_Aq(1:L_Symbol/500) Demod_Aq((L_Symbol/500+2):end)];   % Total de-modulated Q signal.
% %     clear index_f_num Demod_Aq_buff
% % 
% %     Demod_Aiq_Spectrum_value = Demod_Aiq_Spectrum(Demod_Ai,Demod_Aq,Fs,L_Symbol,'Demod_Aiq_Spectrum');   % Display the spectrum of I/Q_combined after de-modulation.
% %                                                                                                   % Like the function of I/Q capture.
% % 
% %                                                                                                   
% %     % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     % Pick the de-modulation result of sub-carriers
% %     % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     Length_Demod_Ai = length(Demod_Ai);   % The length of Ai de-modulation result.
% %     Num_f_sub = f_sub./312.5e3;   % The No.# of subcarries.
% %     Demon_Ai_f_sub = [];   % Define a new empty Demon_Ai_f_sub matrix used for 'for loop'.
% %     for index = (1:1:length(Num_f_sub))
% %         Demon_Ai_f_sub_buff = Demod_Ai((Length_Demod_Ai+1)/2+Num_f_sub(index));   % Pick the de-modulation result of sub-carriers.
% %         Demon_Ai_f_sub = [Demon_Ai_f_sub Demon_Ai_f_sub_buff];   % Merge the pick result.
% %     end
% %     clear index Demon_Ai_f_sub_buff;
% % 
% %     Num_f_plt = f_plt./312.5e3;
% %     Demon_Ai_f_plt = [];
% %     for index = (1:1:length(Num_f_plt))
% %         Demon_Ai_f_plt_buff = Demod_Ai((Length_Demod_Ai+1)/2+Num_f_plt(index));
% %         Demon_Ai_f_plt = [Demon_Ai_f_plt Demon_Ai_f_plt_buff];
% %     end
% %     clear index Demon_Ai_f_plt_buff;
% % 
% %     Length_Demod_Aq = length(Demod_Aq);
% %     Num_f_sub = f_sub./312.5e3;
% %     Demon_Aq_f_sub = [];
% %     for index = (1:1:length(Num_f_sub))
% %         Demon_Aq_f_sub_buff = Demod_Aq((Length_Demod_Aq+1)/2+Num_f_sub(index));
% %         Demon_Aq_f_sub = [Demon_Aq_f_sub Demon_Aq_f_sub_buff];
% %     end
% %     clear index Demon_Aq_f_sub_buff;
% % 
% %     Num_f_plt = f_plt./312.5e3;
% %     Demon_Aq_f_plt = [];
% %     for index = (1:1:length(Num_f_plt))
% %         Demon_Aq_f_plt_buff = Demod_Aq((Length_Demod_Aq+1)/2+Num_f_plt(index));
% %         Demon_Aq_f_plt = [Demon_Aq_f_plt Demon_Aq_f_plt_buff];
% %     end
% %     clear index Demon_Aq_f_plt_buff;
% % 
% %     Demon_Ai_DC = Demod_Ai((Length_Demod_Ai+1)/2);
% %     Demon_Aq_DC = Demod_Aq((Length_Demod_Aq+1)/2);
% 
% 
% % 
% % x = -pi/4;
% % y = tan(x);
% 
% % x = rem(4,4);
% 
% 
% % fs = 3.125e8;
% % Ts = 1/fs;
% % L = 1000;
% % % fc = 6.265625e7;
% % % fc = 6.25e7;
% % fc = 6.2734375e7;
% % 
% % wc = 2*pi*fc;
% % t = (0:L-1)*Ts;
% % 
% % Se_T = cos(wc*t);
% % Se_F = fft(Se_T);
% % Se_F_abs = abs(Se_F);
% % 
% % figure(1)
% % plot(Se_T)
% % box off
% % 
% % figure(2)
% % plot(Se_F_abs)
% % box off
% 
% % x = tan(2*pi+1/4*pi);
% % 
% % x = rem(-pi/4,2*pi);
% % y = tan(x);
% 
% % a = 5;
% % x = sqrt(a);
% % y = a^2;
% % 
% % a = [1 2 3];
% % b = [5 6 7];
% % x = [a;b];
% % 
% % x1 = x(2,:);
% 
% 
% fc = 2e9;   % The frequency of center carrier /Hz (Defined)
% Fs = 8e10;  % Sampling frequency, better do not modify (Defined)
% L_Symbol = 2.56e5;
% 
% % The TX signal related parameters %
% f_sub = [312.5e3*(-15) 312.5e3*(-14) 312.5e3*(-13) 312.5e3*(-12) 312.5e3*(-11) 312.5e3*(-10) 312.5e3*(10) 312.5e3*(11) 312.5e3*(12) 312.5e3*(13) 312.5e3*(14) 312.5e3*(15)];   % The frequency of data subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
% f_plt = [312.5e3*(-20) 312.5e3*(20)];   % The frequency of pilot subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
% Ai_sub = [1 1 1 1 1 1 0 0 0 0 0 0];   % The amplitude of I signal data subcarriers (Defined)
% Aq_sub = [1 1 1 1 1 1 0 0 0 0 0 0];   % The amplitude of Q signal data subcarriers (Defined)
% Ai_plt = [0 0];   % The amplitude of I signal pilot subcarriers (Defined)
% Aq_plt = [0 0];   % The amplitude of Q signal pilot subcarriers (Defined)
% DC_I = 0;   % The amplitude of I signal DC offset (Defined)
% DC_Q = 0;   % The amplitude of Q signal DC offset (Defined)
% 
% Fcut_LPF = 312.5e3*50;   % The cut-off frequency of low pass filter (Defined)
% 
% 
% TX_RF = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub,Ai_plt,Aq_sub,Aq_plt,DC_I,DC_Q,fc,Fs,L_Symbol);
% CP_Length = 1000;
% TX_RF = [TX_RF(L_Symbol-CP_Length+1:end) TX_RF(1:L_Symbol-CP_Length)];
% 
% RF_RX = TX_RF;   % The RF_RX signal.
% RF_RX_I = RF_RX_I_Time_Domain(RF_RX,fc,Fs);   % I path down-conversion.
% RF_RX_Q = RF_RX_Q_Time_Domain(RF_RX,fc,Fs);   % Q path down-conversion.
% 
% BB_RX_I = Low_Pass_Filter(RF_RX_I,Fs,Fcut_LPF,'BB_RX_I_Frequency Domain','BB_RX_I_Time Domain');   % The RX I signal after BB low pass filter.
% BB_RX_Q = Low_Pass_Filter(RF_RX_Q,Fs,Fcut_LPF,'BB_RX_Q_Frequency Domain','BB_RX_Q_Time Domain');   % The RX Q signal after BB low pass filter.
% 
% I_Imbalance_fft_symbol = FFT(BB_RX_I,Fs,'I_Imbalance_symbol Frequency Domain');   % The frequency domain of imbalance I signal.
% Q_Imbalance_fft_symbol = FFT(BB_RX_Q,Fs,'Q_Imbalance_symbol Frequency Domain');   % The frequency domain of imbalance Q signal.
% 
%     Demod_Ai = [];   % Define a new empty Demod_Ai matrix used for 'for loop'.
%     for index_f_num = (1:1:L_Symbol/500+1)   % Index_f_num define the number of FFT result points that are used to do de-modulation.
%                                       % This number related to de-modulation bandwidth.
%         Demod_Ai_buff = Demod_Ai_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of I signal.
%         Demod_Ai = [Demod_Ai_buff(1) Demod_Ai Demod_Ai_buff(2)];   % Merge the de-modulation result.
%     end
%     Demod_Ai = [Demod_Ai(1:L_Symbol/500) Demod_Ai((L_Symbol/500+2):end)];   % Total de-modulated I signal.
%     clear index_f_num Demod_Ai_buff
% 
%     Demod_Aq = [];   % Define a new empty Demod_Aq matrix used for 'for loop'.
%     for index_f_num = (1:1:L_Symbol/500+1)    % Index_f_num define the number of FFT result points that are used to do de-modulation.
%                                        % This number related to de-modulation bandwidth.
%         Demod_Aq_buff = Demod_Aq_Nw_Pw(I_Imbalance_fft_symbol,Q_Imbalance_fft_symbol,index_f_num);   % The de-modulation process of Q signal.
%         Demod_Aq = [Demod_Aq_buff(1) Demod_Aq Demod_Aq_buff(2)];   % Merge the de-modulation result.
%     end
%     Demod_Aq = [Demod_Aq(1:L_Symbol/500) Demod_Aq((L_Symbol/500+2):end)];   % Total de-modulated Q signal.
%     clear index_f_num Demod_Aq_buff
% 
%     Demod_Aiq_Spectrum_value = Demod_Aiq_Spectrum(Demod_Ai,Demod_Aq,Fs,L_Symbol,'Demod_Aiq_Spectrum');   % Display the spectrum of I/Q_combined after de-modulation.
%     
%     
%     % Pick %
%     Length_Demod_Ai = length(Demod_Ai);   % The length of Ai de-modulation result.
%     Num_f_sub = f_sub./312.5e3;   % The No.# of subcarries.
%     Demod_Ai_f_sub = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
%     for index = (1:1:length(Num_f_sub))
%         Demod_Ai_f_sub_buff = Demod_Ai((Length_Demod_Ai+1)/2+Num_f_sub(index));   % Pick the de-modulation result of sub-carriers.
%         Demod_Ai_f_sub = [Demod_Ai_f_sub Demod_Ai_f_sub_buff];   % Merge the pick result.
%     end
%     clear index Demod_Ai_f_sub_buff;
% 
%     Num_f_plt = f_plt./312.5e3;
%     Demod_Ai_f_plt = [];
%     for index = (1:1:length(Num_f_plt))
%         Demod_Ai_f_plt_buff = Demod_Ai((Length_Demod_Ai+1)/2+Num_f_plt(index));
%         Demod_Ai_f_plt = [Demod_Ai_f_plt Demod_Ai_f_plt_buff];
%     end
%     clear index Demod_Ai_f_plt_buff;
% 
%     Length_Demod_Aq = length(Demod_Aq);
%     Num_f_sub = f_sub./312.5e3;
%     Demod_Aq_f_sub = [];
%     for index = (1:1:length(Num_f_sub))
%         Demod_Aq_f_sub_buff = Demod_Aq((Length_Demod_Aq+1)/2+Num_f_sub(index));
%         Demod_Aq_f_sub = [Demod_Aq_f_sub Demod_Aq_f_sub_buff];
%     end
%     clear index Demod_Aq_f_sub_buff;
% 
%     Num_f_plt = f_plt./312.5e3;
%     Demod_Aq_f_plt = [];
%     for index = (1:1:length(Num_f_plt))
%         Demod_Aq_f_plt_buff = Demod_Aq((Length_Demod_Aq+1)/2+Num_f_plt(index));
%         Demod_Aq_f_plt = [Demod_Aq_f_plt Demod_Aq_f_plt_buff];
%     end
%     clear index Demod_Aq_f_plt_buff;
% 
%     Demod_Ai_DC = Demod_Ai((Length_Demod_Ai+1)/2);
%     Demod_Aq_DC = Demod_Aq((Length_Demod_Aq+1)/2);
%     
%     % Phase Error Calculation %
%     Carrier_Phase_Error = Carrier_Phase_Error_Calculate(Demod_Ai_f_sub,Demod_Aq_f_sub);


% % wvtool(gausswin(512));
% % x = hann(512);
% fc = 312.5*10.5*1000;
% wc = 2*pi*fc;
% Fs = 8e7;
% L = 2.56e2;
% Ts = 1/Fs;
% t = (0:(L-1))*Ts;
% Se = cos(wc*t);
% 
% Hann_win_init = hann(L);
% hann_win = Hann_win_init';
% 
% Se = Se.*hann_win;
% 
% FFT_init_Se = fft(Se);
% FFT_display_Se = abs(FFT_init_Se);
% 
% figure()
% plot(FFT_display_Se)
% box off
% 
% 
% 
% a = [2+1i*3 4+1i*5];
% a1 = imag(a);

% %%%%%%%%%%%% LTF2 %%%%%%%%%%%%%%
% Demod_LTF1_IQ_raw = conj(2*IQ_fft_LTF1);   % The raw data of demodulated result.
% 
% L_Demod_LTF1_IQ_raw = length(Demod_LTF1_IQ_raw);
% Demod_LTF1_IQ = [Demod_LTF1_IQ_raw((L_Demod_LTF1_IQ_raw/2+2):end) Demod_LTF1_IQ_raw(1:(L_Demod_LTF1_IQ_raw/2))];   % Rearrange the demodulation result with sub-carrier position.
% 
% Length_Demod_LTF1_IQ = length(Demod_LTF1_IQ);   % The length of de-modulation result.
% Demod_IQ_LTF1_Picked = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
% for index = (1:1:length(Num_f_LTF))
%     Demod_IQ_LTF1_buff = Demod_LTF1_IQ((Length_Demod_LTF1_IQ+1)/2+Num_f_LTF(index));   % Pick the de-modulation result of sub-carriers.
%     Demod_IQ_LTF1_Picked = [Demod_IQ_LTF1_Picked Demod_IQ_LTF1_buff];   % Merge the pick result.
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% a = 1+1i*2;
% b = a*exp(1i*pi);
% 
% a = [1,1:5];

% 
% a = cos(pi);

% Random_Aq_data = (rand(1,43)-0.5)*8;
% 
% Aq_data = [];
% Random_Aq_data = (rand(1,48)-0.5)*8;
% for index_Aq_data = (1:48)
%     if (Random_Aq_data >= -4) && (Random_Aq_data < -2)
%         Aq_data_Buff = -3;
%     elseif (Random_Aq_data >= -2) && (Random_Aq_data < 0)
%         Aq_data_Buff = -1;
%     elseif (Random_Aq_data >= 0) && (Random_Aq_data < 2)
%         Aq_data_Buff = 1;
%     elseif (Random_Aq_data >= 2) && (Random_Aq_data <= 44)
%         Aq_data_Buff = 3;  
%     end
%     Aq_data = [Aq_data Aq_data_Buff];
% end

% Aq_data_judge = [];
% for index_Aq_data_judge = (1:48)
%     if (Demod_Aq_f_sub < -2)
%         Aq_data_judeg_Buff = -3;
%     elseif (Demod_Aq_f_sub >= -2) && (Demod_Aq_f_sub < 0)
%         Aq_data_judeg_Buff = -1;
%     elseif (Demod_Aq_f_sub >= 0) && (Demod_Aq_f_sub < 2)
%         Aq_data_judeg_Buff = 1;
%     elseif (Demod_Aq_f_sub >= 2)
%         Aq_data_judeg_Buff = 3;  
%     end
%     Aq_data_judge = [Aq_data_judge Aq_data_judeg_Buff];
% end


%     Ai_data_3 = [];
%     Random_Ai_data_3 = (rand(1,48)-0.5)*8;
%     for index_Ai_data_3 = (1:48)
%         if (Random_Ai_data_3(index_Ai_data_3) >= -4) && (Random_Ai_data_3(index_Ai_data_3) < -2)
%             Ai_data_Buff_3 = -3;
%         elseif (Random_Ai_data_3(index_Ai_data_3) >= -2) && (Random_Ai_data_3(index_Ai_data_3) < 0)
%             Ai_data_Buff_3 = -1;
%         elseif (Random_Ai_data_3(index_Ai_data_3) >= 0) && (Random_Ai_data_3(index_Ai_data_3) < 2)
%             Ai_data_Buff_3 = 1;
%         elseif (Random_Ai_data_3(index_Ai_data_3) >= 2) && (Random_Ai_data_3(index_Ai_data_3) <= 4)
%             Ai_data_Buff_3 = 3;  
%         end
%         Ai_data_3 = [Ai_data_3 Ai_data_Buff_3];
%     end
% 
%     Aq_data_3 = [];
%     Random_Aq_data_3 = (rand(1,48)-0.5)*8;
%     for index_Aq_data_3 = (1:48)
%         if (Random_Aq_data_3(index_Aq_data_3) >= -4) && (Random_Aq_data_3(index_Aq_data_3) < -2)
%             Aq_data_Buff_3 = -3;
%         elseif (Random_Aq_data_3(index_Aq_data_3) >= -2) && (Random_Aq_data_3(index_Aq_data_3) < 0)
%             Aq_data_Buff_3 = -1;
%         elseif (Random_Aq_data_3(index_Aq_data_3) >= 0) && (Random_Aq_data_3(index_Aq_data_3) < 2)
%             Aq_data_Buff_3 = 1;
%         elseif (Random_Aq_data_3(index_Aq_data_3) >= 2) && (Random_Aq_data_3(index_Aq_data_3) <= 4)
%             Aq_data_Buff_3 = 3;  
%         end
%         Aq_data_3 = [Aq_data_3 Aq_data_Buff_3];
%     end
% 
% TX_BB_Symbol_3 = TX_Symbol_Generate_Time(f_sub,f_plt,Ai_sub_3,Ai_plt,Aq_sub_3,Aq_plt,DC_I,DC_Q,fc,Fs,L_Symbol);   % Create TX data symbol in time domain.
% TX_BB_I_Symbol_3 = TX_BB_Symbol_3(1,:);
% TX_BB_Q_Symbol_3 = TX_BB_Symbol_3(2,:);
% TX_BB_I_GI_CP_Symbol_3 = TX_BB_I_Symbol_3(L_Symbol-6.4e4+1:end);
% TX_BB_Q_GI_CP_Symbol_3 = TX_BB_Q_Symbol_3(L_Symbol-6.4e4+1:end);


% Complex_IQ_time_3 = I_data_time_3-1i*Q_data_time_3;   % Construct the complex baseband signal in time domain.
% IQ_fft_symbol_3 = FFT_Norrow_Plot(Complex_IQ_time_3,Fs,'IQ_Imbalance_data symbol 3 Frequency Domain');   % The frequency domain of imbalance IQ data symbol signal.
% 
% Demod_data_IQ_raw_3 = conj(2*IQ_fft_symbol_3);   % The raw data of demodulated result.
% L_Demod_data_IQ_raw_3 = length(Demod_data_IQ_raw_3);
% Demod_data_IQ_rearrange_3 = [Demod_data_IQ_raw_3((L_Demod_data_IQ_raw_3/2+2):end) Demod_data_IQ_raw_3(1:(L_Demod_data_IQ_raw_3/2))];   % Rearrange the demodulation result with sub-carrier position.
% L_Demod_data_IQ_rearrange_3 = length(Demod_data_IQ_rearrange_3);
% Demod_data_IQ_intercept_3 = Demod_data_IQ_rearrange_3((L_Demod_data_IQ_rearrange_3+1)/2-26:(L_Demod_data_IQ_rearrange_3+1)/2+26);   % Intercept the useful frequency point in frequency domain.


% % Symbol 3 %
% Length_Demod_Ai_3 = length(Demod_Ai_3);   % The length of Ai de-modulation result.
% Num_f_sub_3 = f_data./312.5e3;   % The No.# of subcarries.
% Demod_Ai_f_sub_3 = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
% for index = (1:1:length(Num_f_sub_3))
%     Demod_Ai_f_sub_buff_3 = Demod_Ai_3((Length_Demod_Ai_3+1)/2+Num_f_sub_3(index));   % Pick the de-modulation result of sub-carriers.
%     Demod_Ai_f_sub_3 = [Demod_Ai_f_sub_3 Demod_Ai_f_sub_buff_3];   % Merge the pick result.
% end
% 
% Length_Demod_Aq_3 = length(Demod_Aq_3);
% Num_f_sub_3 = f_data./312.5e3;
% Demod_Aq_f_sub_3 = [];
% for index = (1:1:length(Num_f_sub_3))
%     Demod_Aq_f_sub_buff_3 = Demod_Aq_3((Length_Demod_Aq_3+1)/2+Num_f_sub_3(index));
%     Demod_Aq_f_sub_3 = [Demod_Aq_f_sub_3 Demod_Aq_f_sub_buff_3];
% end
% 
% Num_f_plt_3 = f_plt./312.5e3;
% Demod_Ai_f_plt_3 = [];
% for index = (1:1:length(Num_f_plt_3))
%     Demod_Ai_f_plt_buff_3 = Demod_Ai_3((Length_Demod_Ai_3+1)/2+Num_f_plt_3(index));
%     Demod_Ai_f_plt_3 = [Demod_Ai_f_plt_3 Demod_Ai_f_plt_buff_3];
% end
% Demod_Ai_f_plt_3 = [Demod_Ai_f_plt_3 zeros(1,44)];
% 
% Num_f_plt_3 = f_plt./312.5e3;
% Demod_Aq_f_plt_3 = [];
% for index = (1:1:length(Num_f_plt_3))
%     Demod_Aq_f_plt_buff_3 = Demod_Aq_3((Length_Demod_Aq_3+1)/2+Num_f_plt_3(index));
%     Demod_Aq_f_plt_3 = [Demod_Aq_f_plt_3 Demod_Aq_f_plt_buff_3];
% end
% Demod_Aq_f_plt_3 = [Demod_Aq_f_plt_3 zeros(1,44)];
% 
% Demod_Ai_DC_3 = [Demod_Ai_3((Length_Demod_Ai_3+1)/2) zeros(1,47)];
% Demod_Aq_DC_3 = [Demod_Aq_3((Length_Demod_Aq_3+1)/2) zeros(1,47)];
% 


% % Symbol 2 %
% Ai_data_judge_3 = [];
% for index_Ai_data_judge_3 = (1:48)
%     if (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < -2)
%         Ai_data_judeg_Buff_3 = -3;
%     elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= -2) && (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < 0)
%         Ai_data_judeg_Buff_3 = -1;
%     elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= 0) && (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < 2)
%         Ai_data_judeg_Buff_3 = 1;
%     elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= 2)
%         Ai_data_judeg_Buff_3 = 3;  
%     end
%     Ai_data_judge_3 = [Ai_data_judge_3 Ai_data_judeg_Buff_3];
% end
% 
% Aq_data_judge_3 = [];
% for index_Aq_data_judge_3 = (1:48)
%     if (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < -2)
%         Aq_data_judeg_Buff_3 = -3;
%     elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= -2) && (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < 0)
%         Aq_data_judeg_Buff_3 = -1;
%     elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= 0) && (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < 2)
%         Aq_data_judeg_Buff_3 = 1;
%     elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= 2)
%         Aq_data_judeg_Buff_3 = 3;  
%     end
%     Aq_data_judge_3 = [Aq_data_judge_3 Aq_data_judeg_Buff_3];
% end
% 
% 
% EVM_calculation_result_3 = [];
% for index_sub = (1:48)
%     EVM_Buff_3 = sqrt(((Demod_Ai_f_sub_3(index_sub)-Ai_data_judge_3(index_sub))^2 + (Demod_Aq_f_sub_3(index_sub)-Aq_data_judge_3(index_sub))^2)/10);
%     EVM_calculation_result_3 = [EVM_calculation_result_3 EVM_Buff_3];
% end
% 
% 
% EVM_average_3 = sum(EVM_calculation_result_3,2)/48;
% EVM_average_dB_3 = 10*log(EVM_average_3);

% Gain_I_dB = 3;
% Gain_I = 10^(Gain_I_dB/10);


% a = [1+2i 2+3i];
% b = real(a);
% c = imag(a);


jw1 = [1 2 3];
jw2 = sum(abs(jw1).^2);