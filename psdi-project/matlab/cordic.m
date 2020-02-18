function [M,A] = cordic( X0, Y0 )
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
Nbitscsf = 14;
csf = round( 0.607252935008881 * 2^(Nbitscsf) );

enableplot = 0;

% Number of bits per sample in lookup-table
Nbits_LUT = 16;
NbitsX = 10;
NbitsY = 10;

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
% 8 bits for the integer part [-90, +90], 10 bits for the fracional part
atan_LUTd = round( ( atan( inp2 ) * 180 / pi ) * 2^(Nbits_LUT-6) );


if enableplot == 1
     figure(1);
     plot( atan_LUT, '.-' );
     grid on;
end

%------------------------------
% CORDIC vectoring mode:
X = abs(X0);
Y = Y0;
Z = 0;

% Xv(1) = X;
% Yv(1) = Y;
% Zv(1) = Z;

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
%     Xv(i+1) = round( X * 2^(NbitsX) ) / (2^NbitsX);
%     Yv(i+1) = round( Y * 2^(NbitsY) ) / (2^NbitsY);
%     Zv(i+1) = Z;
end


% if enableplot == 1
%     figure(2);
%     plot( Xv, '.-');
%     title('X');
%     grid on;
% end
% 
% if enableplot == 1
%      figure(3);
%      plot( Yv, '.-');
%      title('Y');
%      grid on;
% end
% 
% if enableplot == 1
%       figure(4);
%       plot( Zv,'.-');
%       title('Z');
%       grid on;
% end

% Modulus and angle:
M = ( X * csf ) / 2^(Nbitscsf) ;
M = round( M * 2^NbitsX ) / 2^NbitsX;

A = Z / 2^( Nbits_LUT-6 ) ;

% Angle output is 16 bits, 9 integer and 7 fractional
% Quantize to 7 fractional bits:
A = round( A * 2^7 ) / 2^7;

% Correct for [-180, +180] dgr
if ( X0 < 0 )
    if ( Y0 < 0 )
        A = -180 - A;
    else
        A = 180 - A;
    end
end

