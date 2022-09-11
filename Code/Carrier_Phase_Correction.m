function Phase_Correction = Carrier_Phase_Correction(Demod_Ai_f,Demod_Aq_f,Carrier_Phase_Error)

Demod_Length = length(Demod_Ai_f);
Phase_Current = [];
for Demod_index = (1:1:Demod_Length)
    if Demod_Ai_f(Demod_index) == 0
        if Demod_Aq_f(Demod_index) == 0
            Phase_current_buff = 0;
        elseif Demod_Aq_f(Demod_index) > 0
            Phase_current_buff = pi/2;
        elseif Demod_Aq_f(Demod_index) < 0
            Phase_current_buff = 3/2*pi;
        end
    else
        Tan_phase_current = Demod_Aq_f(Demod_index)/Demod_Ai_f(Demod_index);
        if Tan_phase_current >=0
            if Demod_Aq_f(Demod_index) >= 0
                Phase_current_buff = atan(Tan_phase_current);
            else
                Phase_current_buff = atan(Tan_phase_current)+pi;
            end
        else
            if Demod_Aq_f(Demod_index) > 0
                Phase_current_buff = atan(Tan_phase_current)+pi;
            else
                Phase_current_buff = atan(Tan_phase_current)+2*pi;
            end
        end
    end
    Phase_Current = [Phase_Current Phase_current_buff];
end

Phase_Correction = [];
for Demod_index = (1:1:Demod_Length)
    Demod_Phase_Correction_buff = rem(Phase_Current(Demod_index)-Carrier_Phase_Error(Demod_index),2*pi);
    Phase_Correction = [Phase_Correction Demod_Phase_Correction_buff];
end