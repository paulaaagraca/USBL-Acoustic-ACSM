function [R,s] = testTOA(p)
% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 12;

% Sensors' configuration [r1 r2 r3 r4];
ri = [1 0 0 0;
      0 1 -1 0;
      0 0 0  1];

% Target's position     
p = [250 250 250]';

% USBL's position
s = [0 0 0]';

% Times of arrival
ti = zeros(4,1);
for i=1:4
  ti(i) = t0 + norm( p - (s - ri(:,i)) ) / cs ; %+ rand()/100/cs
end

% Solution
A = [ones(4,1), 2*ri'];
Y = [cs^2*(ti(1)-t0)^2 - ri(:,1)'*ri(:,1);
      cs^2*(ti(2)-t0)^2 - ri(:,2)'*ri(:,2);
      cs^2*(ti(3)-t0)^2 - ri(:,3)'*ri(:,3);
      cs^2*(ti(4)-t0)^2 - ri(:,4)'*ri(:,4)];
      
X = (A'*A)^(-1)*A'*Y;
R = X(2:4);

end
