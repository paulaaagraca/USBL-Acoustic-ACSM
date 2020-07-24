function [R,a,azimuth,elevation,r] = testTOA_timediff(s, ri, max_dev) %[R]
%--------------------------------------------------------------------------
% Description: estimate angle of arrival of the acoustic wave and position of
% the source in space
%--------------------------------------------------------------------------
% Input - s :    cartesian coordinates of position of source
%       - ri:    hydrophones positions [r1 r2 r3 r4]
%       - max_dev : injected max deviation of calculated time differences
%
% Outputs  
%   - R:         collumn vector of estimated cartesian coordinates
%   - a:         AUV position (cartesian coordinates)
%   - azimuth:   estimated angle of azimuth (degrees) from AUV to source
%   - elevation: estimated angle of elevation (degrees) from AUV to source
%   - r:         estimated norm (meters) from AUV to source
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), March 2020
%--------------------------------------------------------------------------

% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 0;

% Sensors' configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> top;
%ri = [0.2   0      0      0;
%      0     0.2    -0.2   0;
%      0     0      0      2];

% Target's position     
%s = [-40 -40 0]';

% AUV's position in relation to axis origin
a = [0 0 0]';

%--------------------------------------------------------------------------
%plot 3D position of source, AUV and hydrophones
plot = 0;
if plot==1
    plot3D(s,a,ri)
end
%--------------------------------------------------------------------------

% matrix of combinations of hydrophones 
% collumns are [hydro1;hydro2], [hydro1;hydro3], [hydro1;hydro4], ...)
hydro_comb = [1 1 1 2 2 3;
              2 3 4 3 4 4];

% Compute times of arrival for TDOA calculation
% (uses source position information)
ti = zeros(4,1);
for i=1:4
    % times of arrival from the source to the 4 hydrophones
    ti(i) = t0 + norm( s - (a - ri(:,i) ) ) / cs;
end

%matrix of TDOA between all hydrophones
tdoa = [ti(1)-ti(2);
        ti(1)-ti(3);
        ti(1)-ti(4);
        ti(2)-ti(3);
        ti(2)-ti(4);
        ti(3)-ti(4)];
    
%lower precision
%tdoa = round(tdoa*10^7)/10^7;
    
%--------------------------------------------------------------------------
% From this point on, it is considered that the source position is unknown

% In order to rely on the TDoA instead of the ToA to each hydrophone, it is
% used a reference hydrophone, which is the closest one to the source
% position according to the tdoa matrix. Therefore, the estimated absolute 
% time of arrival for each hydrophone would be for example:
% T_hydro1 = Tref; 
% T_hydro2 = Tref+tdoa(hydro_ref-hydro2);
% T_hydro3 = Tref+tdoa(hydro_ref-hydro3);
% T_hydro4 = Tref+tdoa(hydro_ref-hydro4);
%--------------------------------------------------------------------------

% extract closer hydrophone given only the TDOA matrix
[ref_H, equidist_H] = closer_hydro(tdoa);


%define time of arrival to the reference hydrophone
Tref = t0 + norm( s - (a - ri(:,ref_H) ) ) / cs ; % + randn()*0.05     + rand()/100/cs

% For big distances between the AUV and the source, it can be used a
% constant Tref value and substitute it for the calculation above
%Tref = 10^6/cs; 


% Define time difference to add to each hydrophone in relation to Tref of  
% the reference hydrophone (ref_H)
tdoa_abs = abs(tdoa);

T=[Tref Tref Tref Tref]; % initialize all base ToA as the Tref 
                         % (to which will then be added the correspondent tdoa)

%--------------------------------------------------------------------------
% Loop: searches for the pairs of hydrophones which include the reference
% hydrophone and all the others, in the hydrophone combinations matrix.
%
% When it finds a combination, it means that the searched non reference
% hydrophone will have a ToA correponding to the Tref added to the tdoa
% between the reference hydrophone and the searched one.
%
% The reference hydrophone will not have its ToA changed
%

for k=1:6   %for each tdoa index
    
    %hydrophone pairs [1 ref_H] [ref_H 1]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 1)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 1)
            % update ToA of hydro 1 
            % injected error (in seconds) between -max_dev/2 and max_dev/2
            T(1) = T(1)+tdoa_abs(k)+randn()*max_dev; %-(max_dev/2)
        end 
    end
    
    %hydrophone pairs [2 ref_H] [ref_H 2]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 2)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 2)
            % update ToA of hydro 2 
            % injected error (in seconds) between -max_dev/2 and max_dev/2
            T(2) = T(2)+tdoa_abs(k)+randn()*max_dev; %-(max_dev/2);
        end
    end
    
    %hydrophone pairs [3 ref_H] [ref_H 3]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 3)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 3)
            % update ToA of hydro 3
            % injected error (in seconds) between -max_dev/2 and max_dev/2
            T(3) = T(3)+tdoa_abs(k)+randn()*max_dev; %-(max_dev/2);
        end
    end
 
    %hydrophone pairs [4 ref_H] [ref_H 4]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 4)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 4)
            % update ToA of hydro 4 
            % injected error (in seconds) between -max_dev/2 and max_dev/2
            T(4) = T(4)+tdoa_abs(k)+randn()*max_dev; %-(max_dev/2);
        end
    end
end

%--------------------------------------------------------------------------
% Solution:
% Uses the hydro positions, ri, and the ToA to each hydrophone, T, to 
% estimate the position of the source, R

A = [ones(4,1), +2*ri'];
Y = [cs^2*(T(1))^2 - ri(:,1)'*ri(:,1);
     cs^2*(T(2))^2 - ri(:,2)'*ri(:,2);
     cs^2*(T(3))^2 - ri(:,3)'*ri(:,3);
     cs^2*(T(4))^2 - ri(:,4)'*ri(:,4)];
      
X =(A'*A)^(-1)*A'*Y;
R = X(2:4);

%convert cartesian coordinates to spherical
[azimuth,elevation,r] = cart2sph(R(1),R(2),R(3));
%convert radians to degrees
azimuth = azimuth*180/pi;
elevation = elevation*180/pi;

%--------------------------------------------------------------------------

% unit vector of estimated position
R_unit = R/r;

end
