function [Speed] = wind( Wspeed, T, dir, Nmean );
% Distance between TX and RX (TX at center)
% *** DO NOT EVER THINK CHANGING THIS ***
D = 0.07;
% ***************************************

Fx = 15000;  
Ttx = 1/Fx;  % period of transmitted signal, seconds

% Sampling frequency:
Fs = 100000;

% Sound speed for temperature T:
sound_speed = 331.3 + (0.6 * T);  % m/s

% length of phase averaging filter (in samples)
phasemeanlength = round( Fs/Fx * 100 );

% Time vector (200 ms)
t=0:1/Fs:0.2;

%---------------------------------------------------------------------
% Compute the true phase difference, assuming TX has phase 0. 
% Assume the phase difference never wraps 1/2 of the period or 180 dgr.
% Calculate the phase in degrees:
phaseuw = mod( D / (sound_speed-Wspeed), Ttx ) / Ttx * 360;       % Upwind
phasedw = mod( D / (sound_speed+Wspeed), Ttx ) / Ttx * 360 - 360; % Downwind

%---------------------------------------------------------------------
% The signals received at the upwind and downwind receivers:
% simulates twop oposite outputs of module 'rxreceiver' (eg. rx1 and rx3)
rxuw = sin(2*pi*Fx*t - phaseuw * pi / 180);
rxdw = sin(2*pi*Fx*t - phasedw * pi / 180);

figure(1)
plot (rxuw)
%hold on
%plot (rxdw)
