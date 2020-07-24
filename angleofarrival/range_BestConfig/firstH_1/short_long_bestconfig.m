%function [ind_min_both_dev, ind_min_mse_view, mean_R] = short_long_bestconfig(s) %ind_min_both_dev
%--------------------------------------------------------------------------
% Description: 
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

%----test options----------------------------------------------------------
% for single source position
plot_Hconfig = 0;
plot_mse_deviation = 0;
plot_dev_overlaid = 0;
plot_vec_Restimations = 0;

%-----parameters-----------------------------------------------------------
accum_samples = 10;   %nº accumulated samples w/ random error for same position
max_dev = 0.5e-6;      %max deviation of injected error in time differences
                       %0.5us => [-2.5º,2.5º]
%--------------------------------------------------------------------------

%initialize variables
error_azimuth = zeros();   %azimuth error for all hydrophone configurations
error_elevation = zeros(); %elevation error for all hydrophone configurations
%s = zeros(3,1);           %source positions 
%spherical = zeros(3,1);   %spherical values of source position
gen_mse = 0;           %accumulate MSE of each hydrophone configuration
gen_dev_azimuth = 0;   %accumulate azimuth deviation of each hydrophone configuration
gen_dev_elevation = 0; %accumulate elevation deviation of each hydrophone configuration
accum_R = zeros(3,1);  %accumulate R from each sample

flag_det = 0;
cnt_det_A = 1;
%--------------------------------------------------------------------------
%Definition of hydrophone matrix

q=0.1; %distance from origin to nose hydrophone
w=0.1; %radius of hydrophone circle
e=sqrt(2)/2 * w;  % distance from axis to intermediate hydrophones

% hydrophones configuration [r1 r2 r3 r4 r5 r6 r7 r8 r9];
% r1 -> front; circle: r2:top; r3:bottom; r4:right; r5:left; 
% r6:right-top; r7:righ-bottom; r8:left-top; r9:left-bottom;
ri = [0   0    0    0    0   0    0    0;
      0   0    w    -w   e   e    -e   -e;
      w   -w   0    0    e   -e   e    -e];

%init
ri_shift1= zeros(3,1);
ri_shift2= zeros(3,1);
%ri_shift3= zeros(3,1);
%ri_shift4= zeros(3,1);

deviation_x = 0.2;

for i = 1:length(ri)
    ri_shift1(1,i) = ri(1,i) - deviation_x;
    ri_shift1(2:end,i) = ri(2:end,i);
    ri_shift2(1,i) = ri(1,i) - 2*deviation_x;
    ri_shift2(2:end,i) = ri(2:end,i);
    %ri_shift3(1,i) = ri(1,i) - 3*deviation_x;
    %ri_shift3(2:end,i) = ri(2:end,i);
    %ri_shift4 = ri(1,i) - 4*w;
    %ri_shift4(2:end,i) = ri(2:end,i);
end

%concatenate all possible hydrophone positions
ri_shift_tot = [ri ri_shift1 ri_shift2 ]; %ri_shift3

%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 

% define range of azimuth
t_azimuth_deg = -179:30:180;                 % azimuth values in degrees
t_azimuth_rad = t_azimuth_deg * (pi/180);    % azimuth values in radians

% define range of elevation
t_elevation_deg = -89:30:89;                 % elevation values in degrees
t_elevation_rad = t_elevation_deg *(pi/180); % elevation values in radians

% save sizes of azimuth and elevation matrix 
[rownum,n_samples_azimuth] = size(t_azimuth_rad);  %number of azimuth_positionss
[rownum,n_samples_elevation] = size(t_elevation_rad); %number of elevation_positions

norm_v = [1000]; % norm values to be tested (row)

count = 1;     % size of vector s +1
count_sph = 1; % size of vector spherical +1

[rownum,n_samples_norm] = size(norm_v); %number of norm values to compute

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
            [x, y, z] = sph2cart(t_azimuth_rad(k), t_elevation_rad(i), norm_v(n));
            
            % accumulate cartesian coordinates in matrix's collumns
            s(:,count) = [x,y,z]';
            count = count+1;

            % accumulate spherical coordinates in matrix's collumns
            spherical(:,count_sph) = [t_azimuth_deg(k),t_elevation_deg(i), norm_v(n)]';
            count_sph = count_sph + 1;

        end
    end
end

[rownum,n_samples] = size(s); %number of samples to compute

