function [h_view] = hydro_direct_view_extra(R, ri, w, q)
%--------------------------------------------------------------------------
% Description: For each hydrophone in a certain
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), May 2020
%--------------------------------------------------------------------------

    h_view = zeros(1);

    source_x = R(1,1);
    source_y = R(2,1);
    source_z = R(3,1);

    %hydrohphone 1
    if (source_x > 0 && source_z >= 0) || (source_x <= 0 && source_z > ri(3,2))
        h_view = [h_view 1]; %hydro top (yz plan)
    end
    
        if (source_z > ri(3,2))
            h_view = [h_view 9 17]; %hydro top (yz plan)
        end

    %hydrohphone 2
    if (source_x > 0 && source_z <= 0) || (source_x <= 0 && source_z < ri(3,3))
        h_view = [h_view 2]; %hydro bottom (yz plan)
    end 
        if (source_z < ri(3,3))
            h_view = [h_view 10 18]; %hydro bottom (yz plan)
        end 

    %hydrohphone 3
    if (source_x > 0 && source_y >= 0) || (source_x <= 0 && source_y > ri(2,4))
        h_view = [h_view 3]; %hydro in y positive axis (yz plan)
    end 

        if (source_y > ri(2,4))
            h_view = [h_view 11 19]; %hydro in y positive axis (yz plan)
        end 
    
    %hydrohphone 4
    if (source_x > 0 && source_y <= 0) || (source_x <= 0 && source_y < ri(2,5))
        h_view = [h_view 4]; %hydro in y negative axis (yz plan)
    end 

        if (source_y < ri(2,5))
            h_view = [h_view 12 20]; %hydro in y negative axis (yz plan)
        end 
    
    %hydrohphone 5
    if (source_x <= 0 && source_z >= -source_y + w*sqrt(2)) || ...
       (source_x > 0 && source_z >= (sqrt(2)/2)*w * (-(1/q)*source_y + 1)) || ...
       (source_x > 0 && source_y >= (sqrt(2)/2)*w * (-(1/q)*source_x + 1))

        h_view = [h_view 5]; %hydro in 45º (yz plan)
    end 
    
        if (source_z >= -source_y + w*sqrt(2))

            h_view = [h_view 13 21]; %hydro in 45º (yz plan)
        end 

   %hydrohphone 6
    if (source_x <= 0 && source_z <= source_y - w*sqrt(2)) || ...
       (source_x > 0 && source_z <= (sqrt(2)/2)*w * ((1/q)*source_y - 1)) || ...
       (source_x > 0 && source_y >= (sqrt(2)/2)*w * (-(1/q)*source_x + 1))

        h_view = [h_view 6]; %hydro in -45º (yz plan)
    end 
        
        if (source_z <= source_y - w*sqrt(2))

            h_view = [h_view 14 22]; %hydro in -45º (yz plan)
        end 

    %hydrohphone 7
    if (source_x <= 0 && source_z >= source_y + w*sqrt(2)) || ...
       (source_x > 0 && source_z >= (sqrt(2)/2)*w * (-(1/q)*source_y + 1)) || ...
       (source_x > 0 && source_y <= (sqrt(2)/2)*w * ((1/q)*source_x - 1))

        h_view = [h_view 7]; %hydro in 135º (yz plan)
    end 
    
        if (source_z >= source_y + w*sqrt(2))
           
            h_view = [h_view 15 23]; %hydro in 135º (yz plan)
        end 

    %hydrohphone 8
    if (source_x <= 0 && source_z <= -source_y - w*sqrt(2)) || ...
       (source_x > 0 && source_z <= (sqrt(2)/2)*w * ((1/q)*source_y - 1)) || ...
       (source_x > 0 && source_y <= (sqrt(2)/2)*w * ((1/q)*source_x - 1))

        h_view = [h_view 8]; %hydro in -135º (yz plan)
    end 
    
        if (source_z <= -source_y - w*sqrt(2))
         
            h_view = [h_view 16 24]; %hydro in -135º (yz plan)
        end 

    h_view = h_view(2:end);
    
end