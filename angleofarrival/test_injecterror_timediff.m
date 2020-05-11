%--------------------------------------------------------------------------
% Function: inject error in time difference of arrival and outputs the
% estimated vectors to analyse the deviation
%--------------------------------------------------------------------------
clear

%------options-------------------------------------------------------------
source_pos_single = 1;  %use single position of source with injected error
plot_mse_deviation = 1; %plot deviation and MSE plots
plot_Hconfig = 1;   %plot single hydrophone configuration

% maximum deviation of injected error in time differences
max_dev = 0.5e-6; %0.5us => [-2.5º,2.5º]

accum_samples = 10; %accumulated estimated samples with random error
init_r1 = 0.2;  %initial position of r1
init_r2 = 0.2;  %initial position of r2
init_r3 = -0.2; %initial position of r3
init_r4 = 0.2;  %initial position of r4

deviation = 0.1; %slide deviation between iterations
n_slide_samples = 10;  % number of samples to slide on axis

%------hydrophones configurations (-> ri) ---------------------------------
% positive slide of r1 in x axis 
for i = 1 : n_slide_samples
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [init_r1  0    0     0;
          0        0.2  -0.2  0;
          0        0    0     0.2];
      
    [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
         
    init_r1 = init_r1 + deviation;
    
end
%positive slide of r2 in y axis 
for i = (n_slide_samples+1) : 2*n_slide_samples
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2  0        0     0;
          0    init_r2  -0.2  0;
          0    0        0     0.2];
    
    [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r2 = init_r2 + deviation;
    
end
%negative slide of r3 in y axis 
for i = (2*n_slide_samples+1) : 3*n_slide_samples
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2  0    0        0;
          0    0.2  init_r3  0;
          0    0    0        0.2];
    [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r3 = init_r3 - deviation;
    
end
for i = (3*n_slide_samples+1) : 4*n_slide_samples
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2  0    0     0;
          0    0.2  -0.2  0;
          0    0    0     init_r4];
    
    [mse(i),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);     
         
    init_r4 = init_r4 + deviation;
    
end
config_cnt = 4*n_slide_samples + 1;

%4 hydro circle in 2 planes
ri = [0.1   -0.1   0.1   -0.1;
      0     0.2    -0.2  0;
      -0.2  0      0     0.2];

[mse(config_cnt),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);              
              
config_cnt = config_cnt+1;

%4 hydro spiral from nose to the back
ri = [0.2   0.1    0     -0.1;
      0     0      0.2   0;
      0     0.2    0     -0.2];

[mse(config_cnt),deviation_azimuth(i),deviation_elevation(i)] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);              
                                         

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

%--------------------------------------------------------------------------


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