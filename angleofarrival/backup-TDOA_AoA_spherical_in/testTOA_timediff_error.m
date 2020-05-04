%--------------------------------------------------------------------------
% Function: Run tests for testTOA_timediff script with different positions 
%           for acoustic source. 
% Output  : - Plots the variation of error with the different positions, 
%             from a range of cordinates between 10 and 1000 (maximum of 
%             ~1600m from origin)
%           - Plots the point cloud that represents the source's positions
%           - saves 3 variables with max x, y and z errors
%--------------------------------------------------------------------------
clear
%---test options-------------------------------------------------------
    d_10=0;                     % use coordinates in range [10,100]
    d_100=0;                    % use coordinates in range [100,10^3]
    d_1000=0;                   % use coordinates in range [10^4,10^5]
    d_all=1;                    % use all previous coordinates
    
    plot_position_cloud = 0;    % plot positions of source
    plot_error_cartesian = 0;   % plot error in cartesian coordinates
    plot_error_spherical = 1;   % plot error in spherical coordinates
    plot_error3d_azimuth = 1;   % plot error of azimuth per azimuth and elevation
    plot_error3d_elevation = 1;  % plot error of azimuth per azimuth and elevation
    
    exclude_xy_lessthan1 = 0;   % exclude values of x and y smaller than 1 (avoid azimuth errors [10,180]º) 
%-----------------------------------------------------------------------

%init error variales
errorx = zeros();
errory = zeros();
errorz = zeros();
error_azimuth = zeros();
error_elevation = zeros();
error_norm = zeros();
s10 = zeros(3,1);
s100 = zeros(3,1);

% define range of azimuth
t_azimuth_deg = -180:10:180;
t_azimuth_rad = t_azimuth_deg * (pi/180);

% define range of elevation
t_elevation_deg = -89:10:89;
t_elevation_rad = t_elevation_deg *(pi/180);

% save sizes of azimuth and elevation matrix 
[rownum,n_samples_azimuth] = size(t_azimuth_rad); %number of samples to compute
[rownum,n_samples_elevation] = size(t_elevation_rad); %number of samples to compute


%----- distance 10s ------------------------------------------------------
%norm10 = 10:10:100;
norm10 = 20;
count10 = 1;
count_sph10 = 1;

for i = 1:n_samples_elevation
    for k = 1:n_samples_azimuth
            
        % convert spherical to cartesian coordinates
        [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm10);
        
        if exclude_xy_lessthan1 == 1
            if(x >= 1 || y >= 1)
                s10(:,count10) = [x,y,z]';
                count10 = count10+1;
                
                % matrix of spherical coordinates (in collumns)
                spherical10(:,count_sph10) = [t_azimuth_deg(k),t_elevation_deg(i), norm10]';
                count_sph10 = count_sph10 + 1;
            end
        else 
            s10(:,count10) = [x,y,z]';
            count10 = count10+1;
            
            % matrix of spherical coordinates (in collumns)
            spherical10(:,count_sph10) = [t_azimuth_deg(k),t_elevation_deg(i), norm10]';
            count_sph10 = count_sph10 + 1;
        end
       
            
    end
end
%----- distance 100s -----------------------------------------------------
%norm100 = 110:10:1000;
norm100 = 100;
count100 = 1;
count_sph100 = 1;

for i=1:n_samples_elevation
    for k=1:n_samples_azimuth
        % matrix of spherical coordinates in collumns
        spherical100(:,count_sph100) = [t_azimuth_deg(k),t_elevation_deg(i), norm100]';
        count_sph100 = count_sph100 + 1;
        
        % convert spherical to cartesian coordinates
        [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm100);
        s100(:,count100) = [x,y,z]';
        count100 = count100+1;
    end
end

%----- distance 10^3 -----------------------------------------------------
%norm1000 = 1010:10:10^4;
norm1000 = 1000;
count1000 = 1;
count_sph1000 = 1;

for i=1:n_samples_elevation
    for k=1:n_samples_azimuth
        % matrix of spherical coordinates in collumns
        spherical1000(:,count_sph1000) = [t_azimuth_deg(k),t_elevation_deg(i), norm1000]';
        count_sph1000 = count_sph1000 + 1;
        
        % convert spherical to cartesian coordinates
        [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm1000);
        s1000(:,count1000) = [x,y,z]';
        count1000 = count1000+1;
    end
end

%----- all distances -----------------------------------------------------
%s = s10;
s = [s10 s100 s1000];
spherical =[spherical10 spherical100 spherical1000];


%distance10s
if(d_10 ==1)
    [rownum,n_samples] = size(s10); %number of samples to compute
