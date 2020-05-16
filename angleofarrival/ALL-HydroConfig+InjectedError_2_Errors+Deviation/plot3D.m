function [] = plot3D(s,a,ri)
%--------------------------------------------------------------------------
% Description: plots the 3D positions of acoustic source, AUV and all 4
% hydrophones
%--------------------------------------------------------------------------
% Input - s:  cartesian coordinates of source position
%       - a:  cartesian coordinates of AUV position 
%       - ri: cartesian coordinates of hydrophones positions [r1 r2 r3 r4]
%--------------------------------------------------------------------------
% Author : Paula Graça (paula.graca@fe.up.pt), March 2020
%--------------------------------------------------------------------------

    % plot acoustic source location
    scatter3(s(1),s(2),s(3),40,'r','filled')
    hold on
    % plot auv's center of mass location
    scatter3(a(1),a(2),a(3),40,'g','filled')
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