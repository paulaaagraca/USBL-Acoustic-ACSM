function [X,s,azimuth,elevation,rho] = testTOA_pseudorange(p,ri,max_dev)
Xv = [];
rho = [];
%for j=1:10000
% Sound speed
cs = 1500;

% Absolute time of emission
t0 = 0;

%     w=0.1;
%     e = sqrt(2)/2 * w;
    %%__A__  
%     ri = [0.02  0.02   0      0;
%           0     0      0.1    -0.1;
%           0.1   -0.1   0      0];
    %%__B__  
    %         ri = [0.1  0.1   0      0;
    %               0     0      0.1    -0.1;
    %               0.1   -0.1   0      0];
    %%__C__  
%     ri = [0.1  0     0     0;
%           0    0    -e     e;
%           0    0.1  -e    -e]; 

    % Target's position     
    %p = [10 0 0]';

    % USBL's position
    s = [0 0 0]';

    % Times of arrival
    ti = zeros(4,1);
    for i=1:4
      ti(i) = t0 + norm( p - (s - ri(:,i)) ) / cs + randn()*max_dev;
    end
    
    % Solution
    rho = mean(ti-ones(4,1)*t0)*cs;
    S = [ri(:,1)'-ri(:,2)';
         ri(:,1)'-ri(:,3)';
         ri(:,1)'-ri(:,4)'];
    delta = [ti(1)-ti(2);
             ti(1)-ti(3);
             ti(1)-ti(4)];
    
    d = cs*(S'*S)^-1*S'*delta;
    
    d = d/norm(d);
    X = rho*d;
    
   
    %convert cartesian coordinates to spherical
    [azimuth,elevation,r] = cart2sph(X(1),X(2),X(3));
    %convert radians to degrees
    azimuth = azimuth*180/pi;
    elevation = elevation*180/pi;
end    
%end
