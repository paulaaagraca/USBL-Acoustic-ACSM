function [Speed] = wind( Wspeed, T, dir, Nmean );
% Usage:  [Speed] = wind( Wspeed, temperature, direction, Nmean )
%
% Description:
% Calculates the wind speed based on the phase difference
% of the signals arriving to two oposite receivers and the air
% temperature equal to 20º C. The argument T is the air temperature
% used to simulate the signals arriving to the receivers. The distance
% between the transmitter and the receivers is set to 7 cm. 
% this value cannot be changed as it is embedded in some constants
% throughout the code.
%         Arguments are: 
%            Wspeed:      wind speed component along sensors
%            T:           air temperature to compute the sound speed
%            direction:   'X', 'Y', used only for generation the data files
%            Nmean:       2^6 to 2^11: length of the averaging filter for
%                         the phase difference.
%         Return values:
%            Speed:       wind speed computed for T = 20 degrees
% 	----------------------------------------------------------------------		
% 	Author: jca@fe.up.pt, Nov 2019
% 	----------------------------------------------------------------------		
% 	This Matlab code is property of the University of Porto, Portugal
% 	Its utilization beyond the scope of the course Digital Systems Design
% 	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
% 	and Computer Engineering requires explicit authorization from the author.
%---------------------------------------------------------------------

% Set to 1 to enable plotting and printing some intermediate results:
disp = 0;

% Distance between TX and RX (TX at center)
% *** DO NOT EVER THINK CHANGING THIS ***
D = 0.07;
% ***************************************

% Frequency and period of TX signal, Hz:
Fx = 15000;  % USE THIS FOR THE LAB CLASS on Monday, 14h
Fx = 17000;  % USE THIS FOR THE LAB CLASS on Monday, 16h
Fx = 15000;  % USE THIS FOR THE LAB CLASS on Tuesday, 14h________________________________________
Ttx = 1/Fx;  % period of transmitted signal, seconds

% Sampling frequency:______________________________________________________
Fs = 100000;


% set to 1 to add white noise with WNSNR db SNR to the input signals:
addnoise = 0;
WNSNR = 40;   % SNR in dB

% Set to 1 to add amplitude modulation to the input signals:
addAM = 0;
% Frequency of the amplitude modulating signal (Hz)
FAMuw = 987;
FAMdw = 1531;
% Weight of random variation in frequency
Frand = 1;
% Modulation index:
AMmiuw = 0.3;
AMmidw = 0.2;

% insert bandpass filter centered in 15 KHz
% DO NOT CHANGE THIS TO 1 !!!
addbandpass = 0;


% Hilbert filter order and quantization bits:
Hfo = 8;        % Filter order
grd = Hfo/2 ;   % group delay
NbitsHF = 0;    % Number of bits to quantize the fractional part of the coefs.

% Sound speed for temperature T:
sound_speed = 331.3 + (0.6 * T);  % m/s


% length of phase averaging filter (in samples)
phasemeanlength = round( Fs/Fx * 100 );

% Plot length, # of samples:
Nplot = 40;

% Number of samples to export for simulation:
Nsim  = 8000; % ???

% Time vector (200 ms)
t=0:1/Fs:0.2;

%---------------------------------------------------------------------
% The transmitter placed at mid distance between the two receivers
% transmits a continuous sine wave of frequency Fx.


%---------------------------------------------------------------------
% Compute the true phase difference, assuming TX has phase 0. 
% Assume the phase difference never wraps 1/2 of the period or 180 dgr.
% Calculate the phase in degrees:
phaseuw = mod( D / (sound_speed-Wspeed), Ttx ) / Ttx * 360;       % Upwind
phasedw = mod( D / (sound_speed+Wspeed), Ttx ) / Ttx * 360 - 360; % Downwind

% The signal received will have some attenuation but the phase difference
% between them should not be sensible to that:
attuw = 1; % the signal upwind will be weaker
attdw = 1;

