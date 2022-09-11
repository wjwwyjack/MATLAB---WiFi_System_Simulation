function EVM_calculation_result_Total_dB = EVM_Calculation(Demod_Ai_f_sub_1,Demod_Aq_f_sub_1,Demod_Ai_f_sub_2,Demod_Aq_f_sub_2,Demod_Ai_f_sub_3,Demod_Aq_f_sub_3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Calculate EVM.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Demod_Ai_f_sub: Demudolation result of Ai.
% Demod_Aq_f_sub: Demudolation result of Aq.

%%%%%%%%% Output Parameters %%%%%%%%%%
% EVM_average_dB: EVM calculation result.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Symbol 1 %
Ai_data_judge_1 = [];
for index_Ai_data_judge_1 = (1:48)
    if (Demod_Ai_f_sub_1(index_Ai_data_judge_1) < -2)
        Ai_data_judeg_Buff_1 = -3;
    elseif (Demod_Ai_f_sub_1(index_Ai_data_judge_1) >= -2) && (Demod_Ai_f_sub_1(index_Ai_data_judge_1) < 0)
        Ai_data_judeg_Buff_1 = -1;
    elseif (Demod_Ai_f_sub_1(index_Ai_data_judge_1) >= 0) && (Demod_Ai_f_sub_1(index_Ai_data_judge_1) < 2)
        Ai_data_judeg_Buff_1 = 1;
    elseif (Demod_Ai_f_sub_1(index_Ai_data_judge_1) >= 2)
        Ai_data_judeg_Buff_1 = 3;  
    end
    Ai_data_judge_1 = [Ai_data_judge_1 Ai_data_judeg_Buff_1];
end

Aq_data_judge_1 = [];
for index_Aq_data_judge_1 = (1:48)
    if (Demod_Aq_f_sub_1(index_Aq_data_judge_1) < -2)
        Aq_data_judeg_Buff_1 = -3;
    elseif (Demod_Aq_f_sub_1(index_Aq_data_judge_1) >= -2) && (Demod_Aq_f_sub_1(index_Aq_data_judge_1) < 0)
        Aq_data_judeg_Buff_1 = -1;
    elseif (Demod_Aq_f_sub_1(index_Aq_data_judge_1) >= 0) && (Demod_Aq_f_sub_1(index_Aq_data_judge_1) < 2)
        Aq_data_judeg_Buff_1 = 1;
    elseif (Demod_Aq_f_sub_1(index_Aq_data_judge_1) >= 2)
        Aq_data_judeg_Buff_1 = 3;  
    end
    Aq_data_judge_1 = [Aq_data_judge_1 Aq_data_judeg_Buff_1];
end


% EVM_calculation_result_1 = [];
% for index_sub = (1:48)
%     EVM_Buff_1 = sqrt(((Demod_Ai_f_sub_1(index_sub)-Ai_data_judge_1(index_sub))^2 + (Demod_Aq_f_sub_1(index_sub)-Aq_data_judge_1(index_sub))^2)/10);
%     EVM_calculation_result_1 = [EVM_calculation_result_1 EVM_Buff_1];
% end
% 
% 
% EVM_average_1 = sum(EVM_calculation_result_1,2)/48;
% EVM_average_dB_1 = 10*log(EVM_average_1);



% Symbol 2 %
Ai_data_judge_2 = [];
for index_Ai_data_judge_2 = (1:48)
    if (Demod_Ai_f_sub_2(index_Ai_data_judge_2) < -2)
        Ai_data_judeg_Buff_2 = -3;
    elseif (Demod_Ai_f_sub_2(index_Ai_data_judge_2) >= -2) && (Demod_Ai_f_sub_2(index_Ai_data_judge_2) < 0)
        Ai_data_judeg_Buff_2 = -1;
    elseif (Demod_Ai_f_sub_2(index_Ai_data_judge_2) >= 0) && (Demod_Ai_f_sub_2(index_Ai_data_judge_2) < 2)
        Ai_data_judeg_Buff_2 = 1;
    elseif (Demod_Ai_f_sub_2(index_Ai_data_judge_2) >= 2)
        Ai_data_judeg_Buff_2 = 3;  
    end
    Ai_data_judge_2 = [Ai_data_judge_2 Ai_data_judeg_Buff_2];
end

Aq_data_judge_2 = [];
for index_Aq_data_judge_2 = (1:48)
    if (Demod_Aq_f_sub_2(index_Aq_data_judge_2) < -2)
        Aq_data_judeg_Buff_2 = -3;
    elseif (Demod_Aq_f_sub_2(index_Aq_data_judge_2) >= -2) && (Demod_Aq_f_sub_2(index_Aq_data_judge_2) < 0)
        Aq_data_judeg_Buff_2 = -1;
    elseif (Demod_Aq_f_sub_2(index_Aq_data_judge_2) >= 0) && (Demod_Aq_f_sub_2(index_Aq_data_judge_2) < 2)
        Aq_data_judeg_Buff_2 = 1;
    elseif (Demod_Aq_f_sub_2(index_Aq_data_judge_2) >= 2)
        Aq_data_judeg_Buff_2 = 3;  
    end
    Aq_data_judge_2 = [Aq_data_judge_2 Aq_data_judeg_Buff_2];
end


% EVM_calculation_result_2 = [];
% for index_sub = (1:48)
%     EVM_Buff_2 = sqrt(((Demod_Ai_f_sub_2(index_sub)-Ai_data_judge_2(index_sub))^2 + (Demod_Aq_f_sub_2(index_sub)-Aq_data_judge_2(index_sub))^2)/10);
%     EVM_calculation_result_2 = [EVM_calculation_result_2 EVM_Buff_2];
% end
% 
% 
% EVM_average_2 = sum(EVM_calculation_result_2,2)/48;
% EVM_average_dB_2 = 10*log(EVM_average_2);


% Symbol 2 %
Ai_data_judge_3 = [];
for index_Ai_data_judge_3 = (1:48)
    if (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < -2)
        Ai_data_judeg_Buff_3 = -3;
    elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= -2) && (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < 0)
        Ai_data_judeg_Buff_3 = -1;
    elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= 0) && (Demod_Ai_f_sub_3(index_Ai_data_judge_3) < 2)
        Ai_data_judeg_Buff_3 = 1;
    elseif (Demod_Ai_f_sub_3(index_Ai_data_judge_3) >= 2)
        Ai_data_judeg_Buff_3 = 3;  
    end
    Ai_data_judge_3 = [Ai_data_judge_3 Ai_data_judeg_Buff_3];
