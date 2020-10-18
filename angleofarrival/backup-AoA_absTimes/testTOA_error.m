%real difference between source and AUV

%init variales
errorx = zeros();
errory = zeros();
errorz = zeros();

n_samples = 100; %number of samples to compute

p=[250 250 250]

%compute error for i different samples
for i=1:n_samples
    [R,s] = testTOA(p);
    real_r = p-s;
    errorx(i) = abs(R(1)-real_r(1));
    errory(i) = abs(R(2)-real_r(2));
    errorz(i) = abs(R(3)-real_r(3));
end
%plot error in x, y and z
figure(1)
subplot(1,3,1)
plot(errorx)
title('Error of x (deg)')
subplot(1,3,2)
plot(errory)
title('Error of y (deg)')
subplot(1,3,3)
plot(errorz)
title('Error of z (deg)')
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.3, 0.7, 0.5]);

%maximum deviations

max_x=max(errorx);
max_y=max(errory);
max_z=max(errorz);

%minimum deviations

min_x=min(errorx);
min_y=min(errory);
min_z=min(errorz);


%std deviations

std_x=std(errorx);
std_y=std(errory);
std_z=std(errorz);


