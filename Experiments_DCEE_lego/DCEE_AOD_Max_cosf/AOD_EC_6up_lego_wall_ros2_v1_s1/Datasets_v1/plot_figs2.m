

%% Plot Function 
close all
clear
clc


%%
set(groot, 'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
set(0, 'defaultFigureUnits', 'centimeters', 'defaultFigurePosition', [0 0 16 9]);


%%

filenames={ 
           'Tracking_error_mc_10_dcee.mat', ...
           'P_vari_mc_10_dcee.mat',  ...
           'Tracking_error_mc_10_mpc.mat',  ...
           'P_vari_mc_10_mpc.mat', ...
           'Tracking_error_mc_10_entropy.mat',  ...
           'P_vari_mc_10_entropy.mat', ...
          };
 
 for kk=1:numel(filenames)
     load(filenames{kk})
 end


%% 


%%
% xmin = -3;
% xmax = 3;
% ymin = -3;
% ymax = 3;
% 
% x_coord = round(X3,4);
% y_coord = round(Y3,4);
% z_coord = round(Z3,4);
% 
% % Create 3D grid
% %     [X,Y,Z] = meshgrid(x_coord, y_coord, z_coord);
% [row_coord, col_coord] = size(x_coord);
% X = reshape(x_coord, row_coord*col_coord, 1);
% Y = reshape(y_coord, row_coord*col_coord, 1);
% Z = reshape(z_coord, row_coord*col_coord, 1);
% 
% ex.x_matrix = X;
% ex.y_matrix = Y;
% ex.z_matrix = Z;
% 
% row = row_coord*col_coord; 
% col = length(conc_est_store_dcee_7_v6)/row;
% 
% conc_est_store_dcee_7_v6 = reshape(conc_est_store_dcee_7_v6, [row,col]);


%%  
Ts_dcee = 1:1:length(P_vari_mc_10_dcee);

Ts_mpc = 1:1:length(P_vari_mc_10_mpc); 

Ts_entropy = 1:1:length(P_vari_mc_10_entropy); 


%% test dcee  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1) 
% plot(Ts_dcee, P_vari_mc_10_dcee, '- b', ...
%     'LineWidth', 1.5)
% %     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
% %     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
% %     0:Ts:T2, power_max_40251105', ': g', ...
% %     xlim([0,T_mpc]);
% my_legend = legend(' $ \mathcal{P} $, DCEE', ...
%                    ' $ \mathcal{P} $, MPC ');
% set(my_legend, 'FontSize', 12, 'Location', 'north');
% xlabel('$ n  $','FontSize', 12);
% ylabel('Variance $ \mathcal{P} $ ', 'FontSize', 12);
% 
% 
% figure(2) 
% plot(Ts_dcee, Tracking_error_mc_10_dcee, '- b', ...
%     'LineWidth', 1.5)
% %     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
% %     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
% %     0:Ts:T2, power_max_40251105', ': g', ...
% % xlim([0,T_mpc]);
% my_legend = legend(' $ \mathcal{C} $, DCEE', ...
%                    ' $ \mathcal{C} $, MPC ');
% set(my_legend, 'FontSize', 12, 'Location', 'north');
% xlabel('$ n  $','FontSize', 12);
% ylabel('Distance $ \mathcal{C} $ ', 'FontSize', 12);


