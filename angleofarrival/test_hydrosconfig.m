%--------------------------------------------------------------------------
% Function: vary position of one hydrophone at a time along one direction 
%           and plot the MSE variation 
%--------------------------------------------------------------------------

clear

max_dev = 0; %0.5us => [-2.5º,2.5º]
source_pos_single = 0; %use single position of source with injected error
accum_samples = 0; %accumulated estimated samples with random error
plot_mse = 0;

deviation = 1;
init_r1 = 0.2;

% slide position of r1
for i = 1:50
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [init_r1 0 0 0;
          0 0.2 -0.2 0;
          0 0 0 0.2];
    
    [mse1(i),deviation_azimuth,deviation_elevation] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r1 = init_r1 + deviation;
    
end

init_r2 = 0.2;

% slide position of r2
for i = 1:50
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2 0 0 0;
          0 init_r2 -0.2 0;
          0 0 0 0.2];
    
    [mse2(i),deviation_azimuth,deviation_elevation] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r2 = init_r2 + deviation;
    
end

init_r3 = 0.2;

% slide position of r3
for i = 1:50
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2 0 0 0;
          0 0.2 init_r3 0;
          0 0 0 0.2];
    
    [mse3(i),deviation_azimuth,deviation_elevation] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r3 = init_r3 - deviation;
    
end

init_r4 = 0.2;

% slide position of r4
for i = 1:50
    
    % hydrophones configuration [r1 r2 r3 r4];
    % r1 -> front; r2 -> left; r3 -> right; r4 -> top;
    ri = [0.2 0 0 0;
          0 0.2 -0.2 0;
          0 0 0 init_r4];
    
    [mse4(i),deviation_azimuth,deviation_elevation] = ...
        hydroconfig_to_mse(ri,max_dev,source_pos_single, accum_samples);
    
    init_r4 = init_r4 + deviation;
    
end

mse = [mse1 mse2 mse3 mse4]
plot(mse)
title('Mean Square Error');
xlabel('Number of test');
ylabel('MSE');
