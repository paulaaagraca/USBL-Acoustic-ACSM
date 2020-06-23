function [mse_config,deviation_azimuth_config,deviation_elevation_config] = ...
    hydroconfig_to_mse(ri, max_dev, source_pos_single, accum_samples)
%--------------------------------------------------------------------------
% Description: Given the positions of a set of 4 hydrophones, it is
% calculated the Mean Squared Error and deviation regarding the azimuth 
% and elevation.
%   - A single configuration will be tested for various acoutic source's
%     azimuth and elevation values. It will be returned only 3 error
%     metrics
%   - For each source position, there are a number of accumulated samples  
%     witch will help evaluate the sensibility of the system to injected
%     errors
%--------------------------------------------------------------------------
% Inputs:
%   - ri:___hydrophone configuration being tested
%   - max_dev:___maximum injected error in time difference of arrival
%   - source_pos_single:___if equal to  1, estimated source positions can
%     be plotted
%   - accum_samples:___number of estimated positions which will be
%     accumulated for a certain original source position
%
% Outputs:
%   - mse_config:___Mean Squared Error of the input configuration
%   - deviation_azimuth_config:___Azimuth Standard Deviation of the input
%     configuration
%   - deviation_elevation_config:___Elevation Standard Deviation of the
%     input configurations
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------

%----test options----------------------------------------------------------
% test for single source position
plot_vectors = 1;     %plot estimated vectors for 1 source position 
                      %(defined in execution loop)
index_sourcepos = 1;  %index of source position for which is plotted estimated diff values

%other plots
plot_position_cloud = 0;    % plot positions of source
plot_error3d_azimuth = 0;   % plot error of azimuth per azimuth and elevation
plot_error3d_elevation = 0; % plot error of azimuth per azimuth and elevation
%--------------------------------------------------------------------------

%init error variales
error_azimuth = zeros();
error_elevation = zeros();
s = zeros(3,1);
spherical = zeros(3,1);
R_accum = zeros(3,1);

% maximum deviation of injected error in time differences
%max_dev = 0.5e-6; %0.5us => [-2.5º,2.5º]

% hydrophones configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> top;
%ri = [0.2   0      0      0;
%      0     0.2    -0.2   0;
%      0     0      0      2];
    
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
norm = [10000]; % norm values to be tested (row)
count = 1;     % size of vector s +1 
count_sph = 1; % size of vector spherical +1

[rownum,n_samples_norm] = size(norm); %number of norm values to compute

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
            [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm(n));
            
            % accumulate cartesian coordinates in matrix's collumns
            s(:,count) = [x,y,z]'; 
            count = count+1;

            % accumulate spherical coordinates in matrix's collumns
            spherical(:,count_sph) = [t_azimuth_deg(k),t_elevation_deg(i), norm(n)]';
            count_sph = count_sph + 1;

        end
    end
end

%testing a single source position
%s=[-100;100;50];

%--------------------------------------------------------------------------

[rownum,n_samples] = size(s); %number of samples to compute

%accum_samples = 1;
%compute error for i different samples
for i=1:n_samples
    
    %calculate real spherical coordinates
    [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));

    for k=1:accum_samples
        
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s(:,i), ri, max_dev);
        
        %----------ERROR OF INJECTED RANDOM DEVIATION----------------------
        %difference between calculated and real azimuth
        error_i_azimuth(k) = azimuth - real_azimuth*180/pi; % azimuth angle
        
        % amend variations around -180 and 180
        if (error_i_azimuth(k) > 350)
            error_i_azimuth(k) = abs(error_i_azimuth(k) - 360);
        end
        
        %difference between calculated and real elevation
        error_i_elevation(k) = elevation - real_elevation*180/pi;   %elevation angle

        %for a single source position, accumulate estimated samples
        if i == index_sourcepos && source_pos_single == 1
            R_accum(:,k) = R;   %accumulate estimated R of 1 position (to be plotted)
        end  
    end
    
    %standard deviation of azimuth
    deviation_azimuth(i) = std(error_i_azimuth);
    %standard deviation of elevation
    deviation_elevation(i) = std(error_i_elevation);

    %absolute values of error
    error_i_azimuth = abs(error_i_azimuth);
    %azimuth error for a single source position
    error_azimuth(i) = mean(error_i_azimuth);
    
    %absolute values of error
    error_i_elevation = abs(error_i_elevation);
    %elevation error for a single source position
    error_elevation(i) = mean(error_i_elevation);
    
end

%mean error
mean_azimuth = mean(error_azimuth);
mean_elevation = mean(error_elevation);

% Mean squared error (of a certain hydrophone configuration)
mse_config = sqrt(mean_azimuth^2 + mean_elevation^2);

%calculate mean of standard deviation of azimuth
deviation_azimuth_config = mean(deviation_azimuth);
%calculate mean of standard deviation of elevation
deviation_elevation_config = mean(deviation_elevation);


%************************** PLOT OPTIONS **********************************

%----plot estimated arrays for SINGLE SOURCE POSITION----------------
if source_pos_single == 1 
    if plot_vectors ==1

         [rownum,n_samples_Raccum] = size(R_accum); %number of samples to compute

         %--plot connector vectors from origin to estimated source positions--
         figure(1)

         for i=1:n_samples_Raccum
             plot3([R_accum(1,i),0],[R_accum(2,i),0],[R_accum(3,i),0],'g')
             hold on
         end

         plot3([s(1,index_sourcepos),0],[s(2,index_sourcepos),0],[s(3,index_sourcepos),0],'b')   
         title('Estimated Vectors w/ injected error');
         xlabel('y');
         ylabel('x');
         zlabel('z');

         %--plot estimated source positions------------------------------
         figure(2)

         scatter3(R_accum(1,:),R_accum(2,:),R_accum(3,:),40,'g','filled')
         hold on
         scatter3(s(1,index_sourcepos),s(2,index_sourcepos),s(3,index_sourcepos),40,'b','filled')
         title('Estimated source position w/ injected error');
         xlabel('y');
         ylabel('x');
         zlabel('z');
    end   
end

%-----plot source 3D positions-----------------------------------------------------
if plot_position_cloud == 1
    figure(3)
    scatter3(s(1,:),s(2,:),s(3,:),40,'g','filled')
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

%-----plot error of azimuth (per azimuth and elevation) in 3D------------------------
if plot_error3d_azimuth == 1
    figure(4)
        scatter3(spherical(1,:),spherical(2,:),error_azimuth,40,'g','filled')
    
    title('Error of Azimuth (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Azimuth');
end

%-----plot error of elevation (per azimuth and elevation) in 3D----------------------
if plot_error3d_elevation == 1  
    figure(5)
        scatter3(spherical(1,:),spherical(2,:),error_elevation,40,'g','filled')
    
    title('Error of Elevation (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Elevation');
end