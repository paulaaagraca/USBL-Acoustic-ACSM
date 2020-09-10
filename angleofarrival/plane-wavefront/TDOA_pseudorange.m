clear

Xv = [];
rho = [];

%--------------------------------------------------------------------------
%_____POSITIONS ARRAY TO BE TESTED_________________________________________

% define range of azimuth
t_azimuth_deg = -180:10:179;                 % azimuth values in degrees
t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

% define range of elevation
t_elevation_deg = -80:10:80;                 % elevation values in degrees
t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

% save sizes of azimuth and elevation matrix 
[rownum,n_samples_azimuth] = size(t_azimuth_rad);     %number of azimuth_positions
[rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions

%--------------------------------------------------------------------------
norm_p = [0.5]; % norm values to be tested (row)
count = 1;      % size of vector s +1 
count_sph = 1;  % size of vector spherical +1

[rownum,n_samples_norm] = size(norm_p); %number of norm values to compute

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
            [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm_p);

            % accumulate cartesian coordinates in matrix's collumns
            p(:,count) = [x,y,z]'; 
            count = count+1;

            % accumulate spherical coordinates in matrix's collumns
            spherical(:,count_sph) = [t_azimuth_deg(k),t_elevation_deg(i), norm_p]';
            count_sph = count_sph + 1;

        end
    end
end
[rownum,length_p] = size(p); %number of samples to compute

% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 0;

w = 0.1;
e = sqrt(2)/2 * w;

%__A__  
% ri = [0.02  0.02   0      0;
%       0     0      0.1    -0.1;
%       0.1   -0.1   0      0];
% %__B__  
%         ri = [0.1  0.1   0      0;
%               0     0      0.1    -0.1;
%               0.1   -0.1   0      0];
%__C__  
ri = [0.1  0     0     0;
      0    0    -e     e;
      0    0.1  -e    -e]; 

% Target's position     
%p = [0 1000 0]';

% USBL's position
s = [0 0 0]';
        

for n_pos = 1:length_p
    
    [real_azimuth,real_elevation,real_norm] = cart2sph(p(1,n_pos),p(2,n_pos),p(3,n_pos));
    r_a = real_azimuth*180/pi;
    r_e = real_elevation*180/pi;
    
    for j=1:100
        
        % Times of arrival
        ti = zeros(4,1);
        for i=1:4
          ti(i) = t0 + norm( p(:,n_pos) - (s - ri(:,i)) ) / cs + randn()*0.5e-6;
        end
        
        % Solution
        rho =[rho, mean(ti-ones(4,1)*t0)*cs];
        S = [ri(:,1)'-ri(:,2)';
             ri(:,1)'-ri(:,3)';
             ri(:,1)'-ri(:,4)'];
        delta = [ti(1)-ti(2);
                 ti(1)-ti(3);
                 ti(1)-ti(4)];

        d = cs*(S'*S)^-1*S'*delta;

        d = d/norm(d);
        X = rho(j)*d;
        Xv = [Xv, X];
        
        [est_azimuth, est_elevation ,est_norm] = cart2sph(X(1,1),X(2,1),X(3,1));
        
        est_azimuth = est_azimuth * 180/pi;
        est_elevation = est_elevation * 180/pi;
        
        %----------ERROR OF INJECTED RANDOM DEVIATION----------------------
        %difference between calculated and real azimuth
        error_i_azimuth(j) = abs(est_azimuth - real_azimuth*180/pi); % azimuth angle

        % amend variations around -180 and 180
        if (error_i_azimuth(j) > 350)
            error_i_azimuth(j) = abs(error_i_azimuth(j) - 360);
        end

        %difference between calculated and real elevation
        error_i_elevation(j) = abs(est_elevation - real_elevation*180/pi); %elevation angle

        error_i_norm(j) = abs(est_norm - real_norm);
    end
    
    std_estimate_azimuth(n_pos) = std(error_i_azimuth);    
    std_estimate_elevation(n_pos) = std(error_i_elevation);
    std_estimate_norm(n_pos) = std(error_i_norm);
    
    mean_error_estimate_azimuth(n_pos) = mean(abs(error_i_azimuth));    
    mean_error_estimate_elevation(n_pos) = mean(abs(error_i_elevation));
    mean_error_estimate_norm(n_pos) = mean(abs(error_i_norm));
    
    mse_config(n_pos) = sqrt(mean_error_estimate_azimuth(n_pos)^2 + mean_error_estimate_elevation(n_pos)^2);

end

min_std_estimate_azimuth = min(std_estimate_azimuth);
min_std_estimate_elevation = min(std_estimate_elevation);
min_std_estimate_norm = min(std_estimate_norm);

% mean_mean_error_estimate_azimuth = mean(mean_error_estimate_azimuth);
% mean_mean_error_estimate_elevation = mean(mean_error_estimate_elevation);
% mean_mean_error_estimate_norm = mean(mean_error_estimate_norm);

min_mean_error_estimate_azimuth = min(mean_error_estimate_azimuth);
min_mean_error_estimate_elevation = min(mean_error_estimate_elevation);
min_mean_error_estimate_norm = min(mean_error_estimate_norm);

min_mse_config = min(mse_config);

% figure(2)
% plot3(Xv(1,:), Xv(2,:), Xv(3,:), '.', 'Markersize',1)
% hold on 
% %scatter3(p(1,:), p(2,:), p(3,:), '*')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% axis equal
    
% figure(2)
% plot3(Xv(1,:), Xv(2,:), Xv(3,:), '.', 'Markersize',1)
% hold on 
% scatter3(p(1,:), p(2,:), p(3,:), '*')
% xlabel('x');
% ylabel('y');
% zlabel('z');
% axis equal