%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 
cnt_comb = 1; %initialize counter of all hydrophone combinations
h1 = [q; 0; 0]; %h1 = nose hydrophone gives the 3rd dimension
%Loop: observe variations of best hydro config due to injected error in TDOA
for gen_test=1:10

    min_dev_azimuth = 1000;
    min_dev_elevation = 1000;
    min_mse = 1000;

        %Loop: all possible hydrophones for h2
        for i_h2 = 1:length(ri_shift_tot) - 2
        	h2 = ri_shift_tot(:,i_h2);
            
            %Loop: all possible hydrophones for h3
            for i_h3 = (i_h2+1):length(ri_shift_tot)
                if(i_h2 < i_h3)
                    h3 = ri_shift_tot(:,i_h3);
                end
                if i_h3 == i_h2+length(ri) || i_h3 == i_h2+2*length(ri)
                    continue;
                end
                
                %Loop: all possible hydrophones for h4
                for i_h4 = (i_h3+1):length(ri_shift_tot)
                    if(i_h3 < i_h4)
                        h4 = ri_shift_tot(:,i_h4);
                    end
                    if i_h4 == i_h2+length(ri) || i_h4 == i_h2+2*length(ri) || ...
                       i_h4 == i_h3+length(ri) || i_h4 == i_h3+2*length(ri)   
                        continue;
                    end

                    hconfig_ind = [0 i_h2 i_h3 i_h4];
                    hconfig = [h1 h2 h3 h4]; %configuration composed by this iteration hydrophones

                    %all possible combinations that exist
                    %can be consulted associating the collumn index to a calculated error
                    hydro_comb(:,cnt_comb) = [0 i_h2 i_h3 i_h4]; 

                    %compute error for i different samples -> currently 1
                     for i=1:n_samples

                        %calculate real spherical coordinates
                        [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));

                         for k=1:accum_samples
                             %hconfig_ind
                             [R,a,azimuth,elevation,norm,det_A] = testTOA_timediff(s(:,i), hconfig, max_dev);
                             if abs(det_A) == 0 && flag_det == 0
                                det0_config(:,cnt_det_A) = hconfig_ind';
                                cnt_det_A = cnt_det_A + 1;
                                flag_det = 1;
                            end
                            %----------ERROR OF INJECTED RANDOM DEVIATION----------------------
                            %difference between calculated and real azimuth
                            error_i_azimuth(k) = azimuth - real_azimuth*180/pi; % azimuth angle

                            % amend variations around -180 and 180
                            if (error_i_azimuth(k) > 350)
                                error_i_azimuth(k) = abs(error_i_azimuth(k) - 360);
                            end

                            %difference between calculated and real elevation
                            error_i_elevation(k) = elevation - real_elevation*180/pi; %elevation angle

                            % accumulate estimated position to calculate a mean estimation
                            accum_R = accum_R + R;

                        end

                        mean_R = accum_R/accum_samples;

                        %standard deviation of azimuth
                        deviation_azimuth(cnt_comb) = std(error_i_azimuth);
                        %standard deviation of elevation
                        deviation_elevation(cnt_comb) = std(error_i_elevation);

                        %absolute values of error
                        error_i_azimuth = abs(error_i_azimuth);
                        %azimuth error for a single source position
                        error_azimuth(cnt_comb) = mean(error_i_azimuth);

                        %absolute values of error
                        error_i_elevation = abs(error_i_elevation);
                        %elevation error for a single source position
                        error_elevation(cnt_comb) = mean(error_i_elevation);

                        %------------------------------------------------------

                        % Mean squared error (of a certain hydrophone configuration)
                        mse_config(cnt_comb) = sqrt(error_azimuth(cnt_comb)^2 + error_elevation(cnt_comb)^2);
                        if min_mse > mse_config(cnt_comb)
                            min_mse = mse_config(cnt_comb);
                            hconfig_best_mse = hconfig;
                            hconfig_best_mse_index = hydro_comb(:,cnt_comb);
                         end

                        % saves minimum deviation in azimuth and its hydro config
                        if min_dev_azimuth > deviation_azimuth(cnt_comb)
                            min_dev_azimuth = deviation_azimuth(cnt_comb);
                            hconfig_best_az = hconfig;
                            hconfig_best_az_index = hydro_comb(:,cnt_comb);
                        end
                        % saves minimum deviation in elevation and its hydro config
                        if min_dev_elevation > deviation_elevation(cnt_comb)
                            min_dev_elevation = deviation_elevation(cnt_comb);
                            hconfig_best_el = hconfig;
                            hconfig_best_el_index = hydro_comb(:,cnt_comb);
                        end
                        accum_R=0;
                     end
                flag_det = 0;
                cnt_comb=cnt_comb+1;
                end
            end
        end
    
    % -----------------------------------------------------------------
    % definition of hydrophones w/ direct view to the source position
    
    %[h_view] = hydro_direct_view(mean_R, ri, w, q); %mean_R instead of s
    [h_view] = hydro_direct_view_extra(mean_R, ri, w, q); %mean_R instead of s
    

    % -----------------------------------------------------------------
    %define which configurations have direct view to the source position
    [row,col_hcomb] = size(hydro_comb);
    index_view = zeros(1);
    cnt_hydro_with_view = 0;
    [row,col_h_view] = size(h_view);
    sig_comb_view = 0;
    
    for index_comb = 1:col_hcomb
        for row = 2:4
            for cnt_array = 1:col_h_view
                if hydro_comb(row,index_comb) == h_view(cnt_array)
                    cnt_hydro_with_view = cnt_hydro_with_view + 1;
                    if cnt_hydro_with_view == 3
                        index_view = [index_view index_comb];
                    end
                    sig_comb_view = 1;
                    break;
                end
            end
            if sig_comb_view == 0
                break;
            else
                sig_comb_view = 0;
            end
        end
        cnt_hydro_with_view = 0;
    end
    
    index_view = index_view(2:end);
    % -----------------------------------------------------------------
    
    %accumulate MSE error of all configurations
    gen_mse = gen_mse + mse_config;
    
    %accumulate azimuth deviation of all configurations
    gen_dev_azimuth = gen_dev_azimuth + deviation_azimuth;
    
    %accumulate elevation deviation of all configurations
    gen_dev_elevation = gen_dev_elevation + deviation_elevation;
    
    
    %matrix which accumulates best config in terms of MSE for gen_test number of tests
    gen_hconfig_best_mse(:,gen_test) = hconfig_best_mse_index;

    %matrix which accumulates best config in terms of AZIMUTH for gen_test number of tests
    gen_hconfig_best_az(:,gen_test) = hconfig_best_az_index;

    %matrix which accumulates best config in terms of ELEVATION for gen_test number of tests
    gen_hconfig_best_el(:,gen_test) = hconfig_best_el_index;

    cnt_comb = 1;
    
    %************__EXTRACT (MEAN) BEST CONFIGURATION__*************************
    %best MSE
    [sets_config_mse] = extract_mean_best_config(gen_hconfig_best_mse,index_view);
    
    %best azimuth deviation
    [sets_config_d_az] = extract_mean_best_config(gen_hconfig_best_az,index_view);
    
    %best elevation deviation
    [sets_config_d_el] = extract_mean_best_config(gen_hconfig_best_el,index_view);
    