%---------------------------------------------------------------------
% The signals received at the upwind and downwind receivers:
% simulates twop oposite outputs of module 'rxreceiver' (eg. rx1 and rx3)
rxuw = sin(2*pi*Fx*t - phaseuw * pi / 180);
rxdw = sin(2*pi*Fx*t - phasedw * pi / 180);

if (addAM )
  AMrxuw = ( 1+AMmiuw.*sin(2*pi*FAMuw*(1+Frand*rand)*t) )./(1+AMmiuw);
  AMrxdw = ( 1+AMmidw.*sin(2*pi*FAMdw*(1+Frand*rand)*t) )./(1+AMmidw);
  figure(5);
  plot( t(1:2*Nplot)*1e6, AMrxuw(1:2*Nplot), '.-' );
  hold on; grid on;
  plot( t(1:2*Nplot)*1e6, AMrxdw(1:2*Nplot), '.-' );
  title('AM modulating signals');
  xlabel('Time (us)');
  ylabel('Amplitude (normalized)');
  axis( [ t(1) t(2*Nplot) 0 2 ] );
  hold off;
  rxuw = AMrxuw .* rxuw;
  rxdw = AMrxdw .* rxdw;
end
  
if ( addnoise )
  rxuw = awgn( rxuw, WNSNR );  
  rxdw = awgn( rxdw, WNSNR );
end

% bandpass equiriple FIR filter, attn=50 dB, passband = ( 14k - 16k ), 
%                                              stopband = <10k, >20k
bandpassfilter = [0.000593913330027015;0.00463569731807602;0.00372817560620149;...
                   -0.00334702253291534;-0.0121884664985990;-0.0141010627118141;...
                   2.45693064887014e-05;0.0215032085058843;0.0312961858993777;...
                   0.0118269634384160;-0.0269447158827081;-0.0530643360779714;...
                   -0.0351186121402512;0.0203621051283711;0.0697252627316869;...
                   0.0640794120200561;3.48846999774752e-05;-0.0728627202336225;...
                   -0.0890980212696575;-0.0300355482771026;0.0578244733389885;...
                   0.0987334726685743;0.0578244733389885;-0.0300355482771026;...
                   -0.0890980212696575;-0.0728627202336225;3.48846999774752e-05;...
                   0.0640794120200561;0.0697252627316869;0.0203621051283711;...
                   -0.0351186121402512;-0.0530643360779714;-0.0269447158827081;...
                   0.0118269634384160;0.0312961858993777;0.0215032085058843;...
                   2.45693064887014e-05;-0.0141010627118141;-0.0121884664985990;...
                   -0.00334702253291534;0.00372817560620149;0.00463569731807602;...
                   0.000593913330027015];

% Insert bandpass filter:               
if ( addbandpass )
    rxuw = conv ( rxuw, bandpassfilter );
    rxdw = conv ( rxdw, bandpassfilter );
end

% Normalize:
rxuw = rxuw ./ max( abs( rxuw ) );
rxdw = rxdw ./ max( abs( rxdw ) );

% Atenuate:
rxuw = attuw .* rxuw;
rxdw = attdw .* rxdw;

if ( disp )
    figure(1);
    plot( t(1:5*Nplot)*1e6, rxuw(1:5*Nplot), '.-');
    hold on;
    plot( t(1:5*Nplot)*1e6, rxdw(1:5*Nplot), '.-');
    grid on;
    hold off;
    xlabel('Time (us)');
    ylabel('Amplitude (normalized to [-1,+1])');
    title('Signals received at upwind and downwind transducers');
end

% Quantize to Nbitsrx:
Nbitsrx = 12; %XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
rxuw = round( rxuw * 2^(Nbitsrx) ) / 2^(Nbitsrx);
rxdw = round( rxdw * 2^(Nbitsrx) ) / 2^(Nbitsrx);

