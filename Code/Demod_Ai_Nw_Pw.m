function Demod_Ai = Demod_Ai_Nw_Pw(BB_RX_I_fft,BB_RX_Q_fft,Numpoint)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% De-modulation, Calculate the amplitude of RF I signal of every frequency points.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% BB_RX_I_fft: The fft of baseband RX I signal.
% BB_RX_Q_fft: The fft of baseband RX Q signal.
% Numpoint: The No.# of frequency point.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Demod_Ai: The entire de-modulation result of every frequency points.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A_Ai*Demod_Ai = b_Ai
Ai_cos_I = 2*real(BB_RX_I_fft(Numpoint));
Ai_sin_Q = (-2)*imag(BB_RX_Q_fft(Numpoint));

A_Ai = [1/2 1/2;-1/2 1/2];   % Creat factor 'A_Ai' of linear system of equations.
b_Ai = [Ai_cos_I;Ai_sin_Q];   % Creat factor 'b_Ai' of linear system of equations.
Demod_Ai = fliplr(linsolve(A_Ai,b_Ai)');   % Slove equations.