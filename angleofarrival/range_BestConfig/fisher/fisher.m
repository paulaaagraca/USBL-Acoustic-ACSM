function [min_det, min_eig, std_det, pos_min_det, pos_min_eig,eig_value,eig_vector] = fisher(ri,s)
%--------------------------------------------------------------------------
% Description: For a certain sensors configuration and a known acoustic
% source positions matrix, it is calculated the Fisher Information Matrix 
% and the correspondent determinant.
%
% Note: the max obtained determinant value is correspondant to the best
% azimuth and elevation combination for which the tested sensor 
% configuration is capable of estimating its position.
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), June 2020
%--------------------------------------------------------------------------
%clear

%------options-------------------------------------------------------------
plot_FIMdet_3view = 0; %plot fisher matrix determinant vs the azimuth and elevation
plot_FIMdet = 0; %plot fisher matrix determinant vs the azimuth and elevation
plot_eigen = 0;  %plot maximum eigen value for each position
not_function = 0;%use script not as a function(note: if 1,comment first line, 
                                                         % uncomment 'clear')
single_position = 0; %use single testing source position
%--------------------------------------------------------------------------

% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 0;

if not_function == 1
    w = 0.2;
    e = sqrt(2)/2 * w;

    %Sensors' configuration [r1 r2 r3 r4];
    %r1 -> front; r2 -> left; r3 -> right; r4 -> tcop;
%     ri = [0.4    0       0       0;
%           0      e       -e      0;
%           0      -e      -e      w];
%       
%     ri = [2    0       0         0;
%           0      e       -e      0;
%           0      -e      -e      -w];
end

figure
t = 1:0.1:30;
a = cos(t);
plot(a,'k','LineWidth',2) %
ylim([-2,2])


%--------------------------------------------------------------------------
%_____POSITIONS ARRAY TO BE TESTED_________________________________________

