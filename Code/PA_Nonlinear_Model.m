function TX_RF_PA_out = PA_Nonlinear_Model(TX_RF,PA_Memory_depth,PA_Nonlinear_order,PA_Nomial_factors,PA_memory_depth_guard)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% PA Non-linearity model, create the PA out signal.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% TX_RF: PA input TX RF signal.
% PA_Memory_depth & PA_Nonlinear_order & PA_Nomial_factors & PA_memory_depth_guard: PA Non-linearity related parameters.

%%%%%%%%% Output Parameters %%%%%%%%%%
% TX_RF_PAout: TX RF signal after PA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TX_RF_Add_Zero = [zeros(1,PA_Memory_depth*PA_memory_depth_guard) TX_RF];

TX_RF_PA_out = zeros(1, length(TX_RF));
Length_TX_RF_Add_Zero = length(TX_RF_Add_Zero);
for index = (PA_Memory_depth*PA_memory_depth_guard+1:1:Length_TX_RF_Add_Zero)
    TX_RF_Add_Zero_nomial_element = [];
    for q = (0:1:PA_Memory_depth)
        for k = (1:1:PA_Nonlinear_order)
            TX_RF_Add_Zero_nomial_element = [TX_RF_Add_Zero_nomial_element TX_RF_Add_Zero(index-q*PA_memory_depth_guard)^(2*k-1)];
        end
    end
    
    TX_RF_PA_out(index-PA_Memory_depth*PA_memory_depth_guard) = PA_Nomial_factors * TX_RF_Add_Zero_nomial_element.';
end
