function IQ_Capture_Value = IQ_Capture(I_signal,Q_signal,Window_Flag,Unit_Flag,Fs,Demod_Bandwidth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% The IQ capture of input signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_signal: The input I signal.
% Q_signal: The input Q signal.
% Window_Flag: The flag of FFT window; 0: Rectangular; 1: Hanning; 2: Bartlett.
% Unit_Flag: The flag of unit; 0: None; 1: dB(1 -> 0dB).
% Fs: The sampling frequency.
% Demod_Bandwidth: The De-modulate bandwidth of IQ capture.

%%%%%%%%% Output Parameters %%%%%%%%%%
% IQ_Capture_Value: The IQ capture calculation result.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = length(I_signal);   % The length of input signal.

if Window_Flag == 0   % Window_Flag: 0, means FFT window is 'Rectangular'.
    I_signal_win = I_signal;
    Q_signal_win = Q_signal;
    I_signal_fft = 1/L*fft(I_signal_win);
    Q_signal_fft = 1/L*fft(Q_signal_win);
elseif Window_Flag ==1   % Window_Flag: 1, means FFT window is 'Hanning'.
    Window_func_init = hann(L);   % Create the Hanning window.
    Window_func = Window_func_init';
    
    I_signal_win = Window_func.*I_signal;   % The I/Q signal after window in time domain.
    Q_signal_win = Window_func.*Q_signal;
    I_signal_fft = 1/L*fft(I_signal_win);   % The fft result of I/Q signal after window.
    Q_signal_fft = 1/L*fft(Q_signal_win);
elseif Window_Flag == 2   % Window_Flag: 2, means FFT window is 'Bartlett'.
    Window_func_init = bartlett(L);   % Create the Bartlett window.
    Window_func = Window_func_init';
    
    I_signal_win = Window_func.*I_signal;
    Q_signal_win = Window_func.*Q_signal;
    I_signal_fft = 1/L*fft(I_signal_win);
    Q_signal_fft = 1/L*fft(Q_signal_win);
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% De-modulation Implementation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Demod_Point = fix(Demod_Bandwidth/(2*(Fs/L)))+1;   % The effective point number of IQ capture(point number of de-modulation)

Demod_Ai = [];   % Define a new empty Demod_Ai matrix used for 'for loop'.
for index_f_num = (1:1:Demod_Point+1)   % Index_f_num define the number of FFT result points that are used to do de-modulation.
                                         % This number related to de-modulation bandwidth.
    Demod_Ai_buff = Demod_Ai_Nw_Pw(I_signal_fft,Q_signal_fft,index_f_num);   % The de-modulation process of I signal.
    Demod_Ai = [Demod_Ai_buff(1) Demod_Ai Demod_Ai_buff(2)];   % Merge the de-modulation result.
end
Demod_Ai = [Demod_Ai(1:Demod_Point) Demod_Ai((Demod_Point+2):end)];   % Total de-modulated I signal.
clear index_f_num Demod_Ai_buff

Demod_Aq = [];   % Define a new empty Demod_Aq matrix used for 'for loop'.
for index_f_num = (1:1:Demod_Point+1)    % Index_f_num define the number of FFT result points that are used to do de-modulation.
                                          % This number related to de-modulation bandwidth.
    Demod_Aq_buff = Demod_Aq_Nw_Pw(I_signal_fft,Q_signal_fft,index_f_num);   % The de-modulation process of Q signal.
    Demod_Aq = [Demod_Aq_buff(1) Demod_Aq Demod_Aq_buff(2)];   % Merge the de-modulation result.
end
Demod_Aq = [Demod_Aq(1:Demod_Point) Demod_Aq((Demod_Point+2):end)];   % Total de-modulated Q signal.
clear index_f_num Demod_Aq_buff

IQ_Capture_Value = Demod_Aiq_Spectrum(Demod_Ai,Demod_Aq,Fs,L,Unit_Flag,'IQ_Capture');   % Display the spectrum of I/Q_combined after de-modulation.