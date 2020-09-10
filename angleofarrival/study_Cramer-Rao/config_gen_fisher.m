%function [best_rad_view_ind,diff_radius_myvsfisher] = config_gen_fisher(s, ind_best_config)
%--------------------------------------------------------------------------
% Description: 
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

plot_on = 0;
plot_uncert_vec = 1;
rotation = 1;
plot_montecarlo_fisher = 1;

%--------------------------------------------------------------------------
%_____TESTING CONFIGURATIONS_______________________________________________

%parameters for sensor configuration
q = 0.1; %distance from origin to nose hydrophone
w = 0.1;
e = sqrt(2)/2 * w;

% Sensors' configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> tcop;
% ri = [2    0       0       0;
%       0      e       -e      0;
%       0      -e      -e      w];

ri = [q   0   0    0    0    0   0    0    0;
      0   0   0    w    -w   e   e    -e   -e;
      0   w   -w   0    0    e   -e   e    -e];

s=[0;1000;0]; %single source position for test

h1 = ri(:,1); %h1 = nose hydrophone gives the 3rd dimension
cnt_comb = 1;
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
                
                hconfig_ind = [1 i_h2 i_h3 i_h4];
                hconfig = [h1 h2 h3 h4]; %configuration composed by this iteration hydrophones

                %all possible combinations that exist
                %can be consulted associating the collumn index to a calculated error
                hydro_comb(:,cnt_comb) = [1 i_h2 i_h3 i_h4]; 
                
                [max_det, min_det, std_det, pos_max_det, pos_min_det,eig_value,eig_vector] = ...
                    fisher(hconfig,s);
                
                eig_value = sqrt(eig_value);
                
                vec_max_det(cnt_comb) = max_det;
                vec_min_det(cnt_comb) = min_det;
                vec_std_det(cnt_comb) = std_det;
                vec_pos_max_det(:,cnt_comb) = pos_max_det;
                vec_pos_min_det(:,cnt_comb) = pos_min_det;
                
                cnt_comb = cnt_comb + 1;
                
                %rotation of hydrophone configuration
                 [rot_az,rot_el,rot_norm] = cart2sph(s(1,1),s(2,1),s(3,1));
                
                %----------------------------------------------------------
                %------choose config for uncertainty plot------------------
                ce = [1 2 7 9];
                if isequal(hconfig_ind, ce)
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
                    uncert_vec1_pos_orgr = eig_vec_rot_pos(:,1) * (eig_value(1,1)/2);
                    uncert_vec2_pos_orgr = eig_vec_rot_pos(:,2) * (eig_value(2,2)/2);
                    uncert_vec3_pos_orgr = eig_vec_rot_pos(:,3) * (eig_value(3,3)/2);
                    
                    uncert_vec1_neg_orgr = - eig_vec_rot_pos(:,1) * (eig_value(1,1)/2);
                    uncert_vec2_neg_orgr = - eig_vec_rot_pos(:,2) * (eig_value(2,2)/2);
                    uncert_vec3_neg_orgr = - eig_vec_rot_pos(:,3) * (eig_value(3,3)/2);
   
                    %center eigen vector in rotated source position
                    uncert_vec1_posr = s_rott + uncert_vec1_pos_orgr;
                    uncert_vec2_posr = s_rott + uncert_vec2_pos_orgr;
                    uncert_vec3_posr = s_rott + uncert_vec3_pos_orgr;
                    
                    uncert_vec1_negr = s_rott + uncert_vec1_neg_orgr;
                    uncert_vec2_negr = s_rott + uncert_vec2_neg_orgr;
                    uncert_vec3_negr = s_rott + uncert_vec3_neg_orgr;
                    
                end
                %----------------------------------------------------------
                    
                end
            end
        end
    end

%define direct vision region for each hydrophone
[h_view] = hydro_direct_view(s, ri, w, q);
    
    
%-----------------------------------------------------------------
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

test_max = 0;

index_view = index_view(2:end);

original_ind_view = zeros(1);
min_radius_view = zeros(1);
if test_max == 1
    max_radius_view = zeros(1); 
end

%-----------------------------------------------------------------
for i = 1:length(index_view)

    ind = index_view(i); %ind contains index of hydro configuration
    
    %accumulate min radius for index of configurations with view    
    min_radius_view = [min_radius_view vec_min_det(ind)];
    original_ind_view(i) = ind;
    if test_max == 1
        max_radius_view = [max_radius_view vec_max_det(ind)];
        original_ind_view_max(i) = ind;
    end