% Define the data file names for simulation:
if ( dir == 'X' ) %% X axis
  rxuw_filename = '../simdata/data_rx2.hex';
  rxdw_filename = '../simdata/data_rx4.hex';
  imaguw_filename = '../simdata/imag_rx2.hex';
  imagdw_filename = '../simdata/imag_rx4.hex';
  realuw_filename = '../simdata/real_rx2.hex';
  realdw_filename = '../simdata/real_rx4.hex';
  phaseuw_filename= '../simdata/phase_rx2.hex';
  phasedw_filename= '../simdata/phase_rx4.hex';
  phasediff_filename = '../simdata/phasediff_X.hex';
  speed_filename = '../simdata/speed_X.hex';
else            %% Y axis
  rxuw_filename = '../simdata/data_rx3.hex'; 
  rxdw_filename = '../simdata/data_rx1.hex'; 
  imaguw_filename = '../simdata/imag_rx3.hex';
  imagdw_filename = '../simdata/imag_rx1.hex';
  realuw_filename = '../simdata/real_rx3.hex';
  realdw_filename = '../simdata/real_rx1.hex';
  phaseuw_filename= '../simdata/phase_rx3.hex';
  phasedw_filename= '../simdata/phase_rx1.hex';
  phasediff_filename= '../simdata/phasediff_Y.hex';
  speed_filename = '../simdata/speed_Y.hex';
end

% Convert the input signals to integers.
%  range is [-2^(N-1)-1, +2^(N-1)-1 ]
rxuwi = round( rxuw .* (2^(Nbitsrx-1)-1) );
rxdwi = round( rxdw .* (2^(Nbitsrx-1)-1) );
%---------------------------------------------------------------------
% Generate data files with input signals:
% Write hex file with the rxuw data:
 fpoutuw = fopen( rxuw_filename, 'w+');
 fpoutdw = fopen( rxdw_filename, 'w+');
 
 for i=1:Nsim
     if rxuwi(i) < 0
         fprintf( fpoutuw, '%03x\n', int16( 2^Nbitsrx + rxuwi(i) ) );
     else
         fprintf( fpoutuw, '%03x\n', int16( rxuwi(i) ) );
     end
     if rxdwi(i) < 0
         fprintf( fpoutdw, '%03x\n', int16( 2^Nbitsrx + rxdwi(i) ) );
     else
         fprintf( fpoutdw, '%03x\n', int16( rxdwi(i) ) );
     end
 end
 
 fclose( fpoutuw );
 fclose( fpoutdw );

%---------------------------------------------------------------------
% Calculate the imaginary component of each received signal using a Hilbert
% FIR filter of order 8, with the coefficients quantized to 8 fraccional bits.
% This simulates the output of the modules 'realtocpx' that output the real and
% imaginary components of the complex representation of the received
% signals.
d = designfilt('hilbertfir','FilterOrder', Hfo, 'TransitionWidth',0.1*Fs,'SampleRate',Fs); 
Htf = round(d.Coefficients * 2^(NbitsHF)) / 2^(NbitsHF);
%figure(1)
%plot(Htf)


if ( disp)
    figure(2);
    freqz( Htf );
end

% Initialize the imaginary parts:
imaguw = zeros(1, length( rxuw ) );
imagdw = zeros(1, length( rxdw ) );

% Add leading zeros to the input signals:
rxuw(1:Hfo) = 0;
rxdw(1:Hfo) = 0;

