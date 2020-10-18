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
plot_error_cartesian = 0;   % plot error in cartesian coordinates
plot_error_spherical = 1;   % plot error in spherical coordinates
plot_error3d_azimuth = 0;   % plot error of azimuth per azimuth(x) and elevation(y)
plot_error3d_elevation = 0; % plot error of elevation per azimuth(x) and elevation(y)
%--------------------------------------------------------------------------

%init error variales
errorx = zeros();
errory = zeros();
errorz = zeros();
error_azimuth = zeros();
error_elevation = zeros();
error_norm = zeros();
s = zeros(3,1);

w = 0.1;
e = sqrt(2)/2 * w;

% hydrophones configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> top;
%__A__
% ri = [0.02  0.02   0      0;
%       0     0      0.1    -0.1;
%       0.1   -0.1   0      0];
%   
% % %__B__  
% ri = [0.1  0.1   0      0;
%       0     0      0.1    -0.1;
%       0.1   -0.1   0      0];

  
%__C__  
% ri = [0.1  0     0     0;
%       0    0    -e     e;
%       0    0.1  -e    -e];  


%%%1502
ri = [0.1  0.4   0.4   0.4;
      0    0.1   -e    -e ;
      0    0     e     -e];
  
%%%1248
% ri = [0.1  0.2   0.2   0.2;
%       0    0.1   -e    -e ;
%       0    0     e     -e];


% define range of azimuth
t_azimuth_deg = -180:1:180;                 % azimuth values in degrees
t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

% define range of elevation
t_elevation_deg = -80:1:80;                 % elevation values in degrees
t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

% save sizes of azimuth and elevation matrix 
[rownum,n_samples_azimuth] = size(t_azimuth_rad);  %number of azimuth_positionss
[rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions


%--------------------------------------------------------------------------

norm = [1000]; % norm values to be tested (row)

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

cnt_as=0;
asas = [];
asasas = [];
for as = 1:n_samples
    if ((s(2,as)) < 0.1 && (s(2,as)) > 0.1)
        if ((s(3,as)) < 0.1 && (s(3,as)) > 0.1)
            cnt_as = cnt_as + 1 ;
            asas(:,cnt_as) = s(:,as);
            asasas(cnt_as) = [asasas as];
        end
    end
end

% Loop: For each source position in vector s, calculates the real cartesian
% and spherical coordinates and subtracts them to the estimated values,
% resulting in the absolute estimation errors 
for i=1:n_samples

    %calculate real spherical coordinates
    [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));

    qw = real_azimuth*180/pi;
    wq = real_elevation*180/pi;
    
    for k=1:10
        %call function to obtain estimated cartesian and spherical coordinates
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s(:,i), ri, 0.5e-6);

            
        %calculate real cartesian coordinates
        real_r = s(:,i)-a;
        
        %compute absolute difference between estimated and real values
        errorx(k) = abs(R(1)-real_r(1));       %x coordinate
        errory(k) = abs(R(2)-real_r(2));       %y coordinate
        errorz(k) = abs(R(3)-real_r(3));       %z coordinate
        error_i_azimuth(k) = abs(azimuth - real_azimuth*180/pi);       % azimuth angle
        error_i_elevation(k) = abs(elevation - real_elevation*180/pi); %elevation angle
        error_norm(k) = abs(norm - real_norm);                       %norm

        % amend variations of azimuth values around -180 and 180
        if (error_i_azimuth(k) > 350)
            error_i_azimuth(k) = abs(error_i_azimuth(k) - 360);
        end

        if (error_i_azimuth(k) > 60)
            yty = 0;
%             if azimuth > 0 && qw < 0
%                  diff_a = 180-abs(qw);
%                  diff_azimuth = 180 - azimuth;
%                  error_azimuth(k) = diff_azimuth + diff_a;
%             end
%              if qw > 0 && azimuth < 0
%                  diff_azimuth = 180-abs(azimuth);
%                  diff_a = 180 - qw;
%                  error_azimuth(k) = diff_azimuth + diff_a;
%             end
        end
    %     if error_norm(k) >100
    %         a = 1;
    %     end
    end
                    
    %standard deviation of azimuth
    deviation_azimuth(i) = std(error_i_azimuth);
    %standard deviation of elevation
    deviation_elevation(i) = std(error_i_elevation);

    %absolute values of error
    error_ip_azimuth = abs(error_i_azimuth);
    %azimuth error for a single source position
    error_azimuth(i) = mean(error_ip_azimuth);

    %absolute values of error
    error_ip_elevation = abs(error_i_elevation);
    %elevation error for a single source position
    error_elevation(i) = mean(error_ip_elevation);

    error_norm_i(i) = mean(error_norm);
    error_x(i) = std(errorx);
    error_y(i) = std(errory);
    error_z(i) = std(errorz);
    
    if error_i_azimuth >10
        uyu=0;
    end
