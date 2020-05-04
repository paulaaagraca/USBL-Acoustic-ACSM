function [] = plot3D(s,a,ri)

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