if single_position == 0

    % define range of azimuth
    t_azimuth_deg = -179:10:179;                 % azimuth values in degrees
    t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

    % define range of elevation
    t_elevation_deg = -89:10:89;                 % elevation values in degrees
    t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

    % save sizes of azimuth and elevation matrix 
    [rownum,n_samples_azimuth] = size(t_azimuth_rad);     %number of azimuth_positions
    [rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions

    %--------------------------------------------------------------------------
    norm_s = [500]; % norm values to be tested (row)
    count = 1;      % size of vector s +1 
    count_sph = 1;  % size of vector spherical +1

    [rownum,n_samples_norm] = size(norm_s); %number of norm values to compute

    %Loops: for each norm value      (in 'norm'), 
    %       for each elevation value (in 't_elevation_rad'/'t_elevation_deg'),
    %       for all azimuth values   (in 't_azimuth_rad'/'t_azimuth_deg')
    %           save all combination of [azimuth; elevation; norm] in:
    %               - cartesian coordinates in 's' 
    %               - spherical coordinates in 'spherical'
    for n = 1:n_samples_norm
        for i = 1:n_samples_elevation
            for k = 1:n_samples_azimuth

                % convert spherical to cartesian coordinates
                [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm_s);

                % accumulate cartesian coordinates in matrix's collumns
                s(:,count) = [x,y,z]'; 
                count = count+1;

                % accumulate spherical coordinates in matrix's collumns
                spherical(:,count_sph) = [t_azimuth_deg(k),t_elevation_deg(i), norm_s]';
                count_sph = count_sph + 1;

            end
        end
    end
else
    %s=[1000;0;-1000]; 
    %s=[1000.00133965043;-0.239395036515780;-100.136022502969];
end
[rownum,length_s] = size(s); %number of samples to compute

%--------------------------------------------------------------------------
%_____FISHER INFORMATION MATRIX CALCULATION________________________________

%Loop: runs all positions to be tested (vector s)
for i=1:length_s
    
    ti = zeros(4,1); %initialize TOA vector
    for k=1:4
        % times of arrival from the source to the 4 hydrophones
        ti(k) = t0 + norm(ri(:,k) - s(:,i)) / cs;
    end
    
    %vector that conects each sensor to the acoustic source

    d1 = ri(:,1) - s(:,i);
    d2 = ri(:,2) - s(:,i);
    d3 = ri(:,3) - s(:,i);
    d4 = ri(:,4) - s(:,i);
    
    d1_norm = ti(1)*cs;
    d2_norm = ti(2)*cs;
    d3_norm = ti(3)*cs;
    d4_norm = ti(4)*cs;

    %first collumn of Jacobian matrix
%     col_jacob1 = (d1')/norm(d1);
%     col_jacob2 = (d2')/norm(d2);
%     col_jacob3 = (d3')/norm(d3);
%     col_jacob4 = (d4')/norm(d4);
    col_jacob1 = (d1')/d1_norm;
    col_jacob2 = (d2')/d2_norm;
    col_jacob3 = (d3')/d3_norm;
    col_jacob4 = (d4')/d4_norm;

    %jacobian matrix
    jacob = (1/cs) * [col_jacob1;
                      col_jacob2;
                      col_jacob3;
                      col_jacob4];

    %transposed jacobian matrix
    jacob_tran = jacob';

    %variance value
    dev = 5e-7;%(4*6e-3/1500);

    %covariance matrix
    covariance = [1/(dev^2) 0 0 0;
                  0 1/(dev^2) 0 0;
                  0 0 1/(dev^2) 0;
                  0 0 0 1/(dev^2)];

    %Fisher Information Matrix (FIM)
    fisher_info = jacob_tran*covariance*jacob;
    
    %confirmation matrix
%   fisher_info = (1/cs^2)*(1/var^2)*((d1*d1'/norm(d1)^2) + ...
%                                     (d2*d2'/norm(d2)^2) + ...
%                                     (d3*d3'/norm(d3)^2) + ...
%                                     (d4*d4'/norm(d4)^ 2));
    
    %------------------------------------------------------
    % D optimality - minimum determinant of inverse of information matrix
    %determinant of FIM
    %for each position, it plots the sphere radius of the deviation error
    %(considers that the deviation standard is a sphere and not a elipsoid)
    determinant_fisher(i) = det(fisher_info^(-1))^(1/6);
    %determinant_fisher(i) = det(fisher_info^(-1));
    eig_vector = zeros(3,3);
    %------------------------------------------------------
    % E optimality - maximizes the minimum eigenvalue of the information matrix
    % eigen values of the inverted fisher matrix gives the deviation error
    % in each axis of the elipsoid.
    %(max eigen value is the max deviation which corresponds to a specific axis)
    %eig_value(:,i) = eig(fisher_info^(-1));
    [eig_vector,eig_value] = eig(fisher_info^(-1));
    eigen_fisher(i) = max(eig_value(:))^.5;
   
    %eig_value(:,i) = eig(fisher_info);
    %eigen_fisher(i) = min(eig_value(:,i));
    
    %------------------------------------------------------
    % A optimality - minimum trace of the inverse fisher matrix
    inv_fisher_info = fisher_info^(-1);
    trace_inf_A = 0;
    [n_rows,n_col] = size(inv_fisher_info);
    for i = 1:n_rows
        diag_opposite(i) = inv_fisher_info(i,n_col-i+1);
        trace_inf_A = trace_inf_A + diag_opposite(i);
    end
    
    %------------------------------------------------------
    % T optimality - max trace of the fisher matrix
    trace_inf_T = 0;
    [n_rows,n_col] = size(fisher_info);
    for i = 1:n_rows
        diag_opposite(i) = fisher_info(i,n_col-i+1);
        trace_inf_T = trace_inf_T + diag_opposite(i);
    end
    
    %------------------------------------------------------
    % G optimality
    fisher_info = s(:,i)'.* fisher_info^(-1) .* s(:,i);
    g_optimal_diagonal = diag(fisher_info);
    g_optimal_max = max(g_optimal_diagonal);
    
end 

%---------------------------------------------
%----VOLUME SPHERE----------------------------
% us_volume = (4/3)*pi*determinant_fisher^3;
% determinant_fisher = us_volume;
%---------------------------------------------
%---------------------------------------------

%---------------------------------------------
%----VOLUME ELLIPSOID----------------------------
% ue_volume = (4/3)*pi*eig_value(1,1)*eig_value(2,1)*eig_value(3,1);
% determinant_fisher = ue_volume;
%---------------------------------------------
%---------------------------------------------

%eig_value_tot = eig_value(1,1) + eig_value(2,1) + eig_value(3,1);

%CHANGEDCHANGEDCHANGEDCHANGEDCHANGEDCHANGEDCHANGEDCHANGEDCHANGEDCHANGED
[min_det,ind_min_det] = min(determinant_fisher); %max radius of sphere
[min_eig,ind_min_eig] = min(eigen_fisher); %min radius of sphere
std_det = std(determinant_fisher); %standard deviation


if single_position == 0
    pos_min_det = spherical(:,ind_min_det);
    pos_min_eig = spherical(:,ind_min_eig);
else
    pos_min_det = NaN;
    pos_min_eig = NaN;
end

%************************** PLOT OPTIONS **********************************
if plot_FIMdet == 1 && single_position == 0
    figure(1)
    
    % 3D (azimuth,elevation, determinant_fisher)
    scatter3(spherical(1,:),spherical(2,:),determinant_fisher,40,'g','filled')

    title('Uncertainty of Estimation (determinant)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Radius (m)');
end

if plot_FIMdet_3view == 1 && single_position == 0
    figure(1)
    
    % 3D (azimuth,elevation, determinant_fisher)
    subplot(1,3,1)
    scatter3(spherical(1,:),spherical(2,:),determinant_fisher,40,'g','filled')

    title('Uncertainty of Estimation (determinant)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Radius (m)');

     hold on
    
    % 2D (azimuth, determinant_fisher)
    subplot(1,3,2)
    scatter(spherical(1,:),determinant_fisher,40,'g','filled');
    xlabel('Azimuth (deg)');
    ylabel('Radius (m)');

    hold on
    
    % 2D (elevation, determinant_fisher)
    subplot(1,3,3)
     scatter(spherical(2,:),determinant_fisher,40,'g','filled');
     xlabel('Elevation (deg)');
     ylabel( 'Radius (m)');
end

if plot_eigen == 1 && single_position == 0
    figure(2)
    
    scatter3(spherical(1,:),spherical(2,:),eigen_fisher,40,'g','filled')

    title('Uncertainty of Estimation (eigen)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Maximum length of axis (m)');
    
end
end
