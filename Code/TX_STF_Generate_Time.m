function TX_BB_STF = TX_STF_Generate_Time(fc,Fs,L_STF_Single)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Create TX STF component including 10 STF single symbols in time domain.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% fc: The frequency of center carrier.
% Fs: The sampling frequency.
% L_STF_Single: Sampling point amount of single STF symbol.

%%%%%%%%% Output Parameters %%%%%%%%%%
% TX_BB_STF: The TX STF component including 10 STF single symbols in complex time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ai_STF_sub = [1 -1 1 -1 -1 1 0 -1 -1 1 1 1 1];   % The amplitude of I signal STF subcarriers
Aq_STF_sub = [1 -1 1 -1 -1 1 0 -1 -1 1 1 1 1];   % The amplitude of Q signal STF subcarriers

A_STF_sub = Ai_STF_sub + Aq_STF_sub*1i;   % BB frequency domain signal of STF single symbol.

BB_STF_Fre_domain_raw_data = [A_STF_sub(7:13) zeros(1,L_STF_Single-13) A_STF_sub(1:6)];   % BB frequency domain signal of STF single symbol before iFFT, including zero filling and data shifting.
BB_STF_single_Time_domain_complex_signal = ifft(L_STF_Single * BB_STF_Fre_domain_raw_data);   % BB complex time domain signal after iFFT.

% Duplicate 10 times STF sympols.
BB_STF_total_Time_domain_complex_signal = [];
for index = (1:1:10)
    BB_STF_total_Time_domain_complex_signal = [BB_STF_total_Time_domain_complex_signal BB_STF_single_Time_domain_complex_signal];
end


TX_BB_STF = BB_STF_total_Time_domain_complex_signal;   % The complete complex TX_BB_STF signal.