function T = rotZ3D( Ax )

T = zeros(4,4);
T(3,3) = 1;
T(1,1) = cos(Ax);
T(2,2) = cos(Ax);
T(2,1) = sin(Ax);
T(1,2) = -sin(Ax);
T(4,4) = 1;

return
