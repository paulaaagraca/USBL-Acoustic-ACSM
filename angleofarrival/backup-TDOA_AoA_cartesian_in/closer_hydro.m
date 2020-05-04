function [ref_H, equidist_H] = closer_hydro(tdoa)
% Function: extract closer hydrophone to source
% Inputs: 
%   - ref_H : index of closer hydrophone to source
%   - equidist_H : 
%       if = 0 -> there is no equidistant hydrophones t source; 
%       if != 0 -> returns index of equidistant pair to the source

equidist_H = 0; %init equidistant pair as null

% loop: holds closer hydro of each pair [12 13 14 23 24 34]
closer_btween2H = zeros(1,6); % vector that holds closer hydro of each pair
for i=1:6
    if tdoa(i) < 0  %t12 > 0 means hydrophone 1 is closer from source than 2
        if i<4
            closer_btween2H(i) = 1;
        elseif i == 6
            closer_btween2H(i) = 3;
        else %i = 4,5
            closer_btween2H(i) = 2;
        end
    elseif tdoa(i) > 0  %t12 < 0 means hydrophone 1 is further from source than 2
        if i== 1
            closer_btween2H(i) = 2;
        elseif i == 2 || i == 4 
            closer_btween2H(i) = 3;
        else % i = 3,5,6
            closer_btween2H(i) = 4;
        end
    else    % both hydrophones are at the same distance to the source
        closer_btween2H(i) = 0;
        equidist_H = i;
    end
end
 
%chooses most frequent closer hydrophone to the source
%in case of tie, 
[ref_H,F] = mode(closer_btween2H(:));

%if more than a 0 in matrix, take zeros of matrix and find next closer hydro
if ref_H == 0
    closer_btween2H(closer_btween2H==ref_H) = NaN ;
    ref_H = mode(closer_btween2H);
end
    
end
