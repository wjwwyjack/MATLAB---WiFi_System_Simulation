function Demod_Aiq_Phase_Corrected = Demod_Correction_Of_Carrier_Phase(Demod_Ai_f,Demod_Aq_f,Carrier_Phase_Correction)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% The phase correction of de-modulation results.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Demod_Ai_f: The initial Ai de-modulation result of sub-carriers.
% Demod_Aq_f: The initial Aq de-modulation result of sub-carriers.
% Carrier_Phase_Correction: Corrected phase of sub-carriers.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Demod_Aiq_Phase_Corrected: The de-modulation result after phase correction.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Demod_Length = length(Demod_Ai_f);
Demod_Ai_Phase_Corrected = [];
Demod_Aq_Phase_Corrected = [];
for Demod_index = (1:1:Demod_Length)   % Loop for de-modulaton phase correction of every sub-carriers.
    A_square = (Demod_Ai_f(Demod_index))^2 + (Demod_Aq_f(Demod_index))^2;   % A^2 = Ai^2 + Aq^2.
    Demod_Ai_unsign_buff = sqrt(A_square/(1+(tan(Carrier_Phase_Correction(Demod_index)))^2));   % Calculate the Ai and Aq based on corrected phase.
    if (Carrier_Phase_Correction(Demod_index) >= -2*pi && Carrier_Phase_Correction(Demod_index) <= -3/2*pi) || (Carrier_Phase_Correction(Demod_index) >= -1/2*pi && Carrier_Phase_Correction(Demod_index) <= 1/2*pi) || (Carrier_Phase_Correction(Demod_index) >= 3/2*pi && Carrier_Phase_Correction(Demod_index) <= 2*pi)
        Demod_Ai_buff = Demod_Ai_unsign_buff;
    else
        Demod_Ai_buff = -Demod_Ai_unsign_buff;
    end
    Demod_Aq_buff = Demod_Ai_buff*tan(Carrier_Phase_Correction(Demod_index));
    
    Demod_Ai_Phase_Corrected = [Demod_Ai_Phase_Corrected Demod_Ai_buff];
    Demod_Aq_Phase_Corrected = [Demod_Aq_Phase_Corrected Demod_Aq_buff];
end

Demod_Aiq_Phase_Corrected = [Demod_Ai_Phase_Corrected;Demod_Aq_Phase_Corrected];   % The phase corrected Ai and Aq.