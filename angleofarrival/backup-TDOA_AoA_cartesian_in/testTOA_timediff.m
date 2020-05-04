function [R,a,azimuth,elevation,r] = testTOA_timediff(s) %[R]
%--------------------------------------------------------------------------
% Function: estimate angle of arrival of the acoustic wave and position of
% the source in space
% Input - s:    cartesian coordinates of position of source
% Outputs  
%   - R:         collumn vector of estimated cartesian coordinates
%   - a:         AUV position (cartesian coordinates)
%   - azimuth:   estimated angle of azimuth (degrees) from AUV to source
%   - elevation: estimated angle of elevation (degrees) from AUV to source
%   - r:         estimated norm (meters) from AUV to source
%--------------------------------------------------------------------------
% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 0;

% Sensors' configuration [r1 r2 r3 r4];
% r1 -> front; r2 -> left; r3 -> right; r4 -> top;
ri = [3   0      0      0;
      0     0.2    -0.2   0;
      0     0      0      0.2];

% Target's position     
%s = [-40 -40 0]';

% USBL's position
a = [0 0 0]';

%plot 3D position of source, AUV and hydrophones
plot = 0;
if plot==1
    plot3D(s,a,ri)
end


% matrix of combinations of hydrophones (collumns - 12 13 14...)
hydro_comb = [1 1 1 2 2 3; 
              2 3 4 3 4 4];

% Times of arrival for TDOA calculation
ti = zeros(4,1);
for i=1:4
    ti(i) = t0 + norm( s - (a - ri(:,i) ) ) / cs; % + rand()/100/cs
end
tdoa = [ti(1)-ti(2);
        ti(1)-ti(3);
        ti(1)-ti(4);
        ti(2)-ti(3);
        ti(2)-ti(4);
        ti(3)-ti(4)];

% extract closer hydrophone
[ref_H, equidist_H] = closer_hydro(tdoa);

%define reference hydrophone
Tref = t0 + norm( s - (a - ri(:,ref_H) ) ) / cs; % + rand()/100/cs
%Tref = 10^6/cs; % + rand()/100/cs

%define time diff to add to each hydrophone in relation to Tref of 
%reference hydrophone ref_H
tdoa_abs = abs(tdoa);
T=[Tref Tref Tref Tref];
for k=1:6
    %hydrophone pairs [1 ref_H] [ref_H 1]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 1)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 1)
            T(1) = T(1)+tdoa_abs(k);
        end 
    end
    
    %hydrophone pairs [2 ref_H] [ref_H 2]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 2)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 2)
            T(2) = T(2)+tdoa_abs(k);
        end
    end
    
    %hydrophone pairs [3 ref_H] [ref_H 3]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 3)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 3)
            T(3) = T(3)+tdoa_abs(k);
        end
    end
 
    %hydrophone pairs [4 ref_H] [ref_H 4]
    if (hydro_comb(1,k) == ref_H || hydro_comb(1,k) == 4)
        if (hydro_comb(2,k) == ref_H || hydro_comb(2,k) == 4)
            T(4) = T(4)+tdoa_abs(k);
        end
    end
end


% Solution
A = [ones(4,1), +2*ri'];
Y = [cs^2*(T(1))^2 - ri(:,1)'*ri(:,1);
     cs^2*(T(2))^2 - ri(:,2)'*ri(:,2);
     cs^2*(T(3))^2 - ri(:,3)'*ri(:,3);
     cs^2*(T(4))^2 - ri(:,4)'*ri(:,4)];
      
X =(A'*A)^(-1)*A'*Y;
R = X(2:4)

%convert cartesian coordinates to spherical
[azimuth,elevation,r] = cart2sph(R(1),R(2),R(3));
%convert radians to degrees
azimuth = azimuth*180/pi;
elevation = elevation*180/pi;

end
