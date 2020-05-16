% Sound speed
cs = 1500;  % m/s

% Sensors' configuration [r1 r2 r3 r4];
ri = [20 0 0 0;
      0 1 -12 0;
      0 0 0  3];

% Target's position     
p = [-200 0 -2]';

% USBL's position
s = [0 0 0]';

%plot 3D
plot = 0;
if plot==1
    % plot acoustic source location
    scatter3(p(1),p(2),p(3),40,'r','filled')
    hold on
    % plot auv's center of mass location
    scatter3(s(1),s(2),s(3),40,'g','filled')
    hold on
    % gather x,y and z coordinates of hydrophones
    X = ri(1,:); 
    Y = ri(2,:); 
    Z = ri(3,:); 
    % plot hydrophones location
    scatter3(X,Y,Z,40,'b','filled')
    legend('Source','AUV','Hydrophones')
    hold on
end

% time of arrival
ti = zeros(4,1);
for i=1:4
  ti(i) = norm( p - (s - ri(:,i)) ) / cs; % + rand()/100/cs
end

%time difference of arrival
tdoa = [abs(ti(1)-ti(2)); 
        abs(ti(1)-ti(3));
        abs(ti(1)-ti(4));
        abs(ti(2)-ti(3));
        abs(ti(2)-ti(4));
        abs(ti(3)-ti(4))];
% time to distance conversion
dist_tdoa = tdoa/cs;   % meters
    
% generate vectors between each 2 hydrophones
dist_H = zeros(3,1);
for i= 1:3
    for j=2:4
        if(i~=j && i<j)
            dist_H = [dist_H, ri(:,i)-ri(:,j)];
        end
    end
end
% (collumn) vectors between hydrophones [d12 d13 d14 d23 d24 d34]
dist_H = dist_H(:,2:7);

%distance of vectors between hydrophones
d12 = sqrt((dist_H(1,1))^2+dist_H(2,1)^2+dist_H(3,1)^2);
d13 = sqrt((dist_H(1,2))^2+dist_H(2,2)^2+dist_H(3,2)^2);
d14 = sqrt((dist_H(1,3))^2+dist_H(2,3)^2+dist_H(3,3)^2); 
d23 = sqrt((dist_H(1,4))^2+dist_H(2,4)^2+dist_H(3,4)^2);
d24 = sqrt((dist_H(1,5))^2+dist_H(2,5)^2+dist_H(3,5)^2);
d34 = sqrt((dist_H(1,6))^2+dist_H(2,6)^2+dist_H(3,6)^2);

% 3rd side of triangle (with 90º angle)
pm12 = sqrt(d12^2 - dist_tdoa(1)^2);
pm13 = sqrt(d13^2 - dist_tdoa(2)^2);
pm14 = sqrt(d14^2 - dist_tdoa(3)^2);
pm23 = sqrt(d23^2 - dist_tdoa(4)^2);
pm24 = sqrt(d24^2 - dist_tdoa(5)^2);
pm34 = sqrt(d34^2 - dist_tdoa(6)^2);


%vector calculations
%[x12 y12 z12]' + [xs ys zs]' * t12 = [xp yp zp]' * pm12
% s perpendicular to p
% 
% d12 = sqrt(xs^2+ys^2+zs^2)

%NOOOO
%xs = (dist_H(1,2)*(pm12/pm13) - dist_H(1,1))/(d12-d13*(pm12/pm13))




%Solution TOA
% A = [ones(4,1), 2*ri'];
% Y = [cs^2*(ti(1))^2 - ri(:,1)'*ri(:,1);
%       cs^2*(ti(2))^2 - ri(:,2)'*ri(:,2);
%       cs^2*(ti(3))^2 - ri(:,3)'*ri(:,3);
%       cs^2*(ti(4))^2 - ri(:,4)'*ri(:,4)];
%       
% X = (A'*A)^(-1)*A'*Y;
% R = X(2:4);