end

Aq_data_judge_3 = [];
for index_Aq_data_judge_3 = (1:48)
    if (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < -2)
        Aq_data_judeg_Buff_3 = -3;
    elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= -2) && (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < 0)
        Aq_data_judeg_Buff_3 = -1;
    elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= 0) && (Demod_Aq_f_sub_3(index_Aq_data_judge_3) < 2)
        Aq_data_judeg_Buff_3 = 1;
    elseif (Demod_Aq_f_sub_3(index_Aq_data_judge_3) >= 2)
        Aq_data_judeg_Buff_3 = 3;  
    end
    Aq_data_judge_3 = [Aq_data_judge_3 Aq_data_judeg_Buff_3];
end


% EVM_calculation_result_3 = [];
% for index_sub = (1:48)
%     EVM_Buff_3 = sqrt(((Demod_Ai_f_sub_3(index_sub)-Ai_data_judge_3(index_sub))^2 + (Demod_Aq_f_sub_3(index_sub)-Aq_data_judge_3(index_sub))^2)/10);
%     EVM_calculation_result_3 = [EVM_calculation_result_3 EVM_Buff_3];
% end
% 
% 
% EVM_average_3 = sum(EVM_calculation_result_3,2)/48;
% EVM_average_dB_3 = 10*log(EVM_average_3);


% Total symbols EVM %
I2Q2_result_1 = [];
I2Q2_result_2 = [];
I2Q2_result_3 = [];
for index_sub = (1:48)
    I2Q2_Buff_1 = (Demod_Ai_f_sub_1(index_sub)-Ai_data_judge_1(index_sub))^2 + (Demod_Aq_f_sub_1(index_sub)-Aq_data_judge_1(index_sub))^2;
    I2Q2_Buff_2 = (Demod_Ai_f_sub_1(index_sub)-Ai_data_judge_2(index_sub))^2 + (Demod_Aq_f_sub_1(index_sub)-Aq_data_judge_2(index_sub))^2;
    I2Q2_Buff_3 = (Demod_Ai_f_sub_1(index_sub)-Ai_data_judge_3(index_sub))^2 + (Demod_Aq_f_sub_1(index_sub)-Aq_data_judge_3(index_sub))^2;
    I2Q2_result_1 = [I2Q2_result_1 I2Q2_Buff_1];
    I2Q2_result_2 = [I2Q2_result_2 I2Q2_Buff_1];
    I2Q2_result_3 = [I2Q2_result_3 I2Q2_Buff_1];
end
I2Q2_Total_sum = sum(I2Q2_result_1,2) + sum(I2Q2_result_2,2) + sum(I2Q2_result_3,2);
EVM_calculation_result_Total = sqrt(I2Q2_Total_sum/(48*3*10));
EVM_calculation_result_Total_dB = 10*log(EVM_calculation_result_Total);