% Calculate the convolution between the input signals and the Hilbert FIR 
% Note that the odd filter coefficients are zero. 
% They are included in this expression for clarity only.
% Example for a Hilbert filter order equal to 8:
%          xi are the signal samples received i sampling cycles ago (x0 is
%          the most recent sample, x8 is the oldest sample)
%          hj are the filter coefficients
% ... x8  x7  x6  x5  x4  x3  x2  x1  x0
%     h1  h2  h3  h4  h5  h6  h7  h8  h9  
%                                     I0 = x(8:0) .* h(1:9) -> imaginary
%                                     R0 = x(4) -> real part (4 is the
%                                                    filter group delay)
% To implement this digitally:
% 1. Keep the latest 9 samples in registers (a shift-register is a convenient
% memory structure for this);
% 2. Calculate the imaginary part as the addition of the 9 previous samples 
% multiplied by the filter coefficients. Note the odd coefficients are 
% zero and coefficients h2 and h4 are the simmetric of h8 and h6.
% 3. Output the real part as the input signal at 4 sampling periods earlier.
for i=Hfo+1:length( rxuw )
  imaguw(i) = 0;
  for k=0:Hfo
      imaguw(i) = imaguw(i) + rxuw(i-k) * Htf(k+1);
  end
  realuw(i) = rxuw(i-grd); % Delay the real component by the filter group delay
end

for i=Hfo+1:length( rxdw )
  imagdw(i) = 0;
  for k=0:Hfo
      imagdw(i) = imagdw(i) + rxdw(i-k) * Htf(k+1);
  end
  realdw(i) = rxdw(i-grd); % Delay the real component by the filter group delay
end

if ( disp )
    figure(10);
    plot( t(1:5*Nplot)*1e6, realuw(1:5*Nplot), '.-');
    hold on;
    plot( t(1:5*Nplot)*1e6, imaguw(1:5*Nplot), '.-');
    grid on;
    hold off;
    xlabel('Time (us)');
    ylabel('Amplitude (normalized to [-1,+1])');
    title('Real and imaginary signals at upwind transducer');

    figure(11);
    plot( t(1:5*Nplot)*1e6, realdw(1:5*Nplot), '.-');
    hold on;
    plot( t(1:5*Nplot)*1e6, imagdw(1:5*Nplot), '.-');
    grid on;
    hold off;
    xlabel('Time (us)');
    ylabel('Amplitude (normalized to [-1,+1])');
    title('Real and imaginary signals at downwind transducer');
end

% Convert to integer:
imaguwi = round( imaguw .* (2^(Nbitsrx-1)-1) );
imagdwi = round( imagdw .* (2^(Nbitsrx-1)-1) );
realuwi = round( realuw .* (2^(Nbitsrx-1)-1) );
realdwi = round( realdw .* (2^(Nbitsrx-1)-1) );

% Output the imaginary part:
fpoutuw = fopen( imaguw_filename, 'w+');
fpoutdw = fopen( imagdw_filename, 'w+');
 
 for i=1:Nsim
     if imaguwi(i) < 0
         fprintf( fpoutuw, '%04x\n', int16( 2^(Nbitsrx+1) + imaguwi(i) ) );
     else
         fprintf( fpoutuw, '%04x\n', int16( imaguwi(i) ) );
     end
     if imagdwi(i) < 0
         fprintf( fpoutdw, '%04x\n', int16( 2^(Nbitsrx+1) + imagdwi(i) ) );
     else
         fprintf( fpoutdw, '%04x\n', int16( imagdwi(i) ) );
     end
 end
 
 fclose( fpoutuw );
 fclose( fpoutdw );

% Output the real part:
 fpoutuw = fopen( realuw_filename, 'w+');
 fpoutdw = fopen( realdw_filename, 'w+');
 
 for i=1:Nsim
     if realuwi(i) < 0
         fprintf( fpoutuw, '%04x\n', int16( 2^(Nbitsrx+1) + realuwi(i) ) );
     else
         fprintf( fpoutuw, '%04x\n', int16( realuwi(i) ) );
     end
     if realdwi(i) < 0
         fprintf( fpoutdw, '%04x\n', int16( 2^(Nbitsrx+1) + realdwi(i) ) );
     else
         fprintf( fpoutdw, '%04x\n', int16( realdwi(i) ) );
     end
 end
 
 fclose( fpoutuw );
 fclose( fpoutdw );


