function [Ai_data_1,Aq_data_1,Ai_data_2,Aq_data_2,Ai_data_3,Aq_data_3] = Generate_Aiq_data(Aiq_data_random_flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Generate Aiq data(The amplitude of I/Q signal data subcarriers).

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Aiq_data_random_flag: Flag of enable random ir fix Aiq data, 1 means random, 0 means fix.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Ai_data: The amplitude of I signal data subcarriers.
% Aq_data: The amplitude of Q signal data subcarriers.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if Aiq_data_random_flag == 1
    Ai_data_1 = [];
    Random_Ai_data_1 = (rand(1,48)-0.5)*8;
    for index_Ai_data_1 = (1:48)
        if (Random_Ai_data_1(index_Ai_data_1) >= -4) && (Random_Ai_data_1(index_Ai_data_1) < -2)
            Ai_data_Buff_1 = -3;
        elseif (Random_Ai_data_1(index_Ai_data_1) >= -2) && (Random_Ai_data_1(index_Ai_data_1) < 0)
            Ai_data_Buff_1 = -1;
        elseif (Random_Ai_data_1(index_Ai_data_1) >= 0) && (Random_Ai_data_1(index_Ai_data_1) < 2)
            Ai_data_Buff_1 = 1;
        elseif (Random_Ai_data_1(index_Ai_data_1) >= 2) && (Random_Ai_data_1(index_Ai_data_1) <= 4)
            Ai_data_Buff_1 = 3;  
        end
        Ai_data_1 = [Ai_data_1 Ai_data_Buff_1];
    end

    Aq_data_1 = [];
    Random_Aq_data_1 = (rand(1,48)-0.5)*8;
    for index_Aq_data_1 = (1:48)
        if (Random_Aq_data_1(index_Aq_data_1) >= -4) && (Random_Aq_data_1(index_Aq_data_1) < -2)
            Aq_data_Buff_1 = -3;
        elseif (Random_Aq_data_1(index_Aq_data_1) >= -2) && (Random_Aq_data_1(index_Aq_data_1) < 0)
            Aq_data_Buff_1 = -1;
        elseif (Random_Aq_data_1(index_Aq_data_1) >= 0) && (Random_Aq_data_1(index_Aq_data_1) < 2)
            Aq_data_Buff_1 = 1;
        elseif (Random_Aq_data_1(index_Aq_data_1) >= 2) && (Random_Aq_data_1(index_Aq_data_1) <= 4)
            Aq_data_Buff_1 = 3;  
        end
        Aq_data_1 = [Aq_data_1 Aq_data_Buff_1];
    end
    
        Ai_data_2 = [];
    Random_Ai_data_2 = (rand(1,48)-0.5)*8;
    for index_Ai_data_2 = (1:48)
        if (Random_Ai_data_2(index_Ai_data_2) >= -4) && (Random_Ai_data_2(index_Ai_data_2) < -2)
            Ai_data_Buff_2 = -3;
        elseif (Random_Ai_data_2(index_Ai_data_2) >= -2) && (Random_Ai_data_2(index_Ai_data_2) < 0)
            Ai_data_Buff_2 = -1;
        elseif (Random_Ai_data_2(index_Ai_data_2) >= 0) && (Random_Ai_data_2(index_Ai_data_2) < 2)
            Ai_data_Buff_2 = 1;
        elseif (Random_Ai_data_2(index_Ai_data_2) >= 2) && (Random_Ai_data_2(index_Ai_data_2) <= 4)
            Ai_data_Buff_2 = 3;  
        end
        Ai_data_2 = [Ai_data_2 Ai_data_Buff_2];
    end

    Aq_data_2 = [];
    Random_Aq_data_2 = (rand(1,48)-0.5)*8;
    for index_Aq_data_2 = (1:48)
        if (Random_Aq_data_2(index_Aq_data_2) >= -4) && (Random_Aq_data_2(index_Aq_data_2) < -2)
            Aq_data_Buff_2 = -3;
        elseif (Random_Aq_data_2(index_Aq_data_2) >= -2) && (Random_Aq_data_2(index_Aq_data_2) < 0)
            Aq_data_Buff_2 = -1;
        elseif (Random_Aq_data_2(index_Aq_data_2) >= 0) && (Random_Aq_data_2(index_Aq_data_2) < 2)
            Aq_data_Buff_2 = 1;
        elseif (Random_Aq_data_2(index_Aq_data_2) >= 2) && (Random_Aq_data_2(index_Aq_data_2) <= 4)
            Aq_data_Buff_2 = 3;  
        end
        Aq_data_2 = [Aq_data_2 Aq_data_Buff_2];
    end
    
        Ai_data_3 = [];
    Random_Ai_data_3 = (rand(1,48)-0.5)*8;
    for index_Ai_data_3 = (1:48)
        if (Random_Ai_data_3(index_Ai_data_3) >= -4) && (Random_Ai_data_3(index_Ai_data_3) < -2)
            Ai_data_Buff_3 = -3;
        elseif (Random_Ai_data_3(index_Ai_data_3) >= -2) && (Random_Ai_data_3(index_Ai_data_3) < 0)
            Ai_data_Buff_3 = -1;
        elseif (Random_Ai_data_3(index_Ai_data_3) >= 0) && (Random_Ai_data_3(index_Ai_data_3) < 2)
            Ai_data_Buff_3 = 1;
        elseif (Random_Ai_data_3(index_Ai_data_3) >= 2) && (Random_Ai_data_3(index_Ai_data_3) <= 4)
            Ai_data_Buff_3 = 3;  
        end
        Ai_data_3 = [Ai_data_3 Ai_data_Buff_3];
    end

    Aq_data_3 = [];
    Random_Aq_data_3 = (rand(1,48)-0.5)*8;
    for index_Aq_data_3 = (1:48)
        if (Random_Aq_data_3(index_Aq_data_3) >= -4) && (Random_Aq_data_3(index_Aq_data_3) < -2)
            Aq_data_Buff_3 = -3;
        elseif (Random_Aq_data_3(index_Aq_data_3) >= -2) && (Random_Aq_data_3(index_Aq_data_3) < 0)
            Aq_data_Buff_3 = -1;
        elseif (Random_Aq_data_3(index_Aq_data_3) >= 0) && (Random_Aq_data_3(index_Aq_data_3) < 2)
            Aq_data_Buff_3 = 1;
        elseif (Random_Aq_data_3(index_Aq_data_3) >= 2) && (Random_Aq_data_3(index_Aq_data_3) <= 4)
            Aq_data_Buff_3 = 3;  
        end
        Aq_data_3 = [Aq_data_3 Aq_data_Buff_3];
    end
    
    
    
elseif Aiq_data_random_flag == 0
    Ai_data_1 = [1 1 -1 -1 zeros(1,44)];   % The amplitude of I signal data subcarriers
    Aq_data_1 = [1 -1 1 -1 zeros(1,44)];   % The amplitude of Q signal data subcarriers
    Ai_data_2 = [zeros(1,48)];   % The amplitude of I signal data subcarriers
    Aq_data_2 = [zeros(1,48)];   % The amplitude of Q signal data subcarriers
    Ai_data_3 = [zeros(1,48)];   % The amplitude of I signal data subcarriers
    Aq_data_3 = [zeros(1,48)];   % The amplitude of Q signal data subcarriers
%     Ai_data_2 = [3 3 3 3 -1 -1 -1 -1 1 1 1 1 -3 -3 -3 -3 3 3 3 3 -1 -1 -1 -1 1 1 1 1 -3 -3 -3 -3 1 1 1 1 -3 -3 -3 -3 3 3 3 3 -1 -1 -1 -1];   % The amplitude of I signal data subcarriers
%     Aq_data_2 = [-3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3];   % The amplitude of Q signal data subcarriers
%     Ai_data_3 = [3 3 3 3 -1 -1 -1 -1 1 1 1 1 -3 -3 -3 -3 3 3 3 3 -1 -1 -1 -1 1 1 1 1 -3 -3 -3 -3 1 1 1 1 -3 -3 -3 -3 3 3 3 3 -1 -1 -1 -1];   % The amplitude of I signal data subcarriers
%     Aq_data_3 = [-3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3];   % The amplitude of Q signal data subcarriers
end