end
min_radius_view = min_radius_view(2:end);  
if test_max == 1
    max_radius_view = max_radius_view(2:end);  
end

%-----------------------------------------------------------------

%best config = minimum radius of sphere
[best_rad,best_rad_ind] = min(vec_min_det);
[best_rad_view,best_rad_view_ind] = min(min_radius_view);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if test_max == 1
    [best_rad_view,best_rad_view_ind] = max(max_radius_view);
end

%map original index of hydrophone config to best config with view
best_rad_view_ind = original_ind_view(best_rad_view_ind);

%-----------------------------------------------------------------
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%COMPARE BEST CONFIG IN FISHER WITH BEST IN MY SCRIPT
%vec_min_det(ind_best_config);
%diff_radius_myvsfisher = abs((best_rad_view - vec_min_det(ind_best_config))/best_rad_view);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if test_max == 1
    diff_radius_myvsfisher = abs((best_rad_view - vec_max_det(ind_best_config))/best_rad_view);
end
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%-----------------------------------------------------------------

%plot minimum radius for each configuration
if plot_on ==1
    figure
    plot(vec_min_det)
    hold on 
    plot(index_view,min_radius_view,'o')
    hold on
    plot(best_rad_ind,best_rad,'Marker','*','Color','g','MarkerSize',9)
    hold on
    plot(best_rad_view_ind,best_rad_view,'Marker','*','Color','b','MarkerSize',9)

    title('Minium volume per config');
    xlabel('Config nº');
    ylabel('Radius of sphere(m)');
end

if plot_uncert_vec == 1
%      %--plot connector vectors from origin to estimated source positions--
    figure
     %plot3([R_estimations(1,i),0],[R_estimations(2,i),0],[R_estimations(3,i),0],'g')
     plot3([uncert_vec1_pos(1,1),uncert_vec1_neg(1,1)],...
           [uncert_vec1_pos(2,1),uncert_vec1_neg(2,1)],...
           [uncert_vec1_pos(3,1),uncert_vec1_neg(3,1)],'g')
     axis equal
     hold on
     
     plot3([uncert_vec2_pos(1,1),uncert_vec2_neg(1,1)],...
           [uncert_vec2_pos(2,1),uncert_vec2_neg(2,1)],...
           [uncert_vec2_pos(3,1),uncert_vec2_neg(3,1)],'r')
     axis equal
     hold on    
        
     plot3([uncert_vec3_pos(1,1),uncert_vec3_neg(1,1)],...
           [uncert_vec3_pos(2,1),uncert_vec3_neg(2,1)],...
           [uncert_vec3_pos(3,1),uncert_vec3_neg(3,1)],'b')
     axis equal
     hold on
     scatter3(s(1,1),s(2,1),s(3,1),40,'r','filled')  
     %hold on  
     %legend('uncert_1','uncert_2','uncert_3');  
     %title('Unertainty vectors around estimated position');
     xlabel('x');
     ylabel('y');
     zlabel('z');
     
     if rotation == 1  
         f_rot_s = figure;
         for asd = 1:3
             %hold on
             subplot(1,3,asd)
             plot3([uncert_vec1_posr(1,1),uncert_vec1_negr(1,1)],...
                   [uncert_vec1_posr(2,1),uncert_vec1_negr(2,1)],...
                   [uncert_vec1_posr(3,1),uncert_vec1_negr(3,1)],'g')
             
             hold on

             plot3([uncert_vec2_posr(1,1),uncert_vec2_negr(1,1)],...
                   [uncert_vec2_posr(2,1),uncert_vec2_negr(2,1)],...
                   [uncert_vec2_posr(3,1),uncert_vec2_negr(3,1)],'r')
            
             hold on    

             plot3([uncert_vec3_posr(1,1),uncert_vec3_negr(1,1)],...
                   [uncert_vec3_posr(2,1),uncert_vec3_negr(2,1)],...
                   [uncert_vec3_posr(3,1),uncert_vec3_negr(3,1)],'b')
             
             hold on
             scatter3(s_rott(1,1),s_rott(2,1),s_rott(3,1),20,'b','filled') 

             %legend('uncert_1','uncert_2','uncert_3');  
             %title('Unertainty vectors around estimated position');
             xlabel('x');
             ylabel('y');
             zlabel('z');

             if asd == 1     
             %zx
             title('Side view');
             axis equal
             view(0,0)
             end

             if asd == 2
             %zy
             title('Front view');             
             axis equal
             view(90,0)
             end

             if asd == 3
             %yx
             title('Upper view');             
             axis equal
             view(0,90)
             end
         end   
         set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.3, 0.7, 0.5]);
         saveas(f_rot_s,'plots/plot-fim-[10,0,10]-C','jpg')
         
     end
