function Y = calibration(X)
% Usage:  [Speed] = wind( Wspeed, temperature, direction, Nmean )
%
% Description:
% This function simulates the behaviour of the calibration module.
% Assume that the input X always belongs to the range of values stored in
% table LUTX
%         Argument is: 
%            X:      the N bit input (N=16)
%         Return value:
%            Y:      the interpolated output, M bits (M=16)
% 	----------------------------------------------------------------------		
% 	Author: jca@fe.up.pt, Dec 2019
% 	----------------------------------------------------------------------		
% 	This Matlab code is property of the University of Porto, Portugal
% 	Its utilization beyond the scope of the course Digital Systems Design
% 	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
% 	and Computer Engineering requires explicit authorization from the author.
%---------------------------------------------------------------------
%
% Number of bits of X input:
N = 16;
% Number of bits of Y output:
M = 16;
% Number of points in lookup table:
NPOINTS = 16;

% Filename with the calibration function:
calibLUT_filename = '../simdata/LUTdatafile.hex';

% An example calibration curve, X values equally spaced:
LUTX = linspace( -2^(N-1), +2^(N-1)-1, NPOINTS );
% this is a segment of a distorted sine curve. 
% Note that in the real system this table will be built from experimental data
LUTY_norm = sin( LUTX/( 2^(N-1)-1 ) * 0.7 * pi/2 ) .* abs( LUTX/( 2^(N-1)-1 ) );
LUTY = round( LUTY_norm / max(abs( LUTY_norm ) ) .* ( 2^(M-1)-1) );
plot( LUTX, LUTY, 'o'); grid on;

% Print the caibration table to a N+M bit hex file readable by Verilog 
% function $readmemh(...):
fpout = fopen( calibLUT_filename, 'w+');
 
for i=1:NPOINTS
    if LUTX(i) < 0
        dataX = int32( 2^N + LUTX(i) );
    else
        dataX = int32( LUTX(i) );
    end
    if LUTY(i) < 0
        dataY = int32( 2^M + LUTY(i) );
    else
        dataY = int32( LUTY(i) );
    end
    fprintf( fpout, '%04X%04X\n', dataX, dataY );
end
fclose( fpout );

% set appropriate axis:
minx = LUTX(1) * 1.1;
maxx = LUTX(end) * 1.1;
miny = LUTY(1) * 1.1;
maxy = LUTY(end) * 1.1;
axis( [minx maxx miny maxy] );
xlabel('X input, N bits');
ylabel('Y output, M bits');

% Given a X value:
% search its location on table LUTX:
% time inneficient algorithm: do a sequential search
% considering the values of X sorted in ascending order:
for i=1:NPOINTS-1
    if ( X <= LUTX(i) )
        break;
    end
end
% i has the index of the upper limit of the interval that contains X
% the points to c alculate the linear interpolation are index i-i and i:
x0 = LUTX(i-1);
x1 = LUTX(i);
y0 = LUTY(i-1);
y1 = LUTY(i);
% Calculate the slope:
m = (y1-y0) / (x1-x0);
% Quantize m to a limited number of fractional bits (10 will be enough)
NBITS_SLOPE = 10;
m = round( m * 2^NBITS_SLOPE ) / 2^NBITS_SLOPE;
% Calculate the value of Y for the given X:
Y = round( y0 + m * ( X-x0 ) );

% Plot a straight line between the two points (x0,y0) and (x1,y1):
figure(1); hold on;
plot( [x0 x1], [y0 y1], 'r', 'linewidth', 2 );

% Plot the point calculated:
plot( X, Y, '*b' );
plot( [X X], [miny Y], '-.');
plot( [ minx X], [Y Y], '-.' );
hold off;
