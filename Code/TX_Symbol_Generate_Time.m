function TX_Symbol_BB = TX_Symbol_Generate_Time(f_data,f_plt,Ai_data,Ai_plt,Aq_data,Aq_plt,fc,Fs,L_Symbol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Create TX data symbol signal in time domain.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% f_data: The delta frequency of data subcarriers, one-dimensional.
% f_plt: The delta frequency of pilot subcarriers, one-dimensional.
% Ai_data & Ai_plt: The amplitude of I signal, one-dimensional.
% Aq_data & Aq_plt: The amplitude of Q signal, one-dimensional.
% fc: The frequency of center carrier.
% Fs: The sampling frequency.
% L_Symbol: Sampling point amount of data symbol.

%%%%%%%%% Output Parameters %%%%%%%%%%
% TX_Symbol_BB: The TX single data symbol in complex time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w_data = 2*pi*f_data; % The delta w of data subcarriers.
w_plt = 2*pi*f_plt; % The delta w of pilot subcarriers.
Num_data = length(f_data); % The number of data subcarriers.
Num_plt = length(f_plt); % The number of pilot subcarriers.

wc = 2*pi*fc; % The w of center carrier
Ts = 1/Fs;     % Sampling period
T = (L_Symbol-1)*Ts;   % Total sampling time
t = (0:L_Symbol-1)*Ts;    % Time vector



Ai_total = [Ai_data(1:5) Ai_plt(1) Ai_data(6:18) Ai_plt(2) Ai_data(19:24) 0 Ai_data(25:30) Ai_plt(3) Ai_data(31:43) Ai_plt(4) Ai_data(44:48)];   % The amplitude of I signal data subcarriers
Aq_total = [Aq_data(1:5) Aq_plt(1) Aq_data(6:18) Aq_plt(2) Aq_data(19:24) 0 Aq_data(25:30) Aq_plt(3) Aq_data(31:43) Aq_plt(4) Aq_data(44:48)];   % The amplitude of Q signal data subcarriers
A_total = Ai_total + Aq_total*1i;   % BB frequency domain signal of data symbol.

BB_Fre_domain_raw_data = [A_total(27:53) zeros(1,L_Symbol-53) A_total(1:26)];   % BB frequency domain signal of data symbol before iFFT, including zero filling and data shifting.
BB_Time_domain_complex_signal = ifft(L_Symbol * BB_Fre_domain_raw_data);   % BB complex time domain signal after iFFT.

% Add GI/CP
BB_Time_domain_complex_signal_wGICP = [BB_Time_domain_complex_signal(L_Symbol-6.4e4+1:end) BB_Time_domain_complex_signal];


TX_Symbol_BB = BB_Time_domain_complex_signal_wGICP;   % The complete complex TX_Symbol_BB signal.