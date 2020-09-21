%function [best_rad_view_ind,diff_radius_myvsfisher] = config_gen_fisher(s, ind_best_config)
%--------------------------------------------------------------------------
% Description: 
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

plot_on = 0;
plot_uncert_vec = 0;
rotation = 1;

%--------------------------------------------------------------------------
%_____TESTING CONFIGURATIONS_______________________________________________

%parameters for sensor configuration
q = 0.2; %distance from origin to nose hydrophone
w = 0.1;
e = sqrt(2)/2 * w;

% Sensors' configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> tcop;
% ri = [2    0       0       0;
%       0      e       -e      0;
%       0      -e      -e      w];

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
s=[10;0;0]; %single source position for test

cnt_comb = 1; %initialize counter of all hydrophone combinations
h1 = [q; 0; 0]; %h1 = nose hydrophone gives the 3rd dimension
%Loop: observe variations of best hydro config due to injected error in TDOA
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
                
            [mean_det, mean_eig, mean_trace, std_det, eig_value, eig_vector] = ...
                fisher(hconfig,s);
            
            eig_value = sqrt(eig_value);
            
            vec_min_det(cnt_comb) = mean_det;
            vec_min_eig(cnt_comb) = mean_eig;
            vec_min_trace(cnt_comb) = mean_trace;
            vec_std_det(cnt_comb) = std_det;
