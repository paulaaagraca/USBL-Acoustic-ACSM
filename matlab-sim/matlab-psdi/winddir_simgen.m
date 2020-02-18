function [Dir,Speed] = winddir_simgen( wangle, wspeed, T, Nmean );
% Usage:  [Direction,Speed] = winddir( trueangle, truespeed, temperature, Nmean )
%
% Description:
% Calculates the wind speed and wind direction. This calls function wind.m
% to calculate the X and Y components of wind speed using the phase
% diferences, then calls function cordic.m to convert the X and Y
% components to the modulus and angle. Finally implements a temperature
% correction for the wind speed using a 2nd order poliminial approximation.
%         Arguments are: 
%            wangle:      true wind angle
%            wspeed:      true wind speed
%            T:           air temperature to compensate the wind speed
%            Nmean:       2^6 to 2^11: length of the averaging filter for
%                         the phase difference. 
%         Return values:
%            Dir:         wind direction in degrees (7 fractional bits)
%            Speed:       wind speed computed in m/s (10 fractional bits)
% 
% 	----------------------------------------------------------------------		
% 	Author: jca@fe.up.pt, Nov/Dec 2019
% 	----------------------------------------------------------------------		
% 	This Matlab code is property of the University of Porto, Portugal
% 	Its utilization beyond the scope of the course Digital Systems Design
% 	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
% 	and Computer Engineering requires explicit authorization from the author.
%---------------------------------------------------------------------
% Set to 1 to enable plotting and printing some intermediate results:
disp = 0;

% File to export various simulation parameters to Veriog
parameters_filename = '../simdata/params.hex';


Xspeed = wspeed * cos( wangle * pi / 180 );
Yspeed = wspeed * sin( wangle * pi / 180 );

fprintf('True Speed X,Y: %10.7f, %10.7f \n',...
                                     Xspeed, Yspeed );

% X and Y components of the wind speed measured by the phase difference:
[SpdX] = wind_simgen( Xspeed, T, 'X', Nmean );
[SpdY] = wind_simgen( Yspeed, T, 'Y', Nmean );



%---------------------------------------------------------------------
% This will be computed by the CORDIC algorithm (module 'windrec2pol')
% inputs are fractional with 10 fractional bits:
for i=1:length( SpdX )
    [Speed(i), Dir(i)] = cordic( SpdX(i), SpdY(i) );
end



%---------------------------------------------------------------------
% Temperature compensation (module 'tempcomp')
% Slope and Y-intersect of the linear approximations 
% for the 2nd order polinomial coefs with wind speed:
Pa = [-0.762939453125000e-5 0];
Pb = [ 0.003837585449219 0.000049591064453];
Pc = [-0.077316284179688 0.009311676025391];

Nbitspcoefs = 10;
% Quantize to 10 fractional bits:
Pa = round( Pa * 2^Nbitspcoefs ) / 2^Nbitspcoefs;
Pb = round( Pb * 2^Nbitspcoefs ) / 2^Nbitspcoefs;
Pc = round( Pc * 2^Nbitspcoefs ) / 2^Nbitspcoefs;

% 10 bit quantized coefficients are:
% Pa(1) =   0.0000000000  Slope
% Pa(2) =   0.0000000000  Y-intersect
% Pb(1) =   0.0039062500
% Pb(2) =   0.0000000000
% Pc(1) =  -0.0771484375
% Pc(2) =   0.0097656250

% Compensate wind speed with temperature with a 2nd order polinomial:
% T is the air temperature in dgr Centigrade
Speed = Speed  + T.^2.*( Pa(1).*Speed + Pa(2) ) ...
               + T   .*( Pb(1).*Speed + Pb(2) ) ...
               +       ( Pc(1).*Speed + Pc(2) );
           
% Round final speed to 10 fractional bits. 
% As the maximum Wspeed is 25 m/s, the integer part fits in 6 bits.
% Output word for wind speed is 16 bit wide:
Speed = round ( Speed .* 2^10 ) ./ 2^10;

Fs = 100000; % Sampling frequency, used here only for X axis scale

if ( disp )
    figure(20);
    ts = linspace(0, (length(Speed)-1)*Nmean*1/Fs, length(Speed) );
    plot( ts(1:end-1)*1e3, Speed(1:end-1),'o-' ); grid on;
    xlabel('Time (ms)');
    ylabel('Speed (m/s)');
    axis( [0 ts(end-1)*1e3 0 mean(Speed(2:end-1))*1.2] );
    title('Final wind speed (m/s)');

    figure(21);
    plot( ts(1:end-1)*1e3, Dir(1:end-1),'o-' ); grid on;
    xlabel('Time (ms)');
    ylabel('Angle (dgr)');
    axis( [0 ts(end-1)*1e3 -185 +185] );
    title('Final wind direction (degrees)');
end


%---------------------------------------------------------------------
% Final calibration modules 'calibwspd' and 'calibwdir' are not included in
% this model.


% Export additional parameters:
 fpout = fopen( parameters_filename, 'w+');
 
 % module winddirection requires this parameter as the log2
 % of the length of the averaging filter (6 to 11)
 fprintf( fpout, '%02x\n', int32( log2(Nmean) ) );
 
 fclose( fpout );
