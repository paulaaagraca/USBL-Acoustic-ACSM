%properties 
f_op = 24400;  % operation frequency (Hz) 
T_op = 1/f_op; % operation period (s) 
fs = 1000000;  % sampling frequency 
t = 0:1/fs:0.001;
% c_water = 1449.2 + 4.6*T − 0.055*T^2 + 0.00029*T^3 + (1.34 − 0.01*T )(S − 35) + 0.016*z

% T = N/fs -> period = #samples/sampling_freq
N = fix(T_op*fs); % integer part

% peaks that indicate beggining of signal
time1 = sin(2*pi*f_op*t);
for i = 1:length(time1)
    if time1(i) < 0
        time1(i) = 0;
    end
    if i > N
        time1(i) = 0;
    end
end

ping1 = sin(2*pi*f_op*t);
%ping2 = sin (2*pi*f_op*t - 100*pi/180);


% set to 1 to add noise to the signal
addnoise = 0;
WNSNR = 40;   % SNR in dB

if ( addnoise )
  ping1 = awgn( ping1, WNSNR );  
  ping2 = awgn( ping2, WNSNR );
end

figure(1)
plot (ping1,'b')
hold on 
plot (time1,'r')