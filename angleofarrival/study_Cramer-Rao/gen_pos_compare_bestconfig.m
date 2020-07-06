clear

 % define range of azimuth
    t_azimuth_deg = -180:30:180;                 % azimuth values in degrees
    t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

    % define range of elevation
    t_elevation_deg = -89:30:89;                 % elevation values in degrees
    t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

    % save sizes of azimuth and elevation matrix 
    [rownum,n_samples_azimuth] = size(t_azimuth_rad);     %number of azimuth_positions
    [rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions

    %--------------------------------------------------------------------------
    norm_s = [1000]; % norm values to be tested (row)
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


%load best configurations from my script for positions in s
opt2 = 0;
if opt2 == 0
    load('best_config_view_mse216_ac1000_gen10_rightrandn.mat', 'ind_best_config');
    load('estimated_s_mse216_ac1000_gen10_rightrandn.mat', 'estimate_s');
else
    load('best_config_view_mse_1808930_ac1000_gen10.mat', 'ind_best_config_mse');
    load('estimated_s_mse_1808930_ac1000_gen10.mat', 'estimate_s');

    ind_best_config = ind_best_config_mse;
end
n_diff_elements = 0;

for i = 1:length(ind_best_config)
    [best_rad_view_ind(i),diff_radius_myvsfisher(i)] = config_gen_fisher( estimate_s(:,i), ind_best_config(i));
    
    if best_rad_view_ind(i) ~= ind_best_config(i)
        n_diff_elements = n_diff_elements+1;
    end
end

%save('../study_Cramer-Rao/best_config_view_fisher.mat', 'best_rad_view_ind', '-mat')

max_diff = max(diff_radius_myvsfisher);

plot (diff_radius_myvsfisher)


% for i=1:100000
%     
%     a(i) = randn();
% end
%     plot(a)
%     std(a)    % desvio padrão
%     mean(a)   % média