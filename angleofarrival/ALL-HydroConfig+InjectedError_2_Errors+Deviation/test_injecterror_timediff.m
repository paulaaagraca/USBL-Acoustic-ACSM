%--------------------------------------------------------------------------
% Description: Uses various hydrophone configurations to obtain error
% metrics according to an injected error in time difference of arrival 
%   - Script injects various values of errors in time difference
%     of arrival to the hydrophones;
%   - For each deviation value, it tests all introduced hydrophone
%     configurations and outputs the Mean Square Error and Standard
%     Deviation in azimuth and elevation.
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), May 2020
%--------------------------------------------------------------------------
clear

%------options-------------------------------------------------------------
source_pos_single = 0;  %plot single position of source with injected error
plot_mse_deviation = 1; %plot deviation and MSE plots
plot_Hconfig = 0;       %plot single hydrophone configuration
%------parameters----------------------------------------------------------
max_dev = 0.5e-6;      %max deviation of injected error in time differences
                       %0.5us => [-2.5º,2.5º]
deviation = 0.1;       %slide deviation between iterations
accum_samples = 10;    %nº accumulated samples w/ random error for same position

init_r1 = 0.2;         %initial position of r1
init_r2 = 0.2;         %initial position of r2
init_r3 = -0.2;        %initial position of r3
init_r4 = 0.2;         %initial position of r4
n_slide_samples = 10;  % number of samples to slide on axis
%--------------------------------------------------------------------------

n_error_test = 1;   %init counter for max_dev cycle

% Loop: runs algorithm for various injected errors 
for max_dev=0.5e-6 %0.1e-6:0.1e-6:0.5e-6
    
    %--Loop: positive slide of r1 in x axis------------------------------
    for i = 1 : n_slide_samples

        % hydrophones configuration [r1 r2 r3 r4];
        % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
        ri = [init_r1  0    0     0;
              0        0.2  -0.2  0;
              0        0    0     0.2];

        %Function: returns mean MSE and mean deviation for ri configuration
        [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
            hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);

        init_r1 = init_r1 + deviation; %increments deviation for next loop
    end

    %--Loop: positive slide of r2 in y axis------------------------------
    for i = (n_slide_samples+1) : 2*n_slide_samples

        % hydrophones configuration [r1 r2 r3 r4];
        % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
        ri = [0.2  0        0     0;
              0    init_r2  -0.2  0;
              0    0        0     0.2];

        %Function: returns mean MSE and mean deviation for ri configuration
        [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
            hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);

        init_r2 = init_r2 + deviation; %increments deviation for next loop
    end

    %--Loop: negative slide of r3 in y axis------------------------------
    for i = (2*n_slide_samples+1) : 3*n_slide_samples

        % hydrophones configuration [r1 r2 r3 r4];
        % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
        ri = [0.2  0    0        0;
              0    0.2  init_r3  0;
              0    0    0        0.2];

        %Function: returns mean MSE and mean deviation for ri configuration
        [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
            hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);

        init_r3 = init_r3 - deviation; %increments deviation for next loop

    end
    
    %--Loop: positive slide of r4 in z axis------------------------------
    for i = (3*n_slide_samples+1) : 4*n_slide_samples

        % hydrophones configuration [r1 r2 r3 r4];
        % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
        ri = [0.2  0    0     0;
              0    0.2  -0.2  0;
              0    0    0     init_r4];

        %Function: returns mean MSE and mean deviation for ri configuration
        [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
            hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);     

        init_r4 = init_r4 + deviation; %increments deviation for next loop

    end
    
    config_cnt = 4*n_slide_samples + 1; %number of hydrophone configurations              
    
    %--4 hydro spiral from nose to the back-----------------------------
    ri = [0.2   0.1    0     -0.1;
          0     0      0.2   0;
          0     0.2    0     -0.2];
    
    %Function: returns mean MSE and mean deviation for ri configuration
    [mse(config_cnt),deviation_azimuth(config_cnt),deviation_elevation(config_cnt)] = ...
            hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);              
    
    %---------------------------------------------------------------------
    %**** ADD HYDRO CONFIGURATIONS HERE ****
    %config_cnt = config_cnt+1;
    %---------------------------------------------------------------------
    
    %plot a specific hydrophone configuration
    if plot_Hconfig == 1
        figure(7)

        %4 hydro spiral from nose to the back
        ri = [0.2   0.1    0      -0.1;
              0.1     0      0.2  -0.1;
              0     0.2    0      -0.2];

        X = ri(1,:); 
        Y = ri(2,:); 
        Z = ri(3,:); 
        % plot hydrophones location
        scatter3(X, Y, Z, 40, 'b', 'filled')
        legend('Hydrophones')
    end
    %---------------------------------------------------------------------

    %minimum mean square error of each hydrophone configuration
    [min_mse(n_error_test),ind_min_mse(n_error_test)] = min(mse);
    
    %minimum azimuth standard deviation of each hydrophone configuration
    [min_deviation_azimuth(n_error_test),ind_min_deviation_azimuth(n_error_test)] = ...
        min(deviation_azimuth);
    
    %minimum elevation standard deviation of each hydrophone configuration
    [min_deviation_elevation(n_error_test),ind_min_eviation_elevation(n_error_test)] = ...
        min(deviation_elevation);

    %----------------------------------------------------------------------
    %plot MSE and deviation in azimuth and elevation for every configuration
    if plot_mse_deviation == 1
        figure(n_error_test)

        subplot(1,3,1)
        plot(mse)
        title('Mean Square Error');
        xlabel('Number of test');
        ylabel('MSE');

        subplot(1,3,2)
        plot(deviation_azimuth)
        title('Azimuth deviation');
        xlabel('Number of test');
        ylabel('Azimuth Deviation (deg)');

        subplot(1,3,3)
        plot(deviation_elevation)
        title('Elevation deviation');
        xlabel('Number of test');
        ylabel('Elevation Deviation (deg)');
        
    end

    n_error_test = n_error_test+1; %increment counter for max_dev
end