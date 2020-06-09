function [ref_H, equidist_H] = closer_hydro(tdoa)
%--------------------------------------------------------------------------
% Description: extract closer hydrophone to source based on the time
% difference of arrival between all 4 hydrophones
%
% Inputs:
%   - tdoa:___matrix with time difference of arrival (in seconds) 
%
% Outputs: 
%   - ref_H :___index of closer hydrophone to source
%   - equidist_H : 
%       ___if = 0 -> there is no equidistant hydrophones t source; 
%       ___if != 0 -> returns index of equidistant pair to the source
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), March 2020
%--------------------------------------------------------------------------

equidist_H = 0; %initialize equidistant pair as null

% Loop: finds closer hydro of each pair [12 13 14 23 24 34] to the source
% if tmn > 0 it means that hydro m is closer from source than hydro n
% if tmn < 0 it means that hydro m is further from source than hydro n
% else hydrophones are equidistant and equidist_H outputs is updated

% initialize vector that holds closer hydro of each pair
closer_btween2H = zeros(1,6); 

for i=1:6
    if tdoa(i) < 0 %tmn < 0
        if i<4
            closer_btween2H(i) = 1;
        elseif i == 6
            closer_btween2H(i) = 3;
        else %i = 4,5
            closer_btween2H(i) = 2;
        end
    elseif tdoa(i) > 0  %tmn > 0
        if i== 1
            closer_btween2H(i) = 2;
        elseif i == 2 || i == 4 
            closer_btween2H(i) = 3;
        else % i = 3,5,6
            closer_btween2H(i) = 4;
        end
    else    % hydrophones are at the same distance to the source
        closer_btween2H(i) = 0;
        equidist_H = i;
    end
end
 
%Choose most frequent closer hydrophone to the source
[ref_H,F] = mode(closer_btween2H(:));

% If there is more than one 0 in the matrix, take zeros out of the matrix 
% and find the next closer hydrophone
if ref_H == 0
    closer_btween2H(closer_btween2H==ref_H) = NaN ;
    ref_H = mode(closer_btween2H);
end
    
end