if ( disp )
    figure(3);
    plot( t(grd+1:500)*1e6, abs ( realuw(grd+1:500) + imaguw(grd+1:500)*j ), '.-' );
    hold on;
    plot( t(grd+1:500)*1e6, abs ( realdw(grd+1:500) + imagdw(grd+1:500)*j ), '.-' );
    hold off; grid on; 
    % figure(4);
    xlabel('Time (us)');
    ylabel('Amplitude of received signals');
    title( 'Module of received signals' );
end


%---------------------------------------------------------------------
% Calculate the phase difference in degrees keeping the 10 fraccional
% bits. The instantaneous phase of each signal is computed by the
% 'phasecalc' module, simulated by function 'cordic_angle'.
for i=1:length( realuw )
  angleuw(i) = cordic_angle( realuw(i) * 2^(Nbitsrx), imaguw(i) * 2^(Nbitsrx) );
  angledw(i) = cordic_angle( realdw(i) * 2^(Nbitsrx), imagdw(i) * 2^(Nbitsrx) );
  
  % Calculate the phase difference:
  %------------------------------------------------------------------------
  % This code simulates module 'phasediff'
  phasediffcpx2(i) = angledw(i) - angleuw(i);
  
  % Convert the phase difference to the range [-180, +180]:
  if ( phasediffcpx2(i) > 180 )
    phasediffcpx2(i) = phasediffcpx2(i) - 360;
  else
    if ( phasediffcpx2(i) < -180 )
        phasediffcpx2(i) = phasediffcpx2(i) + 360;
    end
  end
  %------------------------------------------------------------------------
end

% Convert the angles to integers (the 10 LSbits represent the fractional part)  
aiuw = round( angleuw .* 2^10 );
aidw = round( angledw .* 2^10 );

phasediffi = round( phasediffcpx2 * 2^10 );
  
% Output the phase angles:
 fpoutuw = fopen( phaseuw_filename, 'w+');
 fpoutdw = fopen( phasedw_filename, 'w+');
 
 for i=1:Nsim
     if aiuw(i) < 0
         fprintf( fpoutuw, '%05x\n', int32( 2^19 + aiuw(i) ) );
     else
         fprintf( fpoutuw, '%05x\n', int32( aiuw(i) ) );
     end
     if aidw(i) < 0
         fprintf( fpoutdw, '%05x\n', int32( 2^19 + aidw(i) ) );
     else
         fprintf( fpoutdw, '%05x\n', int32( angledw(i) ) );
     end
 end
 
 fclose( fpoutuw );
 fclose( fpoutdw );
  
% Output the phase difference:
 fpout = fopen( phasediff_filename, 'w+');
 
 for i=1:Nsim
     if phasediffi(i) < 0
         fprintf( fpout, '%05x\n', int32( 2^19 + phasediffi(i) ) );
     else
         fprintf( fpout, '%05x\n', int32( phasediffi(i) ) );
     end
 end
 
 fclose( fpout );
  


if ( disp )
  figure(4);
  plot( t(1:phasemeanlength)*1e6, phasediffcpx2(1:phasemeanlength), '.-' ); 
  hold off;
  grid on;
  ylabel('Phase difference (dgr)');
  xlabel('Time (us)');
  axis( [t(1)*1e6 t(phasemeanlength)*1e6 -180 +180]);
  title('Phase difference (dgr)');
end


%---------------------------------------------------------------------
% Average the phase difference along 8 times the factor Fs/Fx, convert to
% time (us) and convert the time difference to the wind speed using a
% linear approximation that considers the air temperature equal to 20ºC.
%
% for Fs = 100 Khz and Fx = 15 kHz this means averaging the phase
% difference during 53 samples (47 for Fx = 17 kHz and 42 for Fx = 19 kHz)
%
% Note that the delay equal to 2*Hfo is not relevant as it only serves
% in the simulation to get rid of the transient respone of the Hilbert
% filter.
%
% This code simulates the module 'phase2speed'
%%Phase = mean( phasediffcpx2(  2*Hfo  :2*Hfo+phasemeanlength ) );
Phasediff = zeros(1, ceil(Nsim / Nmean) );
i = 1;
k = 1;
while ( i+Nmean-1 < Nsim )
    Phasediff(k) = mean( phasediffcpx2( i : i+Nmean-1 ) );
    k = k + 1;
    i = i + Nmean;
