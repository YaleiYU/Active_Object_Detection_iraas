    
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
        'Tracking_error_mc_10_mpc.mat',  ...
        'P_vari_mc_10_mpc.mat', ...
        'Cam_coord_X.mat', 'Cam_coord_Y.mat', 'Cam_coord_Z.mat' ...
        'P_k_store_mpc.mat' ...
        'x_pos.mat', 'y_pos.mat', 'z_pos.mat', ...
        };
    
    for kk=1:numel(filenames)
        load(filenames{kk})
    end
    
    %%
    % Ts_dcee = 1:1:length(P_vari_mc_10_dcee);
    
    Ts_mpc = 1:1:length(P_vari_mc_10_mpc);
    
    % Ts_entropy = 1:1:length(P_vari_mc_10_entropy);
    
    %% Domain mapping setting
    % s.th1 = -0.0714;
    % s.th2 = 0.0842;
    % s.th3 = 0.0329;
    % s.th4 = 0.0914;
    % s.th5 = 0.2443;
    % s.th6 = 0.0275;
    
    s.th1 = 26.447;
    s.th2 = 1.6016;
    s.th3 = 0.7485;
    s.th4 = 11.4793;
    s.th5 = -3.6871;
    s.th6 = -6.3225;
    
    % domain_scalar = 0.125;
    % offset_y = 0.3;
    % offset_z = 0.059; % this is the bottom safety layer
    % % data grid
    % x_coord = round(X3,4)*domain_scalar;
    % y_coord = round(Y3,4)*domain_scalar - offset_y;
    % z_coord = round(Z3,4)*domain_scalar + offset_z;
    % % Create spherical domain area
    % xmin = -3*domain_scalar;
    % xmax = 3*domain_scalar;
    % ymin = -3*domain_scalar - offset_y;
    % ymax = 3*domain_scalar - offset_y;
    % zmin = 0*domain_scalar + offset_z;
    % zmax = 3*domain_scalar + offset_z;
    % domain = [xmin xmax ymin ymax];   % Size of search area
    %
    % %%
    % % Create 3D grid
    % [row_coord, col_coord] = size(x_coord);
    % X = reshape(x_coord, row_coord*col_coord, 1);
    % Y = reshape(y_coord, row_coord*col_coord, 1);
    % Z = reshape(z_coord, row_coord*col_coord, 1);
    
    %% datasets translations and scalling
    offset_y = -0.3;
    domain_scalar = 0.125;
   
    % x = x_pos'.*domain_scalar;
    % y = (y_pos' + offset_y).*domain_scalar;
    % % y = y_pos';
    % z = z_pos'.* domain_scalar;
    
    %% datasets rotation 90 degree counterclockwise around z-axis for s1 to fit the experimental setting
    points = [x_pos; y_pos; z_pos;];
    
    theta = pi/2;
    
    Rz = [cos(theta), -sin(theta), 0;
          sin(theta), cos(theta), 0;
          0, 0, 1];
    
    R_points = Rz*points;
    
    x_rot = R_points(1,:)';
    y_rot = R_points(2,:)';
    z_rot = R_points(3,:)';
    
    % further translation and scale
    x_rot_tran_sca = x_rot.*domain_scalar;
    y_rot_tran_sca = (y_rot).*domain_scalar + offset_y;
    z_rot_tran_sca = z_rot.*domain_scalar;
    
    ex.x = x_rot_tran_sca;
    ex.y = y_rot_tran_sca;
    ex.z = z_rot_tran_sca;
    
    conc_est = Conf_Distri_Rewa_Fun(s, ex);
    
    %% trajectory planning

    %%
    figure(7)
    concSurf_est = conc_est(:, :, :);
    concSurf_est(concSurf_est >= 1)=1;
    plot3(P_k_store_mpc(:,1), P_k_store_mpc(:,2), P_k_store_mpc(:,3),'r--','LineWidth',2)
    % plot3(P_k_x, P_k_y, P_k_z,'r--','LineWidth',2)
    % plot3(Tracking_trajectory_hist_dcee.x, Tracking_trajectory_hist_dcee.y, Tracking_trajectory_hist_dcee.z,'r--','LineWidth',2)
    hold on;
    % scatter3(ex.x, ex.y, ex.z, 40, concSurf_est, 'filled');
    scatter3(x_rot_tran_sca, y_rot_tran_sca, z_rot_tran_sca, 40, concSurf_est, 'filled');
    c1=min(min(concSurf_est));
    c2=max(max(concSurf_est));
    c=colorbar;
    c.Label.String='Confidence score';
    caxis([c1 c2]);
    shading interp
    grid on
    plot3(P_k_store_mpc(end,1), P_k_store_mpc(end,2), P_k_store_mpc(end,3),'r pentagram','MarkerFaceColor','b','MarkerSize',5)  % this is to plot
    % the terminal point
    hold on;
    xlab = xlabel('$x$');
    ylab = ylabel('$y$');
    zlab = zlabel('$z$');
    set(xlab,'FontSize',12);
    set(ylab,'FontSize',12);
    set(zlab,'FontSize',12);
    set(gca,'fontsize',12); 
    view(373.7563,75.3831);
    % view(207.5244,59.0455)
    % axis([xmin xmax ymin ymax])
    axis tight
    drawnow
    fill3([1 1 1 1]*domain_scalar,[0.1+offset_y -0.1+offset_y -0.1+offset_y 0.1+offset_y], [0,0,1,1]*domain_scalar,'b') % plot the obstacles, wall
    hold on;
    % Define the edge length
    edgeLength = 0.3*domain_scalar;
    % Define the cube's center
    center = [0, offset_y, 0]; % Center at (0,0,0)
    % Define the vertices of the cube relative to the center
    X = center(1) + [-1 1 1 -1 -1 1 1 -1] * (edgeLength / 2);
    Y = center(2) + [-1 -1 1 1 -1 -1 1 1] * (edgeLength / 2);
    Z = center(3) + [-1 -1 -1 -1 1 1 1 1] * (edgeLength / 2);
    hold on;
    faces = [
        1 2 3 4; % Bottom face
        5 6 7 8; % Top face
        1 2 6 5; % Front face
        2 3 7 6; % Right face
        3 4 8 7; % Back face
        4 1 5 8; % Left face
        ];
    
    % Define the color (Red)
    color = [1 1 0];
    hold on;
    for iii = 1:size(faces,1)
        fill3(X(faces(iii,:)), Y(faces(iii,:)), Z(faces(iii,:)), color, 'FaceAlpha', 1, 'EdgeColor', 'k');
    end
    