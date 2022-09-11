function Carrier_Phase_Error = Carrier_Phase_Error_Calculate(Demod_Ai_f_plt,Demod_Aq_f_plt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Calculate the phase error based on pilot sub-carriers.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Demod_Ai_f_plt: The Ai de-modulation result of pilot sub-carriers.
% Demod_Aq_f_plt: The Aq de-modulation result of pilot sub-carriers.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Carrier_Phase_Error: The phase error of every data sub-carriers based on the calculate result of pilot sub-carriers and linear fitting.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Demod_plt_Length = length(Demod_Ai_f_plt);
Pilot_Phase_Error = [];
for plt_index = (1:1:Demod_plt_Length)
    if Demod_Ai_f_plt(plt_index) == 0   % These judgement statement is to ensure the range of pilot cub-carriers' current phase is 0~2pi.
        if Demod_Aq_f_plt(plt_index) == 0
            Phase_current = 0;
        elseif Demod_Aq_f_plt(plt_index) > 0
            Phase_current = pi/2;
        elseif Demod_Aq_f_plt(plt_index) < 0
            Phase_current = 3/2*pi;
        end
    else
        Tan_phase_current = Demod_Aq_f_plt(plt_index)/Demod_Ai_f_plt(plt_index);
        if Tan_phase_current >=0
            if Demod_Aq_f_plt(plt_index) >= 0
                Phase_current = atan(Tan_phase_current);
            else
                Phase_current = atan(Tan_phase_current)+pi;
            end
        elseif Tan_phase_current < 0
            if Demod_Aq_f_plt(plt_index) > 0
                Phase_current = atan(Tan_phase_current)+pi;
            else
                Phase_current = atan(Tan_phase_current)+2*pi;
            end
        end
    end
    
    Pilot_Phase_Error =[Pilot_Phase_Error Phase_current-(0)];   % Calculate the phase error of every pilot sub-carriers, the standard phase of pilot sub-carriers is '0'.

end
clear plt_index;

Pilot_Phase_Error_Length = length(Pilot_Phase_Error);
for plt_index = (1:1:Pilot_Phase_Error_Length-1)   % The phase error should be increased with the frequency of pilot sub-carriers increased, this loop is used to compensate the initial calculation result of phase error to ensure this condition.
    while Pilot_Phase_Error(plt_index) > Pilot_Phase_Error(plt_index+1)
        Pilot_Phase_Error(plt_index+1) = Pilot_Phase_Error(plt_index+1)+2*pi;
    end
end

% Linear fitting the phase error of every data sub-carriers. %
Delta_Phase_Error_N21N7 = (Pilot_Phase_Error(2)-Pilot_Phase_Error(1))/14;
Delta_Phase_Error_N7P7 = (Pilot_Phase_Error(3)-Pilot_Phase_Error(2))/14;
Delta_Phase_Error_P7P21 = (Pilot_Phase_Error(4)-Pilot_Phase_Error(3))/14;

Carrier_Phase_Error_N26N22 = [];
for Carrier_Phase_Error_N26N22_index = (-5:1:-1)
    Carrier_Phase_Error_N26N22 = [Carrier_Phase_Error_N26N22 Pilot_Phase_Error(1)+Carrier_Phase_Error_N26N22_index*Delta_Phase_Error_N21N7];
end

Carrier_Phase_Error_N20N14 = [];
for Carrier_Phase_Error_N20N14_index = (1:1:7)
    Carrier_Phase_Error_N20N14 = [Carrier_Phase_Error_N20N14 Pilot_Phase_Error(1)+Carrier_Phase_Error_N20N14_index*Delta_Phase_Error_N21N7];
end

Carrier_Phase_Error_N13N8 = [];
for Carrier_Phase_Error_N13N8_index = (-6:1:-1)
    Carrier_Phase_Error_N13N8 = [Carrier_Phase_Error_N13N8 Pilot_Phase_Error(2)+Carrier_Phase_Error_N13N8_index*Delta_Phase_Error_N21N7];
end

Carrier_Phase_Error_N6N1 = [];
for Carrier_Phase_Error_N6N1_index = (1:1:6)
    Carrier_Phase_Error_N6N1 = [Carrier_Phase_Error_N6N1 Pilot_Phase_Error(2)+Carrier_Phase_Error_N6N1_index*Delta_Phase_Error_N7P7];
end

Carrier_Phase_Error_P1P6 = [];
for Carrier_Phase_Error_P1P6_index = (-6:1:-1)
    Carrier_Phase_Error_P1P6 = [Carrier_Phase_Error_P1P6 Pilot_Phase_Error(3)+Carrier_Phase_Error_P1P6_index*Delta_Phase_Error_N7P7];
end

Carrier_Phase_Error_P8P13 = [];
for Carrier_Phase_Error_P8P13_index = (1:1:6)
    Carrier_Phase_Error_P8P13 = [Carrier_Phase_Error_P8P13 Pilot_Phase_Error(3)+Carrier_Phase_Error_P8P13_index*Delta_Phase_Error_P7P21];
end

Carrier_Phase_Error_P14P20 = [];
for Carrier_Phase_Error_P14P20_index = (-7:1:-1)
    Carrier_Phase_Error_P14P20 = [Carrier_Phase_Error_P14P20 Pilot_Phase_Error(4)+Carrier_Phase_Error_P14P20_index*Delta_Phase_Error_P7P21];
end

Carrier_Phase_Error_P22P26 = [];
for Carrier_Phase_Error_P22P26_index = (1:1:5)
    Carrier_Phase_Error_P22P26 = [Carrier_Phase_Error_P22P26 Pilot_Phase_Error(4)+Carrier_Phase_Error_P22P26_index*Delta_Phase_Error_P7P21];
end

Carrier_Phase_Error = [Carrier_Phase_Error_N26N22 Carrier_Phase_Error_N20N14 Carrier_Phase_Error_N13N8 Carrier_Phase_Error_N6N1 Carrier_Phase_Error_P1P6 Carrier_Phase_Error_P8P13 Carrier_Phase_Error_P14P20 Carrier_Phase_Error_P22P26];