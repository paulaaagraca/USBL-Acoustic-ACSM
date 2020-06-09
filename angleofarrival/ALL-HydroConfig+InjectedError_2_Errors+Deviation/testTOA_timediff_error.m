%--------------------------------------------------------------------------
% Description: 
%   - Calculates the error between the original source position and the
%     estimated values by the 'testTOA_timediff' function for a certain
%     hydrophone configuration (ri)
%   - Displays options for plotting the variation of error for the
%     different source positions
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

%---test options-----------------------------------------------------------
plot_position_cloud = 0;    % plot 3D source positions
plot_error_cartesian = 1;   % plot error in cartesian coordinates
plot_error_spherical = 1;   % plot error in spherical coordinates
plot_error3d_azimuth = 1;   % plot error of azimuth per azimuth(x) and elevation(y)
plot_error3d_elevation = 1; % plot error of elevation per azimuth(x) and elevation(y)
%--------------------------------------------------------------------------

%init error variales
errorx = zeros();
errory = zeros();
errorz = zeros();
error_azimuth = zeros();
error_elevation = zeros();
error_norm = zeros();
s = zeros(3,1);

% hydrophones configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> top;
ri = [0.02  0.02   0      0;
      0     0      0.5    -0.5;
      0.5   -0.5   0      0];

% define range of azimuth
t_azimuth_deg = -45:1:45;                 % azimuth values in degrees
t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

% define range of elevation
t_elevation_deg = -60:1:60;                 % elevation values in degrees
t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

% save sizes of azimuth and elevation matrix 
[rownum,n_samples_azimuth] = size(t_azimuth_rad);  %number of azimuth_positionss
[rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions


%--------------------------------------------------------------------------

norm = [10]; % norm values to be tested (row)

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

[rownum,n_samples] = size(s); %number of samples to compute

% Loop: For each source position in vector s, calculates the real cartesian
% and spherical coordinates and subtracts them to the estimated values,
% resulting in the absolute estimation errors 
for i=1:n_samples
    
    %call function to obtain estimated cartesian and spherical coordinates
    [R,a,azimuth,elevation,norm] = testTOA_timediff(s(:,i), ri, 0.5e-6);
    
    %calculate real cartesian coordinates
    real_r = s(:,i)-a;
    
    %calculate real spherical coordinates
    [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));
    
    %compute absolute difference between estimated and real values
    errorx(i) = abs(R(1)-real_r(1));       %x coordinate
    errory(i) = abs(R(2)-real_r(2));       %y coordinate
    errorz(i) = abs(R(3)-real_r(3));       %z coordinate
    error_azimuth(i) = abs(azimuth - real_azimuth*180/pi);       % azimuth angle
    error_elevation(i) = abs(elevation - real_elevation*180/pi); %elevation angle
    error_norm(i) = abs(norm - real_norm);                       %norm
    
    % amend variations of azimuth values around -180 and 180
    if (error_azimuth(i) > 350)
        error_azimuth(i) = abs(error_azimuth(i) - 360);
    end
end


%maximum error
[max_x] = max(errorx);
[max_y] = max(errory);
[max_z] = max(errorz);
[max_azimuth] = max(error_azimuth);
[max_elevation] = max(error_elevation);
[max_norm] = max(error_norm);

%mean error
mean_x = mean(errorx);
mean_y = mean(errory);
mean_z = mean(errorz);
mean_azimuth = mean(error_azimuth);
mean_elevation = mean(error_elevation);
mean_norm = mean(error_norm);

%standard deviation
stdev_x = std(errorx);
stdev_y = std(errory);
stdev_z = std(errorz);
stdev_azimuth = std(error_azimuth);
stdev_elevation = std(error_elevation);
stdev_norm = std(error_norm);

% Mean squared error (of mean error of azimuth and elevation)
mse = sqrt(mean_azimuth^2 + mean_elevation^2);


%***** PLOT OPTIONS *******************************************************
%-----plot source 3D positions---------------------------------------------
if plot_position_cloud == 1
    figure(1)
    
    scatter3(s(1,:),s(2,:),s(3,:),40,'g','filled')
    title('Cloud of source positions')
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

%-----plot error in cartesian coordinates: x, y and z----------------------
if plot_error_cartesian == 1
    figure(2)
    
    subplot(1,3,1)
    plot(errorx)    %error of x
    title('Error of x')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,2)
    plot(errory)    %error of y
    title('Error of y')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,3)
    plot(errorz)    %error of z
    title('Error of z')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    %position window in screen
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.3, 0.7, 0.5]);
end

%-----plot error in spherical coordinates: azimuth, elevation and norm-----
if plot_error_spherical == 1 
    figure(3)
    
    subplot(1,3,1)
    plot(error_azimuth)    %error of azimuth
    title('Error of Azimuth (deg)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,2)
    plot(error_elevation)    %error of elevation
    title('Error of Elevation (deg)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,3)
    plot(error_norm)    %error of norm
    title('Error of Norm (m)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error')
    
    %position window in screen
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
end

%-----plot error of azimuth (per azimuth and elevation) in 3D--------------
if plot_error3d_azimuth == 1
    figure(4)
    scatter3(spherical(1,:),spherical(2,:),error_azimuth,40,'g','filled')
    
    title('Error of Azimuth (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Azimuth');
end

%-----plot error of elevation (per azimuth and elevation) in 3D------------
if plot_error3d_elevation == 1  
    figure(5)
    scatter3(spherical(1,:),spherical(2,:),error_elevation,40,'g','filled')
    
    title('Error of Elevation (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Elevation');
end
