function Constellation_Plot(Demod_Ai_1,Demod_Aq_1,Demod_Ai_2,Demod_Aq_2,Demod_Ai_3,Demod_Aq_3,Figure_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Function %%%%%%%%%%%%%%%
% Plot constellation.

%%%%%%%%% Input Parameters %%%%%%%%%%%
% Demod_Ai: Ai de-modulation result.
% Demod_Aq: Aq de-modulation result.

%%%%%%%%% Output Parameters %%%%%%%%%%
% Void.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure('Name',Figure_name)
plot(Demod_Ai_1,Demod_Aq_1,'.','MarkerSize',10);
hold on
plot(Demod_Ai_2,Demod_Aq_2,'.','MarkerSize',10);
hold on
plot(Demod_Ai_3,Demod_Aq_3,'.','MarkerSize',10);
hold on
plot([-3,-3],ylim,'g:','LineWidth',0.5);
plot([-1,-1],ylim,'g:','LineWidth',0.5);
plot([1,1],ylim,'g:','LineWidth',0.5);
plot([3,3],ylim,'g:','LineWidth',0.5);
plot(xlim,[-3,-3],'g:','LineWidth',0.5);
plot(xlim,[-1,-1],'g:','LineWidth',0.5);
plot(xlim,[1,1],'g:','LineWidth',0.5);
plot(xlim,[3,3],'g:','LineWidth',0.5);
box off