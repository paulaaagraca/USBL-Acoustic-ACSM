
enableplot = 0;

% Number of bits per sample in lookup-table
Nbits_LUT = 32;

% Number of samples in the lookup-table:
% This should be an integer power of 2
Nsamples_LUT   = 32;

% Uncomment the following like to run this script in Octave:
% pkg load signal

% The following hex files can be read by the Verilog testbench with 
% the Verilog system task $readmemh()

% in radians, 0QNbits_LUT format (0 bits for integer part, 32 bits for
% the fractional part)
atanLUTfile    = '../simdata/atanLUT.hex'; 

% in degrees, 
atanLUTfiled    = '../simdata/atanLUTd.hex';

% tangents, 2^0 to 2^(Nsamples_LUT-1):
inp2 = 2.^(0:-1:-(Nsamples_LUT-1));

% arctangents, full precision, unsigned:
atan_LUTf = atan( inp2 );

% arctangents in radians, represented in 1QNbits_LUT, unsigned
atan_LUT = round( atan( inp2 ) * 2^(Nbits_LUT-1) );

% arctangents in degrees, represented in 8Q(Nbits_LUT-8), unsigned
atan_LUTd = ( atan( inp2 ) * 180 / pi ) * 2^(Nbits_LUT-8) ;

%% Write hex file with the LUT data, radians:
fpout = fopen( atanLUTfile, 'w+');
for i=1:Nsamples_LUT
   fprintf( fpout, '%08x\n', int64( atan_LUT(i) ) );
end
fclose( fpout );

%% Write hex file with the LUT data, degrees:
fpout = fopen( atanLUTfiled, 'w+');
for i=1:Nsamples_LUT
   fprintf( fpout, '%08x\n', int64( atan_LUTd(i) ) );
end
fclose( fpout );


if enableplot == 1
     figure(1);
     plot( atan_LUT, '.-' );
     grid on;
end