%% test mpc dcee 
% figure(1) 
% plot(Ts_dcee, P_vari_mc_10_dcee, '- b', ...
%      Ts_mpc, P_vari_mc_10_mpc, '-- r', ... 
%     'LineWidth', 1.5)
% %     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
% %     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
% %     0:Ts:T2, power_max_40251105', ': g', ...
% %     xlim([0,T_mpc]);
% my_legend = legend(' $ \mathcal{P} $, DCEE', ...
%                    ' $ \mathcal{P} $, MPC ');
% set(my_legend, 'FontSize', 12, 'Location', 'north');
% xlabel('$ n  $','FontSize', 12);
% ylabel('Variance $ \mathcal{P} $ ', 'FontSize', 12);
% 
% 
% figure(2) 
% plot(Ts_dcee, Tracking_error_mc_10_dcee, '- b', ...
%      Ts_mpc, Tracking_error_mc_10_mpc, '-- r', ... 
%     'LineWidth', 1.5)
% %     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
% %     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
% %     0:Ts:T2, power_max_40251105', ': g', ...
% % xlim([0,T_mpc]);
% my_legend = legend(' $ \mathcal{C} $, DCEE', ...
%                    ' $ \mathcal{C} $, MPC ');
% set(my_legend, 'FontSize', 12, 'Location', 'north');
% xlabel('$ n  $','FontSize', 12);
% ylabel('Distance $ \mathcal{C} $ ', 'FontSize', 12);

% 
%% dcee mpc entropy 
figure(3) 
plot(Ts_dcee, P_vari_mc_10_dcee, '- b', ...
     Ts_mpc, P_vari_mc_10_mpc, '-- r', ... 
     Ts_entropy, P_vari_mc_10_entropy, '-. g', ... 
    'LineWidth', 1.5)
%     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
%     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
%     0:Ts:T2, power_max_40251105', ': g', ...
%     xlim([0,T_mpc]);
my_legend = legend(' $ \mathcal{P} $, DCEE', ...
                   ' $ \mathcal{P} $, MPC ', ...
                   ' $ \mathcal{P} $, Entropy ');
set(my_legend, 'FontSize', 12, 'Location', 'north');
xlabel('$ n  $','FontSize', 12);
ylabel('Variance $ \mathcal{P} $ ', 'FontSize', 12);


figure(4) 
plot(Ts_dcee, Tracking_error_mc_10_dcee, '- b', ...
     Ts_mpc, Tracking_error_mc_10_mpc, '-- r', ... 
     Ts_entropy, Tracking_error_mc_10_entropy, '-. g', ... 
    'LineWidth', 1.5)
%     0:Ts:T, power_lksdcee_N10n2_25_1, '- k', ... 
%     0:Ts:T, power_lksdcee_cl_N50_taud2000_dd10_k50, '- b', ...
%     0:Ts:T2, power_max_40251105', ': g', ...
% xlim([0,T_mpc]);
my_legend = legend(' $ \mathcal{C} $, DCEE', ...
                   ' $ \mathcal{C} $, MPC ', ...
                   ' $ \mathcal{C} $, Entropy ');
set(my_legend, 'FontSize', 12, 'Location', 'north');
xlabel('$ n  $','FontSize', 12);
ylabel('Distance $ \mathcal{C} $ ', 'FontSize', 12);

 
%%
% figure(5)
% subplot(2,1,1)
% plot(Ts_dcee, Tracking_error_mc_10_dcee, '- b', ...
%      Ts_mpc, Tracking_error_mc_10_mpc, '-- r', ... 
%      Ts_entropy(1:150), Tracking_error_mc_10_entropy(1:150), '-. g', ... 
%     'LineWidth', 1.5)
% my_legend = legend(' $ \mathcal{D} $, DCEE', ...
%                    ' $ \mathcal{D} $, MPC ', ...
%                    ' $ \mathcal{D} $, Entropy ');
% set(my_legend, 'FontSize', 12, 'Location', 'north', 'Orientation', 'horizontal');
% xlabel('$ t[s]  $','FontSize', 12);
% ylabel('Distance $ \mathcal{D} $ ', 'FontSize', 12);
% 
% 
% subplot(2,1,2)
% plot(Ts_dcee, P_vari_mc_10_dcee, '- b', ...
%      Ts_mpc, P_vari_mc_10_mpc, '-- r', ... 
%      Ts_entropy(1:150), P_vari_mc_10_entropy(1:150), '-. g', ... 
%     'LineWidth', 1.5)
% my_legend = legend(' $ \mathcal{P} $, DCEE', ...
%                    ' $ \mathcal{P} $, MPC ', ...
%                    ' $ \mathcal{P} $, Entropy ');
% set(my_legend, 'FontSize', 12, 'Location', 'north', 'Orientation', 'horizontal');
% xlabel('$  t[s]  $','FontSize', 12);
% ylabel('Variance $ \mathcal{P} $ ', 'FontSize', 12);


