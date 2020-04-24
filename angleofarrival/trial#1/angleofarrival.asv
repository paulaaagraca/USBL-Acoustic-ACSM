function [azimuth, elevation] = angleofarrival(h1, h2, h3, h4, timediff)

% Function: estimates the angle of arrival by using the time difference 
% between hydrophones.
% Inputs
%   h1       - vector; [x, y, z] coordinates of hydrophone 1
%   h2       - vector; [x, y, z] coordinates of hydrophone 2
%   h3       - vector; [x, y, z] coordinates of hydrophone 3
%   h4       - vector; [x, y, z] coordinates of hydrophone 4
%   timediff - vector; [t12, t13, t14, t23, t24, t34] 6 time differences
%   between hydrophones 1, 2, 3 and 4
% Output
%   angleofarrival - double; estimated angle of arrival in degrees

%if no inputs are given
% if nargin<1 
%     h1 = [ 0.5 0.5 0.5];
%     h2 = [ 0.5 0.5 -0.5];
%     h3 = [ 0.5 -0.5 -0.5];
%     h4 = [ 1 0 0];
%     timediff = [0.0004714045,0.0006666666,0.0004082482,0.0004714045,0.0004082482,0.0004082482];
% end

f = 125000000;  % operation frequency - Hz
c_sound = 1500; % avg sound speed - m/s
w_leng = c_sound/f; %wavelength - m

%3D distance between hydrophones
d12 = sqrt((h1(1)-h2(1))^2 + (h1(2)-h2(2))^2 + (h1(3)-h2(3))^2);
d13 = sqrt((h1(1)-h3(1))^2 + (h1(2)-h3(2))^2 + (h1(3)-h3(3))^2);
d14 = sqrt((h1(1)-h4(1))^2 + (h1(2)-h4(2))^2 + (h1(3)-h4(3))^2);

d23 = sqrt((h2(1)-h3(1))^2 + ((h2(2)-h3(2)))^2 + (h2(3)-h3(3))^2);
d24 = sqrt((h2(1)-h4(1))^2 + ((h2(2)-h4(2)))^2 + (h2(3)-h4(3))^2);
d34 = sqrt((h3(1)-h4(1))^2 + ((h3(2)-h4(2)))^2 + (h3(3)-h4(3))^2);

% 2D (plane xy) distance between hydrophones
% d12xy = sqrt((h1(1)-h2(1))^2 + (h1(2)-h2(2))^2);
% d13xy = sqrt((h1(1)-h3(1))^2 + (h1(2)-h3(2))^2);
% d14xy = sqrt((h1(1)-h4(1))^2 + (h1(2)-h4(2))^2);
% 
% d23xy = sqrt((h2(1)-h3(1))^2 + ((h2(2)-h3(2)))^2);
% d24xy = sqrt((h2(1)-h4(1))^2 + ((h2(2)-h4(2)))^2);
% d34xy = sqrt((h3(1)-h4(1))^2 + ((h3(2)-h4(2)))^2);

%conversion of time into distance
distdiff = timediff*c_sound;





% if d12xy ~= 0
%     azimuth_1 = atan(distdiff(1)/d12xy) * 180/pi
% else
%     azimuth_1 = 0;
% end


end