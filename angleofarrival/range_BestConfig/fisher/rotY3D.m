function T = rotY3D( Ax )

T = zeros(4,4);
T(2,2) = 1;
T(1,1) = cos(Ax);
T(3,3) = cos(Ax);
T(3,1) = -sin(Ax);
T(1,3) = sin(Ax);
T(4,4) = 1;

return
