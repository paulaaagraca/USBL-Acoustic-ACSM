%--------------------------------------------------------------------------
% Description: 
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), April 2020
%--------------------------------------------------------------------------
clear

%--------------------------------------------------------------------------
%_____TESTING CONFIGURATIONS_______________________________________________

%parameters for sensor configuration
q=0.2; %distance from origin to nose hydrophone
w = 0.2;
e = sqrt(2)/2 * w;

% Sensors' configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> tcop;
% ri = [2    0       0       0;
%       0      e       -e      0;
%       0      -e      -e      w];

ri = [q   0   0    0    0    0   0    0    0;
      0   0   0    w    -w   e   e    -e   -e;
      0   w   -w   0    0    e   -e   e    -e];

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

                hconfig = [h1 h2 h3 h4]; %configuration composed by this iteration hydrophones

                %all possible combinations that exist
                %can be consulted associating the collumn index to a calculated error
                hydro_comb(:,cnt_comb) = [1 i_h2 i_h3 i_h4]; 
                
                [max_det, min_det, std_det, pos_max_det, pos_min_det] = ...
                    fisher(hconfig);
                
                vec_max_det(cnt_comb) = max_det;
                vec_min_det(cnt_comb) = min_det;
                vec_std_det(cnt_comb) = std_det;
                vec_pos_max_det(:,cnt_comb) = pos_max_det;
                vec_pos_min_det(:,cnt_comb) = pos_min_det;
                
                cnt_comb = cnt_comb + 1;
            end
        end
    end
    
    [best_det,best_det_ind] = min(vec_min_det);
    
    hydro_comb_t = hydro_comb';
    
    vec_max_det_t = vec_max_det';
    vec_min_det_t = vec_min_det';
    vec_std_det_t = vec_std_det';
    vec_pos_max_det_t = vec_pos_max_det';
    vec_pos_min_det_t = vec_pos_min_det';
    
    
    plot(vec_min_det)