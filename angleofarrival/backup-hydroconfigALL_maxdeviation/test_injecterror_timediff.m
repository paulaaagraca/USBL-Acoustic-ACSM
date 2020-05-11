%--------------------------------------------------------------------------
% Function: inject error in time difference of arrival and outputs the
% estimated vectors to analyse the deviation
%--------------------------------------------------------------------------
clear

% maximum deviation of injected error in time differences
max_dev = 0.5e-6; %0.5us => [-2.5º,2.5º]

source_pos_single = 1; %use single position of source with injected error
accum_samples = 10; %accumulated estimated samples with random error
plot_mse_deviation = 1;

deviation = 0.1;
init_r1 = 0.2;

% slide position of r1
for i = 1:10
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [init_r1 0 0 0;
          0 0.2 -0.2 0;
          0 0 0 0.2];
    
    [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r1 = init_r1 + deviation;
    
end

%sort out best hydrophone configuration
[min_mse,ind_min_mse] = min(mse);
[min_deviation_azimuth,ind_min_deviation_azimuth] = min(deviation_azimuth);
[min_deviation_elevation,ind_min_eviation_elevation] = min(deviation_elevation);

%best_config = ;

if plot_mse_deviation == 1
    figure(6)
    
    subplot(1,3,1)
    plot(mse)
    title('Mean Square Error');
    xlabel('Number of test');
    ylabel('MSE');
    
    subplot(1,3,2)
    plot(deviation_azimuth)
    title('Deviation: Azimuth');
    xlabel('Number of test');
    ylabel('Deviation Azimuth (deg)');
    
    subplot(1,3,3)
    plot(deviation_elevation)
    title('Deviation: Elevation');
    xlabel('Number of test');
    ylabel('Deviation Elevation (deg)');
end