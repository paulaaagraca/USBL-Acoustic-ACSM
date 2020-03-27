f_op = 24400;  % operation frequency (Hz) 
T_op = 1/f_op; % operation period (s) 
fs = 1000000;  % sampling frequency 
tp = 0:(1/fs):0.0001;

ping1 = (2^15 - 1)*sin(2*pi*f_op*tp);

ping1_int16 = abs(int16(ping1));

fileID = fopen('sin_in1.txt','w');
for i = 1:(length(ping1_int16)/2)
    if ping1(i) < 0
        fprintf(fileID,'xin1a = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin2a = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin3a = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin4a = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin1 = - xin1a;\n');
        fprintf(fileID,'xin2 = - xin2a;\n');
        fprintf(fileID,'xin3 = - xin3a;\n');
        fprintf(fileID,'xin4 = - xin4a;\n');
        fprintf(fileID,'enable = 1;\n#10\nenable = 0;\n#1900\n\n');
    else 
        fprintf(fileID,'xin1 = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin2 = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin3 = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'xin4 = 16''d%d;\n', ping1_int16(i));
        fprintf(fileID,'enable = 1;\n#10\nenable = 0;\n#1900\n\n');
    end 
end

fclose(fileID);

%figure 
%plot(ping1_int16)