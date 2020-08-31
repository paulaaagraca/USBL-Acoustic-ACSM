function T = rotX3D( Ax )

T = zeros(4,4);
T(1,1) = 1;
T(2,2) = cos(Ax);
T(3,3) = cos(Ax);
T(2,3) = -sin(Ax);
T(3,2) = sin(Ax);
T(4,4) = 1;

return
