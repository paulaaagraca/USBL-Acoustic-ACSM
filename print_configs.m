cnt = 1;
for i_h2 = 2:7
        h2 = ri(:,i_h2);

        %Loop: all possible hydrophones for h3
        for i_h3 = (i_h2+1):9
            if(i_h2 < i_h3)
                h3 = ri(:,i_h3);
            end

            %Loop: all possible hydrophones for h4
            for i_h4 = (i_h3+1):9
                if(i_h3 < i_h4)
                    h4 = ri(:,i_h4);
                end
                
                fprintf('\\midrule \n');
                fprintf('\\multicolumn{1}{c|}{%d} & 1 & %d & %d & %d \\\\ \n', cnt, i_h2, i_h3, i_h4);
                cnt = cnt+1;
            end
        end
end