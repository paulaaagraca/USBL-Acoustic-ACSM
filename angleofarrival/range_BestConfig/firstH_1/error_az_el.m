%distances from transceiver to origin
norm_v = [1, 2, 3, 10, 20, 50, 100, 400, 1000, 10000];

%maximum error in azimuth
max_err_az = [0.8785, 0.8745, 0.8783, 0.8740, 0.8758, 0.8710, 0.8787, 0.8708, 0.8658, 0.8598];

%maximum error in elevation
max_err_el = [0.1124, 0.1023, 0.1008, 0.0990, 0.0952, 0.0951, 0.0951, 0.0951, 0.0955, 0.0956];



figure

subplot(1,2,1)
plot(norm_v,max_err_az)
title('max error azimuth')
ylabel('error azimuth (degrees)')
xlabel('Norm of transceiver')

subplot(1,2,2)
plot(norm_v,max_err_el)
title('max error elevation')
ylabel('error elevation (degrees)')
xlabel('Norm of transceiver')
