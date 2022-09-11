function Demod_Aq = Demod_Aq_Nw_Pw(BB_RX_I_fft,BB_RX_Q_fft,Numpoint)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% De-modulation, Calculate the amplitude of RF Q signal of every frequency points.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% BB_RX_I_fft: The fft of baseband RX I signal.
% BB_RX_Q_fft: The fft of baseband RX Q signal.
% Numpoint: The No.# of frequency point.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Demod_Aq: The entire de-modulation result of every frequency points.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A_Aq*Demod_Aq = b_Aq
Aq_sin_I = (-2)*imag(BB_RX_I_fft(Numpoint));
Aq_cos_Q = 2*real(BB_RX_Q_fft(Numpoint));

A_Aq = [1/2 -1/2;1/2 1/2];   % Create factor 'A_Aq' of linear system of equations.
b_Aq = [Aq_sin_I;Aq_cos_Q];   % Create factor 'b_Aq' of linear system of equations.
Demod_Aq = fliplr(linsolve(A_Aq,b_Aq)');   % Slove equations.