end
%distance100s
if(d_100==1)
    [rownum,n_samples] = size(s100); %number of samples to compute
end
%distance1000s
if(d_1000==1)
    [rownum,n_samples] = size(s1000); %number of samples to compute
end
%distance all
if(d_all==1)
    [rownum,n_samples] = size(s); %number of samples to compute
end

%plot source 3D positions
if plot_position_cloud == 1
    figure(1)
    scatter3(s(1,:),s(2,:),s(3,:),40,'g','filled')
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

%compute error for i different samples
for i=1:n_samples
    
    % distance10s
    if(d_10 ==1)
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s10(:,i));
        %calculate real cartesian coordinates
        real_r = s10(:,i)-a;
        %calculate real spherical coordinates
        [real_azimuth,real_elevation,real_norm] = cart2sph(s10(1,i),s10(2,i),s10(3,i));
    end
    
    % distance100s
    if(d_100==1)
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s100(:,i));
        %calculate real cartesian coordinates
        real_r = s100(:,i)-a;
        %calculate real spherical coordinates
        [real_azimuth,real_elevation,real_norm] = cart2sph(s100(1,i),s100(2,i),s100(3,i));
    end
    
    %distance1000s
    if(d_1000==1)
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s1000(:,i));
        %calculate real cartesian coordinates
        real_r = s1000(:,i)-a;
        %calculate real spherical coordinates
        [real_azimuth,real_elevation,real_norm] = cart2sph(s1000(1,i),s1000(2,i),s1000(3,i));
    end
    
    %distance all
    if(d_all==1)
        [R,a,azimuth,elevation,norm] = testTOA_timediff(s(:,i));
        %calculate real cartesian coordinates
        real_r = s(:,i)-a;
        %calculate real spherical coordinates
        [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));
    end
   
    
    %difference between calculated and real values
    errorx(i) = abs(R(1)-real_r(1));       %x coordinate
    errory(i) = abs(R(2)-real_r(2));       %y coordinate
    errorz(i) = abs(R(3)-real_r(3));       %z coordinate
    error_azimuth(i) = abs(azimuth - real_azimuth*180/pi);         % azimuth angle
    error_elevation(i) = abs(elevation - real_elevation*180/pi);   %elevation angle
    error_norm(i) = abs(norm - real_norm);                         %norm
    
    % amend variations around -180 and 180
    if (error_azimuth(i) > 350)
        error_azimuth(i) = abs(error_azimuth(i) - 360);
    end
end

%plot error in cartesian coordinates: x, y and z
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

%plot error in spherical coordinates: azimuth, elevation and norm
if plot_error_spherical == 1 
    figure(3)
    
    subplot(1,3,1)
    plot(error_azimuth)    %error of x
    title('Error of Azimuth (deg)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,2)
    plot(error_elevation)    %error of y
    title('Error of Elevation (deg)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error') 
    
    subplot(1,3,3)
    plot(error_norm)    %error of z
    title('Error of Norm (m)')
    xlabel('Nº samples') 
    ylabel('Magnitude of Error')
    
    %position window in screen
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2, 0.2, 0.7, 0.6]);
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


if plot_error3d_azimuth == 1
    figure(4)
    if(d_10 == 1)
        scatter3(spherical10(1,:),spherical10(2,:),error_azimuth,40,'g','filled')
    
    elseif (d_100==1)
        scatter3(spherical100(1,:),spherical100(2,:),error_azimuth,40,'g','filled')
    
    elseif (d_1000==1)
        scatter3(spherical1000(1,:),spherical1000(2,:),error_azimuth,40,'g','filled')
    
    elseif (d_all==1)
        scatter3(spherical(1,:),spherical(2,:),error_azimuth,40,'g','filled')
    end
    
    title('Error of Azimuth (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Azimuth');
end

if plot_error3d_elevation == 1  
    figure(5)
    if(d_10 == 1)
        scatter3(spherical10(1,:),spherical10(2,:),error_elevation,40,'g','filled')
    
    elseif (d_100==1)
        scatter3(spherical100(1,:),spherical100(2,:),error_elevation,40,'g','filled')
    
    elseif (d_1000==1)
        scatter3(spherical1000(1,:),spherical1000(2,:),error_elevation,40,'g','filled')
    
    elseif (d_all==1)
        scatter3(spherical(1,:),spherical(2,:),error_elevation,40,'g','filled')
    end
    
    title('Error of Elevation (deg)');
    xlabel('Azimuth (deg)');
    ylabel('Elevation (deg)');
    zlabel('Error Elevation');
end