end
%%
%--------------------------------------------------------------------------
%--------PRINT OVERLAID MONTE CARLO AND FISHER SIMULATION PLOTS------------
if plot_montecarlo_fisher == 1
    load('../study_Cramer-Rao/plots_show/clouds/estim_[0,1000,0]_1279_10000samp.mat', 'R_estimations_rott');

    figure
    scatter3(R_estimations_rott(1,:),R_estimations_rott(2,:),R_estimations_rott(3,:),5,'r','filled')

    f_est=figure;
         for asd = 1:3
             subplot(1,3,asd)
             if asd == 1   
                 %xz
                 scatter(R_estimations_rott(1,:),R_estimations_rott(3,:),5,'filled')     
                 axis equal
                 xlabel('x');
                 ylabel('z');
                 hold on

                 plot([uncert_vec1_posr(1,1),uncert_vec1_negr(1,1)],...
                      [uncert_vec1_posr(3,1),uncert_vec1_negr(3,1)],'r')
                 axis equal

                 hold on

                 plot([uncert_vec2_posr(1,1),uncert_vec2_negr(1,1)],...
                      [uncert_vec2_posr(3,1),uncert_vec2_negr(3,1)],'k')
                 axis equal

                 hold on
                 plot([uncert_vec3_posr(1,1),uncert_vec3_negr(1,1)],...
                      [uncert_vec3_posr(3,1),uncert_vec3_negr(3,1)],'g')
                 axis equal
                 title("Side View")

             end

             if asd == 2
                 %yz
                 scatter(R_estimations_rott(2,:),R_estimations_rott(3,:),5,'filled')                   
                 xlabel('y');
                 ylabel('z');
                 axis equal
                 hold on

                 plot([uncert_vec1_posr(2,1),uncert_vec1_negr(2,1)],...
                      [uncert_vec1_posr(3,1),uncert_vec1_negr(3,1)],'r')
                 axis equal

                 hold on    

                 plot([uncert_vec2_posr(2,1),uncert_vec2_negr(2,1)],...
                      [uncert_vec2_posr(3,1),uncert_vec2_negr(3,1)],'k')
                 axis equal

                 hold on   
                 plot([uncert_vec3_posr(2,1),uncert_vec3_negr(2,1)],...
                      [uncert_vec3_posr(3,1),uncert_vec3_negr(3,1)],'g')
                 axis equal
                 title("Front View")

             end

             if asd == 3
                 %xy
                 scatter(R_estimations_rott(1,:),R_estimations_rott(2,:),5,'filled') 
                 xlabel('x');
                 ylabel('y');
                 axis equal
                 hold on

                 plot([uncert_vec1_posr(1,1),uncert_vec1_negr(1,1)],...
                      [uncert_vec1_posr(2,1),uncert_vec1_negr(2,1)],'r')
                 axis equal

                 hold on

                 plot([uncert_vec2_posr(1,1),uncert_vec2_negr(1,1)],...
                      [uncert_vec2_posr(2,1),uncert_vec2_negr(2,1)],'k')
                 axis equal

                 hold on

                 plot([uncert_vec3_posr(1,1),uncert_vec3_negr(1,1)],...
                      [uncert_vec3_posr(2,1),uncert_vec3_negr(2,1)],'g')
                 axis equal
                 
                 title("Upper View")
             end

             %hold on

            % scatter3(s_rott(1,1),s_rott(2,1),s_rott(3,1),40,'b','filled')

             axis equal

             %legend('uncert_1','uncert_2','uncert_3');  
             %title('Unertainty vectors around estimated position');
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.3, 0.7, 0.5]);
        saveas(f_est,'plots/plot-fisher-monte-overlaid-0,1000,0-C','jpg')
     end
end
%end