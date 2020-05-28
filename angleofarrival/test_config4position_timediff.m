%--------------------------------------------------------------------------
% Description: 
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

%----test options----------------------------------------------------------
% test for single source position
plot_Hconfig = 0;
plot_mse_deviation = 1;

%--------------------------------------------------------------------------

error_azimuth = zeros();
error_elevation = zeros();
%s = zeros(3,1);
spherical = zeros(3,1);
max_dev = 0.5e-6;      %max deviation of injected error in time differences
                       %0.5us => [-2.5º,2.5º]
accum_samples = 500;    %nº accumulated samples w/ random error for same position
gen_mse = 0;
gen_dev_azimuth = 0;
gen_dev_elevation = 0;
accum_R = zeros(3,1);


q=0.2;
w=0.1; 
e=sqrt(2)/2 * w;

% hydrophones configuration [r1 r2 r3 r4 r5 r6 r7 r8 r9];
% r1 -> front; circle: r2:top; r3:bottom; r4: r5: r6: r7: r8: r9:
ri = [q   0   0    0    0    0   0    0    0;
      0   0   0    w    -w   e   e    -e   -e;
      0   w   -w   0    0    e   -e   e    -e];
  
%single position for test
s=[1000;1000;1000];

[rownum,n_samples] = size(s); %number of samples to compute

cnt_comb =1;   

h1 = ri(:,1);  %h1 is always the one which gives the 3rd dimension

%Loop: observe variations of best hydro config due to injected error in TDOA
for gen_test=1:20

    min_dev_azimuth = 1000;
    min_dev_elevation = 1000;
    min_mse = 1000;

    %Loop: all possible hydrophones for h2
    for i_h2 = 2:7
        h2 = ri(:,i_h2);

        %Loop: all possible hydrophones for h3
        for i_h3 = (i_h2+1):9
            if(i_h2 < i_h3)
                h3 = ri(:,i_h3);
            end

            %Loop: all possible hydrophones for h4
            for i_h4 = (i_h3+1):9
                if(i_h3 < i_h4)
                    h4 = ri(:,i_h4);
                end

                hconfig = [h1 h2 h3 h4]; %configuration composed by this iteration hydrophones

                %all possible combinations that exist
                %can be consulted associating the collumn index to a calculated error
                hydro_comb(:,cnt_comb) = [1 i_h2 i_h3 i_h4]; 

                %compute error for i different samples -> currently 1
                for i=1:n_samples

                    %calculate real spherical coordinates
                    [real_azimuth,real_elevation,real_norm] = cart2sph(s(1,i),s(2,i),s(3,i));

                    for k=1:accum_samples

                        [R,a,azimuth,elevation,norm] = testTOA_timediff(s(:,i), hconfig, max_dev);

                        %----------ERROR OF INJECTED RANDOM DEVIATION----------------------
                        %difference between calculated and real azimuth
                        error_i_azimuth(k) = azimuth - real_azimuth*180/pi; % azimuth angle

                        % amend variations around -180 and 180
                        if (error_i_azimuth(k) > 350)
                            error_i_azimuth(k) = abs(error_i_azimuth(k) - 360);
                        end

                        %difference between calculated and real elevation
                        error_i_elevation(k) = elevation - real_elevation*180/pi; %elevation angle
                        %-----------------------------------------------------------------
                        
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

                    cnt_comb=cnt_comb+1;
                    accum_R=0;
                    
                end
            end
        end
    end
    
    % -----------------------------------------------------------------
    % definition of hydrophones w/ direct view to the source position
    [h_view] = hydro_direct_view(R, ri, w, q);

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
    
    %mean MSE error for each configuration
    gen_mse = gen_mse + mse_config;
    
    %mean azimuth deviation for each configuration
    gen_dev_azimuth = gen_dev_azimuth + deviation_azimuth;
    
    %mean elevation deviation for each configuration
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
mean_mse_per_config = gen_mse/col_hcomb;

mean_dev_azimuth_per_config = gen_dev_azimuth/col_hcomb;

mean_dev_elevation_per_config = gen_dev_elevation/col_hcomb;

mse_view = zeros(1);
dev_azimuth_view = zeros(1);
dev_elevation_view = zeros(1);

for i = 1:length(index_view)
    ind = index_view(i);
    mse_view = [mse_view mean_mse_per_config(ind)];
    dev_azimuth_view = [dev_azimuth_view mean_dev_azimuth_per_config(ind)];
    dev_elevation_view = [dev_elevation_view mean_dev_elevation_per_config(ind)];
end

mse_view = mse_view(2:end);
dev_azimuth_view = dev_azimuth_view(2:end);
dev_elevation_view = dev_elevation_view(2:end);

%****************** PLOT OPTIONS ******************************************
%plot MSE and deviation in azimuth and elevation for every configuration
if plot_mse_deviation == 1
    figure(8)
    
    subplot(1,3,1)
    plot(mean_mse_per_config)
    hold on 
    plot(index_view,mse_view,'o')  %'Marker','o','MarkerFaceColor','r'
    title('MSE');
    xlabel('Test Number');
    ylabel('MSE');
    
    subplot(1,3,2)
    plot(mean_dev_azimuth_per_config)
    hold on 
    plot(index_view,dev_azimuth_view,'o')  %'Marker','o','MarkerFaceColor','r'
    title('Azimuth deviation');
    xlabel('Test Number');
    ylabel('Azimuth Deviation (deg)');

    subplot(1,3,3)
    plot(mean_dev_elevation_per_config)
    hold on 
    plot(index_view,dev_elevation_view,'o')  %'Marker','o','MarkerFaceColor','r'
    title('Elevation deviation');
    xlabel('Test Number');
    ylabel('Elevation Deviation (deg)');

end
    
%plot a specific hydrophone configuration
if plot_Hconfig == 1
	figure(7)
    
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

