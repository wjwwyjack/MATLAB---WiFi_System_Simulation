function Frequency_Error_Result = Frequency_Error_Calculation(I_Signal_LTF,Q_Signal_LTF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Calculate the Frequency error with LTF.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_Signal_LTF: The received BB I signal of LTF.
% Q_Signal_LTF: The received BB Q signal of LTF.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Frequency_Error_Result: The calculated Frequency error result.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T_LTF_Single = 3.2e-6;   % The time period of of single LTF symbol.
L_LTF_Single = 2.56e5;   % Sampling point amount of single LTF symbol.

Real_Middle_z_Sum = 0;   % Define the sum of Middle z real component.
Imag_Middle_z_Sum = 0;   % Define the sum of Middle z imaginary component.
% Calculate the Middle_z of each LTF point, then sum up to calculate the phase result.
for LTF1_idx = (1:1:L_LTF_Single)   % Index of LTF1 point.
    LTF2_idx = LTF1_idx+L_LTF_Single;   % Index of LTF2 point.
    Complex_LTF1 = I_Signal_LTF(LTF1_idx)-1i*Q_Signal_LTF(LTF1_idx);   % Generate the complex signal in time domain of LTF1.
    Complex_LTF2 = I_Signal_LTF(LTF2_idx)-1i*Q_Signal_LTF(LTF2_idx);   % Generate the complex signal in time domain of LTF2.
    
    Middle_z = Complex_LTF1*conj(Complex_LTF2);   % Middle parameter 'z' to calculate phase result.
    Real_Middle_z = real(Middle_z);
    Imag_Middle_z = imag(Middle_z);
    
    Real_Middle_z_Sum = Real_Middle_z_Sum+Real_Middle_z;   % Sum up the real component of middle parameter 'z'.
    Imag_Middle_z_Sum = Imag_Middle_z_Sum+Imag_Middle_z;   % Sum up the imaginary component of middle parameter 'z'.
end

% Calculate the phase result.
if (Real_Middle_z_Sum > 0) && (Imag_Middle_z_Sum > 0)
    Phase_Calulate_Result = atan(abs(Imag_Middle_z_Sum)/abs(Real_Middle_z_Sum));
end

if (Real_Middle_z_Sum < 0) && (Imag_Middle_z_Sum > 0)
    Phase_Calulate_Result = atan(abs(Imag_Middle_z_Sum)/abs(Real_Middle_z_Sum))+pi/2;
end

if (Real_Middle_z_Sum > 0) && (Imag_Middle_z_Sum < 0)
    Phase_Calulate_Result = -atan(abs(Imag_Middle_z_Sum)/abs(Real_Middle_z_Sum));
end

if (Real_Middle_z_Sum < 0) && (Imag_Middle_z_Sum < 0)
    Phase_Calulate_Result = -atan(abs(Imag_Middle_z_Sum)/abs(Real_Middle_z_Sum))-pi/2;
end

if Real_Middle_z_Sum == 0
    if Imag_Middle_z_Sum > 0
        Phase_Calulate_Result = pi/2;
    end
    if Imag_Middle_z_Sum < 0
        Phase_Calulate_Result = -pi/2;
    end
end

if Imag_Middle_z == 0
    if Real_Middle_z > 0
        Phase_Calulate_Result = 0;
    end
    if Real_Middle_z < 0
        Phase_Calulate_Result = pi;
    end
end

% Calculate the Frequency error result based on phase result.
Frequency_Error_Result = Phase_Calulate_Result/T_LTF_Single/(2*pi);