end

% -----------------------------------------------------------------
%mean MSE of each configuration
mean_mse_per_config = gen_mse/col_hcomb; %col_hcomb
%mean azimuth deviation of each configuration
mean_dev_azimuth_per_config = gen_dev_azimuth/col_hcomb;
%mean elevation deviation of each configuration
mean_dev_elevation_per_config = gen_dev_elevation/col_hcomb;

mse_view = zeros(1);
dev_azimuth_view = zeros(1);
dev_elevation_view = zeros(1);

%form matrixes with errors from config with view
for i = 1:length(index_view)
    
    ind = index_view(i); %ind contains index of hydro configuration (out of 56)
    
    %accumulate mse values for index of configurations with view
    mse_view = [mse_view mean_mse_per_config(ind)];
    %accumulate deviation in azimuth values for index of configurations with view
    dev_azimuth_view = [dev_azimuth_view mean_dev_azimuth_per_config(ind)];
    %accumulate deviation in elevation values for index of configurations with view    
    dev_elevation_view = [dev_elevation_view mean_dev_elevation_per_config(ind)];
end

%remove first element of each array
mse_view = mse_view(2:end);
dev_azimuth_view = dev_azimuth_view(2:end);
dev_elevation_view = dev_elevation_view(2:end);

% -----------------------------------------------------------------
%index and value of minimum MSE (configuration)
[min_mse_view,ind_min_mse_view] = min(mse_view);
%index and value of minimum azimuth deviation (configuration)
[dev_az_mse_view,ind_dev_az_mse_view]=min(dev_azimuth_view);
%index and value of minimum elevation deviation (configuration)
[dev_el_mse_view,ind_dev_el_mse_view]=min(dev_elevation_view);

ind_min_mse_view = index_view(ind_min_mse_view);
ind_dev_az_mse_view = index_view(ind_dev_az_mse_view);
ind_dev_el_mse_view = index_view(ind_dev_el_mse_view);
% -----------------------------------------------------------------
% mse of deviations 
for i = 1:length(index_view)
    %mse_both_dev(i) = sqrt(dev_azimuth_view(i)^2+dev_elevation_view(i)^2);
    mse_both_dev(i) = mean([dev_azimuth_view(i) dev_elevation_view(i)]);
end
[min_both_dev,ind_min_both_dev] = min(mse_both_dev);
ind_min_both_dev = index_view(ind_min_both_dev);