%%
% figure(6)
% subplot(2,1,1)
% plot(Ts_dcee, Tracking_error_mc_10_dcee, '- b', ...
%      Ts_entropy(1:150), Tracking_error_mc_10_entropy(1:150), '-. g', ... 
%     'LineWidth', 1.5)
% my_legend = legend(' $ \mathcal{D} $, DCEE', ...
%                    ' $ \mathcal{D} $, Entropy ');
% set(my_legend, 'FontSize', 12, 'Location', 'north', 'Orientation', 'horizontal');
% xlabel('$ t[s]  $','FontSize', 12);
% ylabel('Distance $ \mathcal{D} $ ', 'FontSize', 12);
% 
% 
% subplot(2,1,2)
% plot(Ts_dcee, P_vari_mc_10_dcee, '- b', ...
%      Ts_entropy(1:150), P_vari_mc_10_entropy(1:150), '-. g', ... 
%     'LineWidth', 1.5)
% my_legend = legend(' $ \mathcal{P} $, DCEE', ...
%                    ' $ \mathcal{P} $, Entropy ');
% set(my_legend, 'FontSize', 12, 'Location', 'north', 'Orientation', 'horizontal');
% xlabel('$  t[s]  $','FontSize', 12);
% ylabel('Variance $ \mathcal{P} $ ', 'FontSize', 12);


%%
% figure(8)
% hold off
% concSurf_est = conc_est_store_dcee_7_v6(:,end);
% concSurf_est(concSurf_est >= 1)=1;
% scatter3(ex.x_matrix, ex.y_matrix, ex.z_matrix, 40, concSurf_est, 'filled');
% %         pcolor(ex.x_matrix(:,:,1),ex.y_matrix(:,:,1),(concSurf))
% %         scatter3(ex.x_matrix(:,:,1), ex.y_matrix(:,:,1), ex.z_matrix(:,:,1), 40, concSurf, 'filled');
% % colormap(bluewhitered(256)), colorbar
% c1=min(min(concSurf_est));
% c2=max(max(concSurf_est));
% % caxis([-4 log10(c2)]);
% c=colorbar;
% c.Label.String='Confidence score';
% c.Limits=[0,1];
% shading interp
% grid on
% hold on
% % S(i) = 5+ceil(D(i)*5e4);
% % scatter3(theta.th1,theta.th2,theta.th3, 3, 'g','filled')
% plot3(P_k_store_dcee_7_v6(end,1), P_k_store_dcee_7_v6(end,2), P_k_store_dcee_7_v6(end,3),'r pentagram','MarkerFaceColor','b','MarkerSize',10)
% plot3(P_k_store_dcee_7_v6(:,1), P_k_store_dcee_7_v6(:,2), P_k_store_dcee_7_v6(:,3),'r--','LineWidth',2)
% % plot3(s.th1,s.th2,s.th3,'k.','markersize',20)
% xlab = xlabel('$x$');
% ylab = ylabel('$y$');
% zlab = zlabel('$z$');
% set(xlab,'FontSize',12);
% set(ylab,'FontSize',12);
% set(zlab,'FontSize',12);
% set(gca,'fontsize',12)
% % view(-3.0716, 25.2983)
% % view(-75.2970, 33.8088)
% view(58.7896,50.6375)
% % campos([pos.x_matrix, pos.y_matrix, pos.z_matrix])
% axis([xmin xmax ymin ymax])
% fill3([-0.2 -0.2 0.2 0.2],[-0.2 0.2 0.2 -0.2], [0.1,0.1,0.1,0.1],'r') % plot the object of interest, legos
% fill3([-1 1 1 -1],[-0.5 -0.5 -0.5 -0.5], [0,0,1,1],'b') % plot the obstacles, wall
% % view(az, el);
% drawnow

