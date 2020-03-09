function [Dir,Speed] = winddir( wangle, wspeed, T );
% Usage:  [Direction,Speed] = winddir( trueangle, truespeed, temperature )
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
%         Return values:
%            Dir:         wind direction in degrees (7 fractional bits)
%            Speed:       wind speed computed in m/s (10 fractional bits)
% 
% 	----------------------------------------------------------------------		
% 	Author: jca@fe.up.pt, Nov 2019
% 	----------------------------------------------------------------------		
% 	This Matlab code is property of the University of Porto, Portugal
% 	Its utilization beyond the scope of the course Digital Systems Design
% 	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
% 	and Computer Engineering requires explicit authorization from the author.
%---------------------------------------------------------------------


Xspeed = wspeed * cos( wangle * pi / 180 );
Yspeed = wspeed * sin( wangle * pi / 180 );

% X and Y components of the wind speed measured by the phase difference:
[SpdX] = wind( Xspeed, T );
[SpdY] = wind( Yspeed, T );

fprintf('True Speed X,Y: %10.7f, %10.7f    calc.(uncomp. T) X,Y: %10.7f, %10.7f\n',...
               Xspeed, Yspeed, SpdX, SpdY );

%---------------------------------------------------------------------
% This will be computed by the CORDIC algorithm (module 'windrec2pol')
% inputs are fractional with 10 fractional bits:
[Speed, Dir] = cordic( SpdX, SpdY );


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
Speed = Speed  + T.^2.*( Pa(1)*Speed + Pa(2) ) ...
               + T   .*( Pb(1)*Speed + Pb(2) ) ...
               +       ( Pc(1)*Speed + Pc(2) );
           
% Round final speed to 10 fractional bits. 
% As the maximum Wspeed is 25 m/s, the integer part fits in 6 bits.
% Output word for wind speed is 16 bit wide:
Speed = round ( Speed * 2^10 ) / 2^10;

%---------------------------------------------------------------------
% Final calibration modules 'calibwspd' and 'calibwdir' are not included in
% this model.