%//////////////////_PLOT OPTIONS_//////////////////////////////////////////
%plot MSE and deviation in azimuth and elevation for every configuration
if plot_mse_deviation == 1
    figure(8)
    
    subplot(1,3,1)
    plot(mean_mse_per_config)
    hold on 
    plot(index_view,mse_view,'o')
    hold on
    plot(ind_min_mse_view,min_mse_view,'Marker','*','Color','g','MarkerSize',9)
    title('MSE');
    xlabel('Test Number');
    ylabel('MSE');
    
    subplot(1,3,2)
    plot(mean_dev_azimuth_per_config)
    hold on 
    plot(index_view,dev_azimuth_view,'o')
    hold on
    plot(ind_dev_az_mse_view,dev_az_mse_view,'Marker','*','Color','g','MarkerSize',9)
    title('Azimuth deviation');
    xlabel('Test Number');
    ylabel('Azimuth Deviation (deg)');

    subplot(1,3,3)
    plot(mean_dev_elevation_per_config)
    hold on 
    plot(index_view,dev_elevation_view,'o')
    hold on
    plot(ind_dev_el_mse_view,dev_el_mse_view,'Marker','*','Color','g','MarkerSize',9)
    title('Elevation deviation');
    xlabel('Test Number');
    ylabel('Elevation Deviation (deg)');

end

if plot_dev_overlaid == 1
    figure

    plot(mean_dev_azimuth_per_config,'Color','b','LineWidth',0.5)
    hold on 
    plot(index_view,dev_azimuth_view,'o')
    hold on
    plot(ind_dev_az_mse_view,dev_az_mse_view,'Marker','*','Color','g','MarkerSize',9)
    hold on
    plot(mean_dev_elevation_per_config, 'Color','m','LineWidth',0.5)
    hold on 
    plot(index_view,dev_elevation_view,'o')
    hold on
    plot(ind_dev_el_mse_view,dev_el_mse_view,'Marker','*','Color','g','MarkerSize',9)
    hold on 
    plot(ind_min_both_dev,min_both_dev,'Marker','d','MarkerFaceColor','c','MarkerEdgeColor','c','MarkerSize',7)
    
    legend('Dev Az', 'View Az', 'BestView Az','Dev El', 'View El', 'BestView El');
    title('Deviation in Az and Elev');
    xlabel('Test Number');
    ylabel('Deviation (deg)');

end
    
%plot a specific hydrophone configuration
if plot_Hconfig == 1
	figure
    
    plot_h = hconfig_best_az;
    
    X = ri(1,:); 
	Y = ri(2,:); 
	Z = ri(3,:); 
	% plot hydrophones location
	scatter3(X, Y, Z, 100, 'b', 'o')
	legend('Hydrophones')
    
    hold on 
    
    plot_ha = hconfig_best_az;
    X = plot_ha(1,:); 
	Y = plot_ha(2,:); 
	Z = plot_ha(3,:); 
	% plot hydrophones location
	scatter3(X, Y, Z, 100, 'r', '+')
	%legend('Best Azimuth')
    
    hold on 
   
    plot_he = hconfig_best_el;
    X = plot_he(1,:); 
	Y = plot_he(2,:); 
	Z = plot_he(3,:); 
	% plot hydrophones location
	scatter3(X, Y, Z, 100, 'g', 'x')
	%legend('Best Elevation')
    
    hold on 
    
    X = s(1,:); 
	Y = s(2,:); 
	Z = s(3,:); 
	% plot hydrophones location
	scatter3(X, Y, Z, 200, 'c', 'filled')
	%legend('Hydrophones')
    
end

if plot_vec_Restimations == 1

%      [rownum,n_samples_R_estimations] = size(R_estimations); %number of samples to compute
% 
%      %--plot connector vectors from origin to estimated source positions--
%      figure
% 
%      for i=1:n_samples_R_estimations
%          plot3([R_estimations(1,i),0],[R_estimations(2,i),0],[R_estimations(3,i),0],'g')
%          hold on
%      end
% 
%      plot3([s(1,1),0],[s(2,1),0],[s(3,1),0],'b')   
%      title('Estimated Vectors w/ injected error');
%      xlabel('y');
%      ylabel('x');
%      zlabel('z');
%      
     %--plot estimated source positions------------------------------
     figure

     scatter3(R_estimations(1,:),R_estimations(2,:),R_estimations(3,:),40,'g','filled')
     hold on
     scatter3(s(1,1),s(2,1),s(3,1),40,'b','filled')
     
%      xlim([560 660])
%      ylim([150 250])
%      zlim([-1100 -900])
     
     title('Estimated source position w/ injected error');
     xlabel('x');
     ylabel('y');
     zlabel('z');
end
%end

