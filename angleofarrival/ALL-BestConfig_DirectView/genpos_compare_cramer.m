
clear

% x = -1000:400:1000;
% y = -1000:400:1000;
% z = -1000:400:1000;
% 
% length_s = 1;
% for xi = 1:length(x)
%     for yi = 1:length(y)
%         for zi = 1:length(z)
%             s(:,length_s) = [x(xi);y(yi);z(zi)];
%             length_s = length_s + 1;
%         end
%     end
% end

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
    
[rownum,length_s] = size(s); %number of samples to compute

for i = 1:length_s
    [ind_best_config_both(i), ind_best_config_mse(i), estimate_s(:,i)] = test_config4position_timediff( s(:,i) );
end

save('../study_Cramer-Rao/best_config_view_both_1808930_ac1000_gen10.mat', 'ind_best_config_both', '-mat')
save('../study_Cramer-Rao/estimated_s_both_1808930_ac1000_gen10.mat', 'estimate_s', '-mat')

save('../study_Cramer-Rao/best_config_view_mse_1808930_ac1000_gen10.mat', 'ind_best_config_mse', '-mat')
save('../study_Cramer-Rao/estimated_s_mse_1808930_ac1000_gen10.mat', 'estimate_s', '-mat')