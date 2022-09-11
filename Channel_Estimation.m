function Matrix_H = Channel_Estimation(I_LTF_time,Q_LTF_time,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Calculate the channel matrix H.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% I_LTF_time: The received I signal of LTF.
% Q_LTF_time: The received Q signal of LTF.
% Fs: The sampling frequency.
%%%%%%%%% Output Parameters %%%%%%%%%%
% Matrix_H: The channel matrix H.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_LTF = [312.5e3*(-26) 312.5e3*(-25) 312.5e3*(-24) 312.5e3*(-23) 312.5e3*(-22) 312.5e3*(-21) 312.5e3*(-20) 312.5e3*(-19) 312.5e3*(-18) 312.5e3*(-17) 312.5e3*(-16) 312.5e3*(-15) 312.5e3*(-14) 312.5e3*(-13) 312.5e3*(-12) 312.5e3*(-11) 312.5e3*(-10) 312.5e3*(-9) 312.5e3*(-8) 312.5e3*(-7) 312.5e3*(-6) 312.5e3*(-5) 312.5e3*(-4) 312.5e3*(-3) 312.5e3*(-2) 312.5e3*(-1) 312.5e3*(1) 312.5e3*(2) 312.5e3*(3) 312.5e3*(4) 312.5e3*(5) 312.5e3*(6) 312.5e3*(7) 312.5e3*(8) 312.5e3*(9) 312.5e3*(10) 312.5e3*(11) 312.5e3*(12) 312.5e3*(13) 312.5e3*(14) 312.5e3*(15) 312.5e3*(16) 312.5e3*(17) 312.5e3*(18) 312.5e3*(19) 312.5e3*(20) 312.5e3*(21) 312.5e3*(22) 312.5e3*(23) 312.5e3*(24) 312.5e3*(25) 312.5e3*(26)];   % The frequency of subcarriers, need to be multiple of 312.5kHz and symmetric (Defined)
Num_f_LTF = f_LTF./312.5e3;   % The No.# of subcarries.

Ai_LTF = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];   % The amplitude of LTF I subcarriers.
Aq_LTF = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];   % The amplitude of LTF Q subcarriers.
Initial_IQ_LTF_FDomain = Ai_LTF+1i*Aq_LTF;   % The standard LTF in frequency domain.

Complex_IQ_LTF_time = I_LTF_time-1i*Q_LTF_time;   % Construct the complex baseband signal in time domain.

Length_Complex_IQ_LTF_time = length(Complex_IQ_LTF_time);
Complex_IQ_LTF_1 = Complex_IQ_LTF_time(1:Length_Complex_IQ_LTF_time/2);   % The complex time signal of first LTF.
Complex_IQ_LTF_2 = Complex_IQ_LTF_time(Length_Complex_IQ_LTF_time/2+1:end);   % The complex time signal of second LTF.

IQ_fft_LTF1 = FFT(Complex_IQ_LTF_1,Fs,'IQ_Imbalance_LTF1_symbol_Frequency_Domain');   % The frequency domain of imbalance IQ LTF symbol signal.
IQ_fft_LTF2 = FFT(Complex_IQ_LTF_2,Fs,'IQ_Imbalance_LTF2_symbol_Frequency_Domain');
close IQ_Imbalance_LTF1_symbol_Frequency_Domain;
close IQ_Imbalance_LTF2_symbol_Frequency_Domain;

%%%%%%%%%%%% LTF1 %%%%%%%%%%%%%%
Demod_LTF1_IQ_raw = conj(2*IQ_fft_LTF1);   % The raw data of demodulated result.

L_Demod_LTF1_IQ_raw = length(Demod_LTF1_IQ_raw);
Demod_LTF1_IQ = [Demod_LTF1_IQ_raw((L_Demod_LTF1_IQ_raw/2+2):end) Demod_LTF1_IQ_raw(1:(L_Demod_LTF1_IQ_raw/2))];   % Rearrange the demodulation result with sub-carrier position.

Length_Demod_LTF1_IQ = length(Demod_LTF1_IQ);   % The length of de-modulation result.
Demod_IQ_LTF1_Picked = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
for index = (1:1:length(Num_f_LTF))
    Demod_IQ_LTF1_buff = Demod_LTF1_IQ((Length_Demod_LTF1_IQ+1)/2+Num_f_LTF(index));   % Pick the de-modulation result of sub-carriers.
    Demod_IQ_LTF1_Picked = [Demod_IQ_LTF1_Picked Demod_IQ_LTF1_buff];   % Merge the pick result.
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%% LTF2 %%%%%%%%%%%%%%
Demod_LTF2_IQ_raw = conj(2*IQ_fft_LTF2);   % The raw data of demodulated result.

L_Demod_LTF2_IQ_raw = length(Demod_LTF2_IQ_raw);
Demod_LTF2_IQ = [Demod_LTF2_IQ_raw((L_Demod_LTF2_IQ_raw/2+2):end) Demod_LTF2_IQ_raw(1:(L_Demod_LTF2_IQ_raw/2))];   % Rearrange the demodulation result with sub-carrier position.

Length_Demod_LTF2_IQ = length(Demod_LTF2_IQ);   % The length of de-modulation result.
Demod_IQ_LTF2_Picked = [];   % Define a new empty Demod_Ai_f_sub matrix used for 'for loop'.
for index = (1:1:length(Num_f_LTF))
    Demod_IQ_LTF2_buff = Demod_LTF2_IQ((Length_Demod_LTF2_IQ+1)/2+Num_f_LTF(index));   % Pick the de-modulation result of sub-carriers.
    Demod_IQ_LTF2_Picked = [Demod_IQ_LTF2_Picked Demod_IQ_LTF2_buff];   % Merge the pick result.
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H_LTF1 = Demod_IQ_LTF1_Picked./Initial_IQ_LTF_FDomain;   % The matrix H calculated by first LTF.
H_LTF2 = Demod_IQ_LTF2_Picked./Initial_IQ_LTF_FDomain;   % The matrix H calculated by second LTF.

H_average = (H_LTF1+H_LTF2)/2;   % Average thest two matrix H.

L_H_average = length(H_average);
Matrix_H = [H_average(1:L_H_average/2) 1 H_average(L_H_average/2+1:end)];   % Add DC component in averaged matrix H.