end

% Quantize to 10 fracional bits. Note that 9 integer bits are required to 
% represent phase differences in the range [-180, +180] degrees.
Phasediff = round( Phasediff * 2^10 ) / 2^10;

% Delta time in us between the two sensors:
% this is: 
% delta_t_in_us = phase_in_dgr * (PERIOD / 360) * 1e6
% The factor to convert phase in degrees to useconds scaled by 2^12 is:
% for Fx = 15 kHz (1/15k) / 360 * 1e6 * 2^12 = 759
% for Fx = 17 kHz (1/17k) / 360 * 1e6 * 2^12 = 669
% for Fx = 19 kHz (1/19k) / 360 * 1e6 * 2^12 = 599


% for Fx = 15 kHz:
%% delta_t_us = (Phasediff .* 759) ./ 2^12;


% To calculate the wind speed we need to solve the following 
% equation in order to wind_speed:
%
% delta_t = D / ( sound_speed - wind_speed ) - D / ( sound_speed + wind_speed )
% 
% Solution is:
% wind_speed = [ 2*D - 2*sqrt( D^2 + (delta_t * sound_speed)^2 ) ] / ( -2*delta_t )
%
% Considering a fixed value for the temperature equal to 20 degrees this
% can be approximated by a linear approximation with delta time in us:
% wind_speed = 0.842 * (delta_t_us);

% Number of fractional bits to represent the slope of the linear approximation:
%%% Nbits_slope = 15;
%%% slope = round( 0.842 * 2^Nbits_slope)/2^Nbits_slope;
%%% Speed = slope * delta_t_us;

% We can calculate Speed in m/s directly from Phase in degrees:
% The factor 639.0625 is the result 0.842 * 759
%%% Speed = (Phase * 639.0625) / 2^12 or Speed = Phase * ( 20450 / 2^5 ) / 2^12;
% where the factor 20450 is 639.0625 scaled by 2^5
% The other values are:
% 669 * 0.842 * 2^5 = 18026
% 599 * 0.842 * 2^5 = 16139

% For Fx = 15 kHz:
Speed=Phasediff.*( 20450 ./ 2^5 ) ./ 2^12;


% Maximum speed is 25 m/s (signed), use 6 bits for the integer part and 8
% for the fraccional part:
Speed = round( Speed .* 2^10 ) ./ 2^10;
% Time vector for speed vector:
ts = linspace(0, (length(Speed)-1)*Nmean*1/Fs, length(Speed) );
if ( disp )
    figure(5);
    plot( ts(1:end-1)*1e3, Speed(1:end-1),'o-' ); grid on;
    xlabel('Time (ms)');
    ylabel('Speed (m/s)');
    axis( [0 ts(end-1)*1e3 0 mean(Speed(2:end-1))*1.2] );
    title('Speed (m/s)');
end

% Convert speed to integer:
speedi = round( Speed .* 2^10 );

% Output the final speed:
 fpout = fopen( speed_filename, 'w+');
 
 for i=1:length(speedi)-1 % discard last value (?)
   if speedi < 0
       fprintf( fpout, '%04x\n', int32( 2^16 + speedi ) );
   else
       fprintf( fpout, '%04x\n', int32( speedi ) );
   end
 end
 
 fclose( fpout );

%-------------------------------------------------------------------------

if ( disp )
  fprintf('Mean speed %c = %10.8f\n', dir, mean( Speed(2:end-1) ) );
end


return;
