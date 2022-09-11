function Demod_Aiq_Spectrum_value = Demod_Aiq_Spectrum(Demod_Ai,Demod_Aq,Fs,L,Unit_Flag,Figure_Name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Output the spectrum of baseband, combined the frequency spectrum of baseband I and Q.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Demod_Ai: De-modulated I signal.
% Demod_Aq: De-modulated Q signal.
% Fs: The sampling frequency.
% L: Sampling point amount.
% Unit_Flag: The flag of unit; 0: None; 1: dB(1 -> 0dB).
% Figure_Name: The name of output figure.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Demod_Aiq_Spectrum_value: The combined frequency spectrum of baseband I and Q.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Demod_Aiq_Spectrum_buff = (Demod_Ai.*Demod_Ai+Demod_Aq.*Demod_Aq);
Demod_Aiq_Spectrum_value_init = sqrt(Demod_Aiq_Spectrum_buff);   % Create I/Q capture graph values.

if Unit_Flag == 0
    Demod_Aiq_Spectrum_value = Demod_Aiq_Spectrum_value_init;
elseif Unit_Flag == 1
    Demod_Aiq_Spectrum_value = 10*log(Demod_Aiq_Spectrum_value_init);
end

Lengh_Demod_Aiq_Spectrum_value = length(Demod_Aiq_Spectrum_value);
fw = ((-(Lengh_Demod_Aiq_Spectrum_value-1)/2:1:(Lengh_Demod_Aiq_Spectrum_value-1)/2))*(Fs/L);   % Create frequency-coordinate.

figure('Name',Figure_Name)
plot(fw,Demod_Aiq_Spectrum_value)