%            vec_pos_max_det(:,cnt_comb) = pos_min_det;
%            vec_pos_min_det(:,cnt_comb) = pos_min_eig;

            cnt_comb = cnt_comb + 1;

            %rotation of hydrophone configuration
             [rot_az,rot_el,rot_norm] = cart2sph(s(1,1),s(2,1),s(3,1));

            %----------------------------------------------------------
            %------choose config for uncertainty plot------------------
            if isequal(hconfig_ind,[1 2 7 9])
                uncert_vec1_pos_org = eig_vector(:,1) * (eig_value(1,1)/2);
                uncert_vec2_pos_org = eig_vector(:,2) * (eig_value(2,2)/2);
                uncert_vec3_pos_org = eig_vector(:,3) * (eig_value(3,3)/2);

                uncert_vec1_neg_org = - eig_vector(:,1) * (eig_value(1,1)/2);
                uncert_vec2_neg_org = - eig_vector(:,2) * (eig_value(2,2)/2);
                uncert_vec3_neg_org = - eig_vector(:,3) * (eig_value(3,3)/2);


                uncert_vec1_pos = s + uncert_vec1_pos_org;
                uncert_vec2_pos = s + uncert_vec2_pos_org;
                uncert_vec3_pos = s + uncert_vec3_pos_org;

                uncert_vec1_neg = s + uncert_vec1_neg_org;
                uncert_vec2_neg = s + uncert_vec2_neg_org;
                uncert_vec3_neg = s + uncert_vec3_neg_org;

                %angle between position vector s and uncertainty axis
                ang_uncert_vec1_pos = atan2(norm(cross(uncert_vec1_pos_org,s)),dot(uncert_vec1_pos_org,s));
                ang_uncert_vec1_pos = ang_uncert_vec1_pos * 180/pi;
                ang_uncert_vec1_neg = atan2(norm(cross(uncert_vec1_neg_org,s)),dot(uncert_vec1_neg_org,s));
                ang_uncert_vec1_neg = ang_uncert_vec1_neg * 180/pi;

                ang_uncert_vec2_pos = atan2(norm(cross(uncert_vec2_pos_org,s)),dot(uncert_vec2_pos_org,s));
                ang_uncert_vec2_pos = ang_uncert_vec2_pos * 180/pi;
                ang_uncert_vec2_neg = atan2(norm(cross(uncert_vec2_neg_org,s)),dot(uncert_vec2_neg_org,s));
                ang_uncert_vec2_neg = ang_uncert_vec2_neg * 180/pi;

                ang_uncert_vec3_pos = atan2(norm(cross(uncert_vec3_pos_org,s)),dot(uncert_vec3_pos_org,s));
                ang_uncert_vec3_pos = ang_uncert_vec3_pos * 180/pi;
                ang_uncert_vec3_neg = atan2(norm(cross(uncert_vec3_neg_org,s)),dot(uncert_vec3_neg_org,s));
                ang_uncert_vec3_neg = ang_uncert_vec3_neg * 180/pi;

                fprintf('Uncertainty axis 1 : %.6f - %.6f and %.6f \n', eig_value(1,1),ang_uncert_vec1_pos,ang_uncert_vec1_neg);
                fprintf('Uncertainty axis 2 : %.6f - %.6f and %.6f \n', eig_value(2,2),ang_uncert_vec2_pos,ang_uncert_vec2_neg);
                fprintf('Uncertainty axis 3 : %.6f - %.6f and %.6f \n', eig_value(3,3),ang_uncert_vec3_pos,ang_uncert_vec3_neg);
                    
                    
                    %-----------------------------------------------
                    if rotation == 1
                        uncert_vec_pos_mat = [eig_vector(:,1)' 1;
                                              eig_vector(:,2)' 1; 
                                              eig_vector(:,3)' 1; 
                                              0 0 0 1];

                        %rotation in elevaton - around y axis
                        rot_elevation_y = rotY3D(-(-rot_el)); %z axis is inverted
                        %rotation in azimuth - around z axis
                        rot_azimuth_z = rotZ3D(-rot_az); 
                        %total rotation matrix
                        rot_mat = rot_elevation_y *  rot_azimuth_z ;

                        %rotation transformation
                        uncert_vec_pos_rot = rot_mat * uncert_vec_pos_mat;

                        %get eigen vectors
                        eig_vec_rot_pos = uncert_vec_pos_rot(1:3,1:3)';

                        %rotate source position
                        s_rot_mat = [s' 1; 0 0 0 1; 0 0 0 1; 0 0 0 1];
                        s_rot = rot_mat * s_rot_mat';
                        s_rott = s_rot(1,1:3)';

                        %get uncertainty vectors 
                        uncert_vec1_pos_org = eig_vec_rot_pos(:,1) * (eig_value(1,1)/2);
                        uncert_vec2_pos_org = eig_vec_rot_pos(:,2) * (eig_value(2,2)/2);
                        uncert_vec3_pos_org = eig_vec_rot_pos(:,3) * (eig_value(3,3)/2);

                        uncert_vec1_neg_org = - eig_vec_rot_pos(:,1) * (eig_value(1,1)/2);
                        uncert_vec2_neg_org = - eig_vec_rot_pos(:,2) * (eig_value(2,2)/2);
                        uncert_vec3_neg_org = - eig_vec_rot_pos(:,3) * (eig_value(3,3)/2);

                        %center eigen vector in rotated source position
                        uncert_vec1_posr = s_rott + uncert_vec1_pos_org;
                        uncert_vec2_posr = s_rott + uncert_vec2_pos_org;
                        uncert_vec3_posr = s_rott + uncert_vec3_pos_org;

                        uncert_vec1_negr = s_rott + uncert_vec1_neg_org;
                        uncert_vec2_negr = s_rott + uncert_vec2_neg_org;
                        uncert_vec3_negr = s_rott + uncert_vec3_neg_org;

                    end
                    %----------------------------------------------------------
                    
                end
        end
	end
end

%-----------------------------------------------------------------

%best config = minimum radius of sphere
[best_rad_det,best_rad_det_ind] = min(vec_min_det);
[best_rad_eig,best_rad_eig_ind] = min(vec_min_eig);
[best_rad_trace,best_rad_trace_ind] = min(vec_min_trace);
[best_rad_std,best_rad_std_ind] = min(vec_std_det);


%plot minimum radius for each configuration
if plot_on ==1
    figure
    plot(vec_min_det)
    hold on
    plot(best_rad_det_ind,best_rad_det,'Marker','*','Color','g','MarkerSize',9)
    
    title('Minium volume per config');
    xlabel('Config nº');
    ylabel('Radius of sphere(m)');
    
    figure
    plot(vec_min_eig)
    hold on
    plot(best_rad_eig_ind,best_rad_eig,'Marker','*','Color','g','MarkerSize',9)
    
    title('Minium max eigen axis per config');
    xlabel('Config nº');
    ylabel('Radius of sphere(m)');
    
    figure
    plot(vec_std_det)
    hold on
    plot(best_rad_std_ind,best_rad_std,'Marker','*','Color','g','MarkerSize',9)
    
    title('Standard deviation per config');
    xlabel('Config nº');
    ylabel('Radius of sphere(m)');

end

%end