end


%maximum error
[max_x] = max(error_x);
[max_y] = max(error_y);
[max_z] = max(error_z);
[max_azimuth] = max(error_azimuth);
[max_elevation] = max(error_elevation);
[max_norm] = max(error_norm_i);

%maximum error
[min_x] = min(error_x);
[min_y] = min(error_y);
[min_z] = min(error_z);
[min_azimuth] = min(error_azimuth);
[min_elevation] = min(error_elevation);
[min_norm] = min(error_norm_i);

%mean error
mean_x = mean(error_x);
mean_y = mean(error_y);
mean_z = mean(error_z);
mean_azimuth = mean(error_azimuth);
mean_elevation = mean(error_elevation);
mean_norm = mean(error_norm_i);

%standard deviation
stdev_x = std(error_x);
stdev_y = std(error_y);
stdev_z = std(error_z);
stdev_azimuth = std(error_azimuth);
stdev_elevation = std(error_elevation);
stdev_norm = std(error_norm_i);

[max_azimuth_averag, ind_max_azimuth_averag] = max(deviation_azimuth);
[max_elevation_averag] = max(deviation_elevation);
std_az_averag = std(deviation_azimuth);
std_el_averag = std(deviation_elevation);

%media do desvio padrao do erro
mean_az_averag = mean(deviation_azimuth);
mean_el_averag = mean(deviation_elevation);

mean_x_averag = mean(error_x);
mean_y_averag = mean(error_y);
mean_z_averag = mean(error_z);

std_x_averag = std(error_x);
std_y_averag = std(error_y);
std_z_averag = std(error_z);

% Mean squared error (of mean error of azimuth and elevation)
mse = sqrt(mean_az_averag^2 + mean_el_averag^2);
%mse = sqrt(std_x_averag^2 + std_y_averag^2 + std_z_averag^2);

%***** PLOT OPTIONS *******************************************************
%-----plot source 3D positions---------------------------------------------
if plot_position_cloud == 1
    figure
    
    scatter3(s(1,:),s(2,:),s(3,:),40,'g','filled')
    title('Cloud of source positions')
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

%-----plot error in cartesian coordinates: x, y and z----------------------
if plot_error_cartesian == 1
    f1=figure;
    
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
    
    %saveas(f1,'../../feup-teses/figures/plots/plot-cart-A-n1000-title','jpg')
   
end

%-----plot error in spherical coordinates: azimuth, elevation and norm-----
if plot_error_spherical == 1 
    f=figure;
    
    subplot(1,3,1)
    plot(error_azimuth)    %error of azimuth
    title('Azimuth Error (deg)')
    xlabel('# of source position') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,2)
    plot(error_elevation)    %error of elevation
    title('Elevation Error (deg)')
    xlabel('# of source position') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,3)
    plot(error_norm_i)    %error of norm
    title('Norm Error (m)')
    xlabel('# of source position') 
    ylabel('Magnitude of Error')
   
    %position window in screen
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 1, 0.7, 0.6]);
    
    %saveas(f,'../../feup-teses/figures/plots/plot-s1-A-n10-inv','jpg')
      
end

%-----plot error of azimuth (per azimuth and elevation) in 3D--------------
if plot_error3d_azimuth == 1
    figure
    scatter3(spherical(1,:),spherical(2,:),deviation_azimuth,10,'g','filled')
    
    title('Error of Azimuth (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Azimuth');
end

%-----plot error of elevation (per azimuth and elevation) in 3D------------
if plot_error3d_elevation == 1  
    figure
    scatter3(spherical(1,:),spherical(2,:),deviation_elevation,10,'g','filled')
    
    title('Error of Elevation (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Elevation');
end

%figure
%scatter3([0.2 0.2 0 0 1],[0 0 0.1 -0.1 1],[0.1 -0.1 0 0 1])
