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
%---test options---------------
    d_10=1;                     % use coordinates in range [10,100]
    d_100=0;                    % use coordinates in range [100,10^3]
    d_1000=0;                   % use coordinates in range [10^4,10^5]
    d_all=0;                    % use all previous coordinates
    plot_position_cloud = 0;    % plot positions of source
    plot_error_cartesian = 1;   % plot error in cartesian coordinates
    plot_error_spherical = 0;   % plot error in spherical coordinates
%-------------------------------

%init error variales
errorx = zeros();
errory = zeros();
errorz = zeros();
error_azimuth = zeros();
error_elevation = zeros();
error_norm = zeros();

%----- distance 10s ---------------
%generate x values (- to +)
sx = -90:5:90;
sx(sx==0) = []; % prevent positions in the origin

%generate y values (+,-,+,-)
sy = [10:10:90 -90:10:-10 15:10:95 -95:10:-15];

%generate z values (+,-,+,-,+,-,+,...)
sz1 = [10 -90 20 -80 30 -70 40 -60 50 -50 60 -40 70 -30 80 -20 90 -10];
sz2 = sz1 + 3;

% join x, y and z (with some more random points)
s10 = [sx 0 0 50 -90 90 -45 -67 -77 -57 0 55 -55 -55 55 -55 -40; 
       sy 50 -90 0 0 -60 30 -33 0 0 37 55 -55 55 65 -65 -40; 
       sz1 sz2 80 -25 30 -50 0 0 0 89 93 -97 55 -55 55 -65 45 0];
s10(1:ceil(size(s10)/2)) = s10(1:ceil(size(s10)/2)) + 3.2;
s10(ceil(size(s10)/2+ 1):ceil(size(s10))) = s10(ceil(size(s10)/2+ 1):ceil(size(s10))) - 3.7;

%----- distance 100s ---------------
s100 = s10 * 10;
s100(1 : ceil(size(s100)/2)) = s100(1 : ceil(size(s100)/2)) + 37.5;
s100(ceil(size(s100)/2 + 1):ceil(size(s100))) = s10(ceil(size(s100)/2+ 1):ceil(size(s100))) - 63.8;
%----- distance 10^3 ---------------
s1000 = s100 * 10 + 678;

%----- all distances ---------------
s = [s10 s100 s1000];


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
    if (error_azimuth(i)>350)
        error_azimuth(i) = abs(error_azimuth(i)-360);
    end
end

%plot error in cartesian coordinates: x, y and z
if plot_error_cartesian ==1
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
if plot_error_spherical ==1
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


%maximum deviations
[max_x] = max(errorx);
[max_y] = max(errory);
[max_z] = max(errorz);
[max_azimuth] = max(error_azimuth);
[max_elevation] = max(error_elevation);
[max_norm] = max(error_norm);


