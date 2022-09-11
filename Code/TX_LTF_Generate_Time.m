function TX_BB_LTF = TX_LTF_Generate_Time(fc,Fs,L_LTF_Single)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Create TX LTF component including 2 LTF single symbols in time domain.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% fc: The frequency of center carrier.
% Fs: The sampling frequency.
% L_LTF_Single: Sampling point amount of single LTF symbol.

%%%%%%%%% Output Parameters %%%%%%%%%%
% TX_BB_LTF: The TX LTF component including 2 LTF single symbols and GI/CP in complex time domain.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ai_LTF_sub = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];    % The amplitude of I signal LTF subcarriers
Aq_LTF_sub = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];   % The amplitude of Q signal LTF subcarriers
A_LTF_sub = Ai_LTF_sub + Aq_LTF_sub*1i;   % BB frequency domain signal of LTF single symbol.

BB_LTF_Fre_domain_raw_data = [A_LTF_sub(27:53) zeros(1,L_LTF_Single-53) A_LTF_sub(1:26)];   % BB frequency domain signal of LTF single symbol before iFFT, including zero filling and data shifting.
BB_LTF_single_Time_domain_complex_signal = ifft(L_LTF_Single * BB_LTF_Fre_domain_raw_data);   % BB complex time domain signal after iFFT.

% Duplicate 2 times LTF sympols.
BB_LTF_total_Time_domain_complex_signal = [];
for index = (1:1:2)
    BB_LTF_total_Time_domain_complex_signal = [BB_LTF_total_Time_domain_complex_signal BB_LTF_single_Time_domain_complex_signal];
end

% Add GI/CP
BB_LTF_total_Time_domain_complex_signal_wGICP = [BB_LTF_total_Time_domain_complex_signal(2*L_LTF_Single-1.28e5+1:end) BB_LTF_total_Time_domain_complex_signal];


TX_BB_LTF = BB_LTF_total_Time_domain_complex_signal_wGICP;   % The complete complex TX_BB_LTF signal.