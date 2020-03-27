%if calculate_phase_diff
    
    Fs = 244000;
    hilbert_filter_order_phase = 8;
    n_msg = 2^3;
    
    d_phase = designfilt('hilbertfir','FilterOrder', hilbert_filter_order_phase, 'TransitionWidth', 1 * Fs / hilbert_filter_order_phase , 'SampleRate',Fs); 
    hilbert_coeffs_phase = round(d_phase.Coefficients .* 2^15) ./2^15;
    grd_phase = hilbert_filter_order_phase/2 ;
    
    for i = 1:n_msg
        for j = 1:4
            aux_y_imag =  conv(y(start_signal_min+nspmsg + (i-1)*ns_rep :start_signal_max+nspmsg+ns_sine + (i-1)*ns_rep ,j),hilbert_coeffs_phase);
            y_imag(j,:,i) = aux_y_imag(grd_phase+1:grd_phase+ns_sine);
            for k = 1:length(y_phase)
                y_phase(j,k,i) = cordic_angle(y(start_signal_min+nspmsg +(i-1)*ns_rep+k-1,j), y_imag(j,k,i)) * pi/180; 
            end
        end
    end    

    phase_diff = nan(6,length(y_phase),n_msg);
    phase_diff_mean = nan(6,n_msg);

    unwrap_var = 0;

    for i = 1:n_msg
        l = 0;
        for j = 1:4
            for k = j+1:4
                l = l + 1;
                phase_diff(l,:,i) = y_phase(j,:,i) - y_phase(k,:,i);

                for m = 2:length(phase_diff(l,:,i))
                    if(y_phase(k,m-1,i) > 0 &&  y_phase(k,m,i) < 0)
                        unwrap_var = 1;
                    end
                    if(y_phase(j,m-1,i) > 0 &&  y_phase(j,m,i) < 0)
                        unwrap_var = 0;
                    end
                    if(unwrap_var)
                        phase_diff(l,m,i) = phase_diff(l,m,i) + 2*pi;
                    end
                end
                
                phase_diff(l,:,i) = mod(phase_diff(l,:,i), 2*pi);

                phase_diff_mean(l,i) = mean(phase_diff(l,640:end,i));
                if (phase_diff_mean(l,i) >= pi) 
                    phase_diff_mean(l,i) = phase_diff_mean(l,i) - 2*pi;
                end
                if (phase_diff_mean(l,i) <= -pi)                       
                    phase_diff_mean(l,i) = phase_diff_mean(l,i) + 2*pi;
                end                                                    
            end
        end
    end
%end