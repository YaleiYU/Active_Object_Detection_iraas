                                     
close all
clear
clc

%%
addpath('Functions')
set(groot, 'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(0, 'defaultFigureUnits', 'centimeters');
screenSize = get(0, 'ScreenSize');
% fige_pos = screenSize(1,3)/5-16;
set(0, 'defaultFigurePosition', [40 0 16 9]);

%% ros2 domain
setenv("ROS_DOMAIN_ID","0")

%%
filenames={
    'Cam_coord_X.mat', 'Cam_coord_Y.mat', 'Cam_coord_Z.mat' ...
    };

for kk=1:numel(filenames)
    load(filenames{kk});
end

%%
% % Simulated parameters for scenario 1
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

s_x = 0.0937;
s_y = -0.5885;
s_z = 0.2204;

s_k = [s_x s_y s_z];
% parameter boundary
th1min = s.th1-2*s.th1; th1max = s.th1+2*s.th1;
th2min = s.th2-2*s.th2; th2max = s.th2+2*s.th2;
th3min = s.th3-2*s.th3; th3max = s.th3+2*s.th3;
th4min = s.th4-2*s.th4; th4max = s.th4+2*s.th4;
th5min = s.th5-2*s.th5; th5max = s.th5+2*s.th5;
th6min = s.th6-2*s.th6; th6max = s.th6+2*s.th6;
domain_para = [th1min th1max th2min th2max];

%%
m.thresh = 5e-4;
scalar_domain = 0.125;
offset_y = 0.3;
offset_z = 0.059; % this is the bottom safety layer 
% data grid
x_coord = round(X3,4)*scalar_domain;
y_coord = round(Y3,4)*scalar_domain - offset_y;
z_coord = round(Z3,4)*scalar_domain + offset_z;
% Create spherical domain area
xmin = -3*scalar_domain;
xmax = 3*scalar_domain;
ymin = -3*scalar_domain - offset_y;
ymax = 3*scalar_domain - offset_y;
zmin = 0*scalar_domain + offset_z;
zmax = 3*scalar_domain + offset_z;
domain = [xmin xmax ymin ymax];   % Size of search area

%%
% Create 3D grid
[row_coord, col_coord] = size(x_coord);
X = reshape(x_coord, row_coord*col_coord, 1);
Y = reshape(y_coord, row_coord*col_coord, 1);
Z = reshape(z_coord, row_coord*col_coord, 1);
ex.x = X;
ex.y = Y;
ex.z = Z;
% Initialize starting position
% StartingPosition = [x_coord(110) y_coord(110) z_coord(110)];
StartingPosition = [0.3341 -offset_y 0.1702];

target.x = 0;
target.y = -0.3;
target.z = 0;

%%
Num_run = 1;

for mc=1:Num_run
    
    P_k = StartingPosition;  % Current position
    P_k_store_dcee = [];
    P_k_store_dcee = [P_k_store_dcee; P_k];
    pos.x = P_k(1);
    pos.y = P_k(2);
    pos.z = P_k(3);
    % confidence dispersion with true parameters
    conc = Conf_Distri_Rewa_Fun(s, ex);

    %%
    Xneighbor_store = [];
    Yneighbor_store = [];
    Zneighbor_store = [];
    pos_row_store = [];
    pos_col_store = [];
    thetaMean_store = [];

    thetaMean_store_dcee = [];
    Tracking_error_store_dcee = [];
    P_vari_store_dcee = [];
    conc_est_store_dcee = [];

    %%
    % initialise PF
    N = 20000;
    PF_Memory = 10;
    % Uniform prior distribution for parameters
    theta.th1 = th1min + (th1max-th1min) * rand(N,1);
    theta.th2 = th2min + (th2max-th2min) * rand(N,1);
    theta.th3 = th3min + (th3max-th3min) * rand(N,1);
    theta.th4 = th4min + (th4max-th4min) * rand(N,1);
    theta.th5 = th5min + (th5max-th5min) * rand(N,1);
    theta.th6 = th6min + (th6max-th6min) * rand(N,1);

    vari_th1 = var(theta.th1);
    vari_th2 = var(theta.th2);
    vari_th3 = var(theta.th3);
    vari_th4 = var(theta.th4);
    vari_th5 = var(theta.th5);
    vari_th6 = var(theta.th6);

    P_vari = vari_th1 + vari_th2 + vari_th3 + vari_th4 +vari_th5 + vari_th6;

    % Wp refers to particle weights
    Wp = ones(N, 1);
    Wpnorm = Wp./sum(Wp);
    Wp = Wpnorm;
    timestamp(1)=0;
    D=[];
    sampleHistory=P_k(1:2);

    %%
    filename = 'animation.gif';

    %% the localization of camera's position in the spherical system
    Xneighbour = zeros(1,5);
    Yneighbour = zeros(1,5);
    Zneighbour = zeros(1,5);
    [Xneighbour Yneighbour Zneighbour pos_row pos_col] = locateCamGrid(pos, x_coord, y_coord, z_coord, Xneighbour, Yneighbour, Zneighbour, pos_row_store, pos_col_store);
    %%
    % Numl= row_coord*col_coord;
    Numl=50; 
    for i = 1: Numl
        %% tracking error and parameter estimation variance 
        Tracking_error_hist(mc,i) = norm(P_k - s_k);
        P_vari_hist(mc,i) = P_vari;

        %% simulated data
        Dsim = Conf_Distri_Rewa_Fun(s, pos);
        ersize = size(Dsim);
        error = 0.05 * Dsim .* randn(ersize(1), ersize(2));
        Dsim = Dsim + error;
        Dsim(Dsim<m.thresh) = 0;
        %% ROS2 initialize node
        node_1_Dsim = ros2node('node_1_Dsim_cam');
        node_2_Dsim = ros2node('node_2_Dsim_cam');
        node_1_Pk = ros2node('node_1_Pk_posi');
        node_2_Pk = ros2node('node_2_Pk_posi');
        global conf_plt
        confSub = ros2subscriber(node_2_Dsim, "/confidence_score", @ROS2ConfCallback);
        global conf
        if isempty(conf)
            conf = 0;
        end
        %%
        D(i) = conf;
        %%
        % thetaPrev=theta;
        [theta, Wpnorm]=UpdatePF(D, theta, Wpnorm, pos, P_k_store_dcee,m,N,PF_Memory,domain);
        %% plot the animation of updating of confidence score
        thetaMean_est.th1 = mean(theta.th1);
        thetaMean_est.th2 = mean(theta.th2);
        thetaMean_est.th3 = mean(theta.th3);
        thetaMean_est.th4 = mean(theta.th4);
        thetaMean_est.th5 = mean(theta.th5);
        thetaMean_est.th6 = mean(theta.th6);
        conc_est = Conf_Distri_Rewa_Fun(thetaMean_est, ex);
        %%
        % figure(1)
        % hold off
        % concSurf = conc(:, :, :)/1;
        % concSurf(concSurf >= 1)=1;
        % scatter3(ex.x, ex.y, ex.z, 40, concSurf, 'filled');
        % c1=min(min(concSurf));
        % c2=max(max(concSurf));
        % c=colorbar;
        % c.Label.String='Confidence score';
        % shading interp
        % grid on
        % hold on
        % % scatter3(theta.th1,theta.th2,theta.th3, 3, 'g','filled')
        % plot3(pos.x, pos.y, pos.z,'r o','MarkerFaceColor','b','MarkerSize',5)
        % hold on
        % plot3(P_k_store_dcee(:,1), P_k_store_dcee(:,2), P_k_store_dcee(:,3),'r--','LineWidth',2)
        % % plot3(s.th1,s.th2,s.th3,'k.','markersize',20)
        % xlab = xlabel('$x$');
        % ylab = ylabel('$y$');
        % zlab = zlabel('$z$');
        % set(xlab,'FontSize',12);
        % set(ylab,'FontSize',12);
        % set(zlab,'FontSize',12);
        % set(gca,'fontsize',12)
        % view(393.1275,51.8414)
        % axis([xmin xmax ymin ymax])
        % drawnow

        figure(3)
        hold off
        concSurf_est = conc_est(:, :, :)/1;
        concSurf_est(concSurf_est >= 1)=1;
        plot3(P_k_store_dcee(:,1), P_k_store_dcee(:,2), P_k_store_dcee(:,3),'r--','LineWidth',2)
        hold on
        scatter3(ex.x, ex.y, ex.z, 40, concSurf_est, 'filled');
        c1=min(min(concSurf_est));
        c2=max(max(concSurf_est));
        c=colorbar;
        c.Label.String='Confidence score';
        shading interp
        grid on
        hold on
        plot3(pos.x, pos.y, pos.z,'r o','MarkerFaceColor','b','MarkerSize',5)
        hold on;
        xlab = xlabel('$x$');
        ylab = ylabel('$y$');
        zlab = zlabel('$z$');
        set(xlab,'FontSize',12);
        set(ylab,'FontSize',12);
        set(zlab,'FontSize',12);
        set(gca,'fontsize',12)
        view(393.1275,51.8414)
        % axis([xmin xmax ymin ymax])
        axis tight
        drawnow
        fill3([1 1 1 1]*scalar_domain,[0.1-offset_y -0.1-offset_y -0.1-offset_y 0.1-offset_y], [0,0,1,1]*scalar_domain,'b') % plot the obstacles, wall
        hold on;
        % Define the edge length
        edgeLength = 0.3*scalar_domain;
        % Define the cube's center
        center = [0, -offset_y, 0]; % Center at (0,0,0)
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
        color = [1 0 0];
        hold on;
        for iii = 1:size(faces,1)
            fill3(X(faces(iii,:)), Y(faces(iii,:)), Z(faces(iii,:)), color, 'FaceAlpha', 1, 'EdgeColor', 'k');
        end

        %%
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm ] = rgb2ind(im, 256);
        if i == 1
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        %%
        indx = resampleStratified(Wpnorm);
        t.x = theta.th1(indx);
        t.y = theta.th2(indx);
        %% movement of three coordinates
        [Xneighbour Yneighbour Zneighbour] = moveCamGrid(pos_row, pos_col, x_coord, y_coord, z_coord);
        Xneighbor_store = [Xneighbor_store; Xneighbour];
        Yneighbor_store = [Yneighbor_store; Yneighbour];
        Zneighbor_store = [Zneighbor_store; Zneighbour];
        %%
        tic
        M = 40;  %16;%5
        MM = 1;
        % Entrotaxis reward
        indx = resampleStratified(Wpnorm,M);
        d.th1 = theta.th1(indx);
        d.th2 = theta.th2(indx);
        d.th3 = theta.th3(indx);
        d.th4 = theta.th4(indx);
        d.th5 = theta.th5(indx);
        d.th6 = theta.th6(indx);
        %% ---------DCEE Reduction prediction at potential locations
        for k = 1:5  %for all proposed locations
            npos.x = Xneighbour(k);
            npos.y = Yneighbour(k);
            npos.z = Zneighbour(k);

            pC = Conf_Distri_Rewa_Fun(theta, npos);
            % pC(pC<m.thresh)=0;
            theta_RMSE(k)=0;
            P_vari(k)=0;
            conf_theta(k)=0;
            desC = Conf_Distri_Rewa_Fun(d, npos);
            designd = repmat(desC, 1, MM);
            mea_noise = (0.05*designd.*randn(M, MM));
            designd = designd + mea_noise;
            designd(designd >= 1) = 1;
            % designd(rand<0.1) = 0;
            designd(designd < m.thresh) = 0;
            for jj = 1:M
                for jjj = 1:MM
                    dC = designd(jj,jjj);
                    zWp = Likelihood_Like_Yee(pC, dC, Wpnorm, m);
                    zWpnorm = zWp./sum(zWp);
                    theta_mean_th123 = N*[mean(theta.th1.*zWpnorm), mean(theta.th2.*zWpnorm), mean(theta.th3.*zWpnorm), ...
                                          mean(theta.th4.*zWpnorm), mean(theta.th5.*zWpnorm), mean(theta.th6.*zWpnorm)];
                    theta_RMSE(k) = theta_RMSE(k)+sum(zWpnorm.*vecnorm([theta.th1,theta.th2, theta.th3, theta.th4, theta.th5, theta.th6]'...
                                                      -theta_mean_th123')'.^2)/(M*MM);
                    theta_mean.th1 = theta_mean_th123(1);
                    theta_mean.th2 = theta_mean_th123(2);
                    theta_mean.th3 = theta_mean_th123(3);
                    theta_mean.th4 = theta_mean_th123(4);
                    theta_mean.th5 = theta_mean_th123(5);
                    theta_mean.th6 = theta_mean_th123(6);
                    vari_th1 = var(theta.th1);
                    vari_th2 = var(theta.th2);
                    vari_th3 = var(theta.th3);
                    vari_th4 = var(theta.th4);
                    vari_th5 = var(theta.th5);
                    vari_th6 = var(theta.th6);
  
                    P_vari(k) = P_vari(k) + (vari_th1+vari_th2+vari_th3+vari_th4+vari_th5+vari_th6)/(M*MM);
                    conf_theta(k) = conf_theta(k) + Conf_Distri_Rewa_Fun(theta_mean, npos)/(M*MM);
                end
            end

        dualControlJ(k) = P_vari(k) + conf_theta(k);
        end

    %% 
    [val,ind] = max(dualControlJ);
    [B, I ] = sort(dualControlJ, 'descend');
    [val2,ind2] = min(P_vari);
    [val3,ind3] = max(conf_theta);

    %% this makes sure the arm not moving backward
        for ii = 1: 5
            kk = I(ii);

            X_neigh = Xneighbour(kk);
            Y_neigh = Yneighbour(kk);
            Z_neigh = Zneighbour(kk);

            validNextIndex = true;
            for iii = 1:size(P_k_store_dcee,1)
                if P_k_store_dcee(iii,1)==X_neigh && P_k_store_dcee(iii,2)==Y_neigh && P_k_store_dcee(iii,3)==Z_neigh
                    validNextIndex = false;
                    break;
                end
            end

            if (validNextIndex)
                break;
            end
        end

        pos.x = Xneighbour(kk);
        pos.y = Yneighbour(kk);
        pos.z = Zneighbour(kk);

        P_vari = P_vari(kk);

        %% publish the next location of camera preprocess(s,thetaMean,Wpnorm);
        posiPubmsg.position.x = pos.x;
        posiPubmsg.position.y = pos.y;
        posiPubmsg.position.z = pos.z;

        %%
        [R, quat, rotation_vector] = lookAtNoRoll(pos, target, offset_y);
        %% Pause for user input before continuing
        % input('Press Enter to move to the next position...', 's');
        %% Send motion command via ROS2 (URScript)
        command = sprintf('ros2 topic pub --once /urscript_interface/script_command std_msgs/msg/String ''{data: "def my_prog():\\nset_digital_out(1, True)\\nmovej(p[%f, %f, %f, %f, %f, %f], a=1.2, v=0.25, r=0)\\ntextmsg(\\\"motion finished\\\")\\nend"}''', pos.x, pos.y, pos.z, rotation_vector(1,1), rotation_vector(1,2), rotation_vector(1,3));
        [status, cmdout] = system(command);

        pause(1)

        %% Terminal condition
        if  conf > 0.85
            break
        end 
       
        %% localization of new location
         P_k = [pos.x pos.y pos.z];
        [pos_row pos_col] = updateCamGrid(pos_row, pos_col, ind);

        %%
        P_k_store_dcee = [P_k_store_dcee; P_k];
        indx = resampleStratified(Wpnorm);
        theta.th1 = theta.th1(indx);
        theta.th2 = theta.th2(indx);
        theta.th3 = theta.th3(indx);
        theta.th4 = theta.th4(indx);
        theta.th5 = theta.th5(indx);
        theta.th6 = theta.th6(indx);
        thetaMean = [mean(theta.th1), mean(theta.th2), mean(theta.th3), ...
                     mean(theta.th4), mean(theta.th5), mean(theta.th6),];
        thetaMean_store = [thetaMean_store; thetaMean];

        %%
        thetaMean_store_dcee = [thetaMean_store_dcee; thetaMean];

        Tracking_error = norm(P_k - s_k);
        Tracking_error_store_dcee = [Tracking_error_store_dcee; Tracking_error];

        P_vari_store_dcee = [P_vari_store_dcee; P_vari];
        conc_est_store_dcee = [conc_est_store_dcee; conc_est];

        %% tracking error and parameter estimation variance 
        P_kk.x=P_k(1); P_kk.y=P_k(2); P_kk.z=P_k(3); 
        Tracking_trajectory_hist_dcee(mc,i) = P_kk; 

    end
    indx = resampleStratified(Wpnorm);
    theta.th1 = theta.th1(indx);
    theta.th2 = theta.th2(indx);
    theta.th3 = theta.th3(indx);
    theta.th4 = theta.th4(indx);
    theta.th5 = theta.th5(indx);
    theta.th6 = theta.th6(indx);
    thetaMean = N*[mean(theta.th1.*Wpnorm), mean(theta.th2.*Wpnorm), mean(theta.th3.*Wpnorm), ...
                   mean(theta.th4.*Wpnorm), mean(theta.th5.*Wpnorm), mean(theta.th6.*Wpnorm) ];

    %%
    Tracking_error_mc_10_dcee = mean(Tracking_error_hist, 1);
    P_vari_mc_10_dcee = mean(P_vari_hist, 1);

    % posErr_N=mean(posErr,1);
    % MSE=[MSE MSE_N'];
    % distance=[distance posErr_N'];
    % timeconsu=[timeconsu mean(times,"all")];

    fprintf('==============Done for N=%d ============\n',N);

end
time=datestr(now,'yyyy_mm_dd_hh');
filename=sprintf('Result_%s.mat', time);

%%
folder = '/home/lboro/Documents/IRaaS/DCEE_active_object_detection/Experiments_DCEE/DCEE_AOD_Max_cosf/AOD_EC_6up_lego_wall_ros2_v1_s1/Datasets';

save(fullfile(folder, 'P_vari_mc_10_dcee'), 'P_vari_mc_10_dcee');
save(fullfile(folder, 'Tracking_error_mc_10_dcee'), 'Tracking_error_mc_10_dcee'); 

% save(fullfile(folder, 'Tracking_trajectory_hist_dcee'), 'Tracking_trajectory_hist_dcee'); 
save(fullfile(folder, 'P_k_store_dcee'), 'P_k_store_dcee'); 





