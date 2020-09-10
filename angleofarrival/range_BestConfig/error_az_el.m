%distances from transceiver to origin
norm_v = [1, 2, 3, 10, 20, 30, 40, 50, 100, 200, 300, 400, 500, 1000, 10000];

%maximum error in azimuth
%max_err_az = [0.8785, 0.8745, 0.8783, 0.8740, 0.8758, 0.8710, 0.8787, 0.8708, 0.8658, 0.8598];
max_err_az = [0.4730, 0.4771, 0.4820, 0.4796, 0.4893, 0.4875, 0, 0.4940, 0.4881, 0.4853, 0.4879, 0.4864, ...
              0.4886, 0.4846,  0.4810];

%maximum error in elevation
%max_err_el = [0.1124, 0.1023, 0.1008, 0.0990, 0.0952, 0.0951, 0.0951, 0.0951, 0.0955, 0.0956];
max_err_el = [0.1758, 0.1738, 0.1752, 0.1702, 0.1702, 0.1714, 0, 0.1705, 0.1707, 0.1706, 0.1698, 0.1699, ...
              0.1722, 0.1709, 0.1724];

max_err_both = [0.3554, 0.3905, 0.3921, 0.3918 ,0.3905 , 0.3913, 0, 0.3947, 0.3913, 0.3889, 0.3937, 0.3883, ...
                0.3935, 0.3899, 0.3920];              
          
figure

subplot(1,3,1)
plot(norm_v,max_err_az)
title('max error azimuth')
ylabel('error azimuth (degrees)')
xlabel('Norm of transceiver')

subplot(1,3,2)
plot(norm_v,max_err_el)
title('max error elevation')
ylabel('error elevation (degrees)')
xlabel('Norm of transceiver')

subplot(1,3,3)
plot(norm_v,max_err_both)
title('max error elevation')
ylabel('error elevation (degrees)')
xlabel('Norm of transceiver')
