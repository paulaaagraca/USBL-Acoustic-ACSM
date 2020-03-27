function [angxy] = cordic_angle( X0, Y0 )
% Calculates the angle only
% 	----------------------------------------------------------------------
% 	Author: jca@fe.up.pt, Nov 2019
% 	----------------------------------------------------------------------
% 	This Matlab code is property of the University of Porto, Portugal
% 	Its utilization beyond the scope of the course Digital Systems Design
% 	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
% 	and Computer Engineering requires explicit authorization from the author.
%---------------------------------------------------------------------
format long

% CORDIC Scale factor
% *** NOT USED HERE, WE ONLY WANT THE ANGLE ***
%Nbitscsf = 20;
%csf = round( 0.607252935008881 * 2^(Nbitscsf-1) );

enableplot = 0;

% Number of bits per sample in lookup-table
Nbits_LUT = 16; % 6 integer bits, 10 fractional bits; Z is quantized with 
                % the same number of bits as the atan lookup table
NbitsX = 7; % 8 fracional bits, 13 integer bits (this may be less, tbi)
NbitsY = 7; % 8 fracional bits, 13 integer bits (this may be less, tbi)

% Number of samples in the lookup-table:
% This should be an integer power of 2
Nsamples_LUT   = 16;

% Uncomment the following like to run this script in Octave:
% pkg load signal

% The following hex files can be read by the Verilog testbench with 
% the Verilog system task $readmemh()

%% define the parameters:
%

% tangents, 2^0 to 2^(Nsamples_LUT-1):
inp2 = 2.^(0:-1:-(Nsamples_LUT-1));

% arctangents in degrees, represented in 8Q(Nbits_LUT-8), unsigned
% 6 bits for the integer part [0, +45], 10 bits for the fracional part
atan_LUTd = round( ( atan( inp2 ) * 180 / pi ) * 2^(Nbits_LUT-6) );


if enableplot == 1
     figure(1);
     plot( atan_LUT, '.-' );
     grid on;
end

%------------------------------
% CORDIC vectoring mode:
X = abs( X0 ); % Initial value for X is the abs(x), correct the angle later.
Y = Y0;
Z = 0;

Xv(1) = X;
Yv(1) = Y;
Zv(1) = Z;

for i=1:Nsamples_LUT
    if ( Y > 0 )
        Xt = X + ( Y / 2^(i-1) );
    else
        Xt = X - ( Y / 2^(i-1) );
    end
    if ( Y > 0 )
        Z = Z + atan_LUTd(i) ;
    else
        Z = Z - atan_LUTd(i) ;
    end
    if ( Y > 0 )
        Y = Y - ( X / 2^(i-1) );
    else
        Y = Y + ( X / 2^(i-1) );
    end
    X = Xt;
    Xv(i+1) = round( X * 2^(NbitsX) ) / (2^NbitsX);
    Yv(i+1) = round( Y * 2^(NbitsY) ) / (2^NbitsY);
    Zv(i+1) = Z;
end

if enableplot == 1
    figure(2);
    plot( Xv, '.-');
    title('X');
    grid on;
end

if enableplot == 1
     figure(3);
     plot( Yv, '.-');
     title('Y');
     grid on;
end

if enableplot == 1
      figure(4);
      plot( Zv,'.-');
      title('Z');
      grid on;
end

%  Modulus correction: NOT USED HERE
% modxy = ( X * csf ) / 2^(Nbitscsf-1) ;

angxy = Z / 2^( Nbits_LUT-6 ) ;

%Correct for [-180, +180] dgr
if ( X0 < 0 )
    if ( Y0 < 0 )
        angxy = -180 - angxy;
    else
        angxy = 180 - angxy;